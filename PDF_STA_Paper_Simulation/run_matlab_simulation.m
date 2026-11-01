function result=run_matlab_simulation(P)
% Fixed-step method of steps, RK4; history sampled on completed steps.
% Shared equation functions with Level-2 blocks, independent of Simulink.
% For parameter changes: para; P.T=...; recompute normalizers by rerunning para
% after editing it. Do not silently reset P in this function.
assert(abs(P.hob/P.dt-round(P.hob/P.dt))<1e-8);
assert(abs(P.hc/P.dt-round(P.hc/P.dt))<1e-8);
assert(P.dt<=min(P.hob,P.hc));
t=(0:P.dt:P.stopTime)'; n=numel(t);
X=zeros(n,9); X(1,:)=[P.x0;P.zh0;P.D0]';
HO=zeros(n,6); HC=zeros(n,6); U=zeros(n,1); XI=zeros(n,3);
R=zeros(n,4); Ztrue=zeros(n,3);
for j=1:n
 [k1,ho,hc,u,xi,r,zt]=evaluate(t(j),X(j,:)');
 HO(j,:)=ho'; HC(j,:)=hc'; U(j)=u; XI(j,:)=xi'; R(j,:)=r'; Ztrue(j,:)=zt';
 if j<n
  k2=evaluate(t(j)+P.dt/2,X(j,:)'+P.dt*k1/2);
  k3=evaluate(t(j)+P.dt/2,X(j,:)'+P.dt*k2/2);
  k4=evaluate(t(j)+P.dt,X(j,:)'+P.dt*k3);
  X(j+1,:)=X(j,:)+P.dt*(k1+2*k2+2*k3+k4)'/6;
  assert(all(isfinite(X(j+1,:))),'Nonfinite trajectory; reduce dt.');
 end
end
result=struct('t',t,'x',X(:,1:3),'zh',X(:,4:6),'D',X(:,7:9), ...
 'u',U,'xi',XI,'r',R,'ztrue',Ztrue,'P',P);
folder=fullfile(fileparts(mfilename('fullpath')),'results');
save(fullfile(folder,'matlab_result.mat'),'result');
analyze_results(result);
 function [dx,ho,hc,u,xi,r,zt]=evaluate(time,x)
  od=history(time-P.hob,HO); cd=history(time-P.hc,HC);
  r=reference_signal(time,P); d=disturbance_signal(time,P);
  [xi,f,g]=coordinate_map(x(1:3),r,P);
  [u,hc]=controller_core(time,x(4:6),x(7:9),f,g,cd,P);
  [do,ho]=observer_rhs(time,x(4:9),xi,f+g*u,od,P);
  dx=[plant_rhs(x(1:3),u,d,P);do];
  zt=xi+[0;0;d/P.M];
 end
 function h=history(time,H)
  if time<0, h=zeros(6,1); return; end
  q=time/P.dt+1; lo=floor(q+1e-10); alpha=q-lo;
  lo=max(1,min(lo,j-1)); hi=min(lo+1,j-1);
  if j<=1, h=zeros(6,1); else, h=((1-alpha)*H(lo,:)+alpha*H(hi,:))'; end
 end
end
