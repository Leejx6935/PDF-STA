% Paper Section V-D, equations (14)-(16), (43)-(56).
% Run this SCRIPT in the base workspace; edit P here before simulation.
projectRoot = fileparts(mfilename('fullpath'));
addpath(projectRoot,fullfile(projectRoot,'sfunctions'));
P.M=1; P.B=1; P.N=10; P.L=0.05; P.R=0.5; P.KB=10;
P.x0=[-0.5;-1;0.4]; % physical states [q; dq; I]
P.T=15; P.Tob=3; P.n=3; P.hob=P.Tob/(2*P.n);
P.a=0.4; P.hc=(P.T-P.Tob)/(2*P.n);
P.obsA=2; P.obsB=-1; P.obsC=1; P.l4=0.5;
P.delta1=[0.6;0.6;0.6]; P.delta2=[0.6;0.6;0.6];
P.zh0=zeros(3,1); P.D0=zeros(3,1);
P.signWidth=0; % 0: paper sign; >0: numerical boundary layer, changes theorem
P.refAmplitude=pi/2; P.refDecay=0.1;
P.distAmplitude=0.3; P.distOmega=1;
P.stopTime=20; P.dt=0.001; P.errorTolerance=1e-2;
P.Wob=integral(@(s) exp(2*P.l4*s).*sin(pi*s/P.hob).^2,P.hob,2*P.hob);
P.Wc=integral(@(s) exp(2*P.a*s).*(s-P.hc).^4.*(s-2*P.hc).^4,P.hc,2*P.hc);
assert(P.T>P.Tob && P.Tob>0 && P.dt>0);
assert(P.obsA*P.obsC>P.obsB^2 && P.obsB<0);
assert(all(P.delta1>=0) && all(P.delta2>=0));
assert(P.M>0 && P.L>0 && P.Wc>0 && P.Wob>0);
