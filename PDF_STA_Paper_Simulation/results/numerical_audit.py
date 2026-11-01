"""Independent Python equation audit, NOT MATLAB/Simulink execution evidence."""
from pathlib import Path
import json
import numpy as np
from scipy.integrate import quad
from numba import njit

WO=quad(lambda s:np.exp(s)*np.sin(2*np.pi*s)**2,.5,1)[0]
WC=quad(lambda s:np.exp(.8*s)*(s-2)**4*(s-4)**4,2,4)[0]
LM=(3+np.sqrt(5))/2; LMIN=(3-np.sqrt(5))/2

@njit
def kernel(t,h,k,W,poly):
    if t<0:return 0.,0.,0.
    v=t%(2*h)
    if v<=h:return 0.,0.,0.
    if poly:
        a=v-h; b=v-2*h
        R=a**4*b**4
        Rd=4*a**3*b**4+4*a**4*b**3
        Rdd=12*a*a*b**4+32*a**3*b**3+12*a**4*b*b
    else:
        R=np.sin(np.pi*v/h)**2
        Rd=np.pi/h*np.sin(2*np.pi*v/h)
        Rdd=2*(np.pi/h)**2*np.cos(2*np.pi*v/h)
    E=np.exp(-k*(h-2*v))/W
    return E*R,E*(Rd+2*k*R),E*(Rdd+4*k*Rd+4*k*k*R)

@njit
def hist(t,H,dt,j):
    if t<0:return np.zeros(6)
    q=t/dt; lo=int(np.floor(q+1e-10)); alpha=q-lo
    lo=max(0,min(lo,j-1)); hi=min(lo+1,j-1)
    if j==0:return np.zeros(6)
    return (1-alpha)*H[lo]+alpha*H[hi]

@njit
def evaluate(t,x,od,cd):
    E=np.exp(-.1*t*t); A=1-E; a1=.2*t*E
    a2=(.2-.04*t*t)*E; a3=(-.12*t+.008*t**3)*E
    sn=np.sin(t); cs=np.cos(t); amp=np.pi/2
    r=np.array([sn*A,cs*A+sn*a1,-sn*A+2*cs*a1+sn*a2,-cs*A-3*sn*a1+3*cs*a2+sn*a3])*amp
    q,v,I=x[:3]; zh=x[3:6]; D=x[6:9]
    xi=np.array([q-r[0],v-r[1],-v-10*np.sin(q)+I-r[2]])
    f=-10*np.cos(q)*v-10*I-200*v-r[3]+v+10*np.sin(q)-I
    K,Kd,Kdd=kernel(t-3,2.,.4,WC,True)
    s10=zh[1]+.4*zh[0]+K*cd[0]
    s11=zh[2]+.4*zh[1]+K*cd[1]+Kd*cd[0]
    s20=s11+.4*s10+K*cd[3]
    tail1=.4*zh[2]+K*cd[2]+2*Kd*cd[1]+Kdd*cd[0]
    tail2=.4*s11+K*cd[4]+Kd*cd[3]
    u=(-K*cd[5]-.4*s20-f+D[2]-tail1-tail2)/20
    hc=np.array([zh[0],zh[1],zh[2],s10,s11,s20])
    e=xi-np.array([0.,D[0],D[1]])-zh
    w=np.array([xi[1],xi[2],f+20*u]); dx=np.zeros(9); ho=np.zeros(6)
    for i in range(3):
        ed=od[2*i]; dd=od[2*i+1]; den=np.sqrt(2*dd*dd+ed*ed+1.72)
        l3=(1+8+4*.9+4*.9*.9)/4; l1=2*l3-2
        W1=np.sqrt(LM)*den
        W2=np.sqrt(LM)*(-l1*abs(ed)**1.5-ed*ed+ed*dd+.6*abs(ed)+2*l3*abs(dd)-dd*dd)/den
        ko,kod,_=kernel(t,.5,.5,WO,False)
        if t>=i+1:ko=0.; kod=0.
        k4=.5+2*(ko*W2+kod*W1)/(2*ko*W1+np.sqrt(LMIN)/(2*LM))
        delta=abs(k4)*.6+.6; k3=(9+4*delta+4*delta*delta)/4
        k1=2*k3-2; s=np.sign(e[i])
        dx[i+3]=k1*np.sqrt(abs(e[i]))*s+2*k4*e[i]+w[i]-D[i]
        dx[i+6]=-k3*s-k4*D[i]
        ho[2*i]=e[i]; ho[2*i+1]=D[i]
    d=.3*np.sin(t)
    dx[0]=v; dx[1]=-v-10*np.sin(q)+I+d; dx[2]=20*u-10*I-200*v
    ztrue=xi+np.array([0.,0.,d])
    return dx,ho,hc,u,xi,r,ztrue

@njit
def simulate(dt):
    n=int(round(20/dt))+1; X=np.zeros((n,9)); X[0,:3]=np.array([-.5,-1.,.4])
    HO=np.zeros((n,6)); HC=np.zeros((n,6)); Y=np.zeros((n,11))
    for j in range(n):
        t=j*dt
        od=hist(t-.5,HO,dt,j); cd=hist(t-2,HC,dt,j)
        k1,ho,hc,u,xi,r,zt=evaluate(t,X[j],od,cd)
        HO[j]=ho; HC[j]=hc
        Y[j,0]=u; Y[j,1:4]=xi; Y[j,4:8]=r; Y[j,8:11]=zt-X[j,3:6]
        if j==n-1:break
        od=hist(t+dt/2-.5,HO,dt,j); cd=hist(t+dt/2-2,HC,dt,j)
        k2=evaluate(t+dt/2,X[j]+dt*k1/2,od,cd)[0]
        k3=evaluate(t+dt/2,X[j]+dt*k2/2,od,cd)[0]
        od=hist(t+dt-.5,HO,dt,j); cd=hist(t+dt-2,HC,dt,j)
        k4=evaluate(t+dt,X[j]+dt*k3,od,cd)[0]
        X[j+1]=X[j]+dt*(k1+2*k2+2*k3+k4)/6
    return X,Y

if __name__=='__main__':
    records=[]
    for dt in [.001,.0005,.00025]:
        X,Y=simulate(dt); t=np.arange(len(X))*dt
        assert np.isfinite(X).all()
        m={'dt':dt,'max_abs_error_after_T':float(np.max(np.abs(Y[t>=15,1]))),
           'max_observer_error_after_Tob':np.max(np.abs(Y[t>=3,8:11]),axis=0).tolist(),
           'peak_u':float(np.max(np.abs(Y[:,0])))}
        records.append(m); print(json.dumps(m),flush=True)
    folder=Path(__file__).parent
    (folder/'independent_audit.json').write_text(json.dumps(records,indent=2))
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    fig,ax=plt.subplots(4,1,figsize=(10,10),sharex=True)
    ax[0].plot(t,X[:,0],label='q'); ax[0].plot(t,Y[:,4],'--',label='yd')
    ax[1].plot(t,Y[:,1:4]); ax[2].plot(t,Y[:,8:11]); ax[3].plot(t,Y[:,0])
    for a in ax:a.grid(); a.axvline(15,color='gray',linestyle=':')
    ax[0].legend(); ax[0].set_ylabel('Tracking'); ax[1].set_ylabel('xi')
    ax[2].set_ylabel('Observer error'); ax[3].set_ylabel('u'); ax[3].set_xlabel('Time (s)')
    fig.suptitle('Independent equation audit (Python); not a MATLAB/Simulink run')
    fig.tight_layout(); fig.savefig(folder/'independent_audit.png',dpi=150)
