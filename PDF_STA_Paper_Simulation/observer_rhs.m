function [dz,history]=observer_rhs(t,z,xi,fu,delayed,P)
% z=[zhat(1:3); Dhat(1:3)], equations (45),(46).
% fu=f+g*u; delayed=[e1;D1;e2;D2;e3;D3](t-hob).
zh=z(1:3); D=z(4:6); barz=xi-[0;D(1:2)]; e=barz-zh;
w=[xi(2:3);fu]; dz=zeros(6,1); history=zeros(6,1);
for i=1:3
 k=sta_gains(t,delayed(2*i-1:2*i),i,P);
 if P.signWidth>0, s=max(-1,min(1,e(i)/P.signWidth)); else, s=sign(e(i)); end
 dz(i)=k(1)*sqrt(abs(e(i)))*s+k(2)*e(i)+w(i)-D(i);
 dz(i+3)=-k(3)*s-k(4)*D(i);
 history(2*i-1:2*i)=[e(i);D(i)];
end
end
