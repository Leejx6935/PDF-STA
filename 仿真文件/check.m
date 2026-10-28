% 作者：OpenAI Codex；2026-10-20；R2025a；纯MATLAB脚本，不依赖Simulink。
% 保持与S函数相同的一拍锁存、前向欧拉/矩形累加及整数采样时延。
% 对象用ode45逐采样区间积分，MaxStep<=Ts_ctrl/10；不会把数字状态送进ode45。
% 实现对照：对象(1)->hydro_core/plant_rhs；控制/观测与S函数共用同一内核。
% 若已执行para，可编辑P字段后运行check；修改h/Ts时须重新计算派生字段。
if ~exist('P','var'), para; end
hydro_core('validate',P);
count=floor(P.T_end/P.Ts_ctrl+1e-9)+1; t=(0:count-1).'*P.Ts_ctrl;
X=zeros(count,4);O=zeros(count,8);TH=zeros(count,5);DBG=zeros(count,32);
UC=zeros(count,1);UA=zeros(count,1);REF=zeros(count,4);ETA=zeros(count,2);
DIST=zeros(count,4);dd_limit=zeros(count,2);acc=zeros(count,1);
tc=cell(count-1,1);xc=cell(count-1,1);
x=P.x0;cs=hydro_core('ctrl_init',P);os=hydro_core('obs_init',P);
completed=true;message='正常到达终止时间';last=0;segments=0;
opt=odeset('RelTol',P.rel_tol,'AbsTol',P.abs_tol, ...
    'MaxStep',P.Ts_plant,'InitialStep',P.Ts_plant, ...
    'Events',@(tt,xx)local_event(tt,xx,P));
for k=1:count
    try
        y=x([1,3,4]);r=hydro_core('ref',t(k),P);
        [xh,dh]=hydro_core('obs_out',os);
        [uc,~,theta]=hydro_core('ctrl_out',cs,P);
        ua=hydro_core('sat',uc,P.u_max);
        % 所有右端使用同一采样时刻旧快照，禁止先更新obs再读新obs给ctrl。
        cn=hydro_core('ctrl_step',cs,t(k),y,r(1:3),[xh;dh],ua,P);
        on=hydro_core('obs_step',os,y,ua,theta,P);
        f=hydro_core('plant_rhs',t(k),x,ua,P);
        [ph2,ph3]=hydro_core('reg',y,xh(2),ua,P);
        eta=[f(2)-P.area/P.mass*(x(3)-x(4))-ph2.'*theta; ...
             f(3)-f(4)-ph3.'*theta];
        [d,dd]=hydro_core('dist',t(k),x,P);
        V=[P.vol0(1)+P.area*x(1);P.vol0(2)-P.area*x(1)];
        d1=d(1)/P.mass;d2=P.beta_true*sum(d(2:3)./V);
        dd2=P.beta_true*(dd(2)/V(1)-d(2)*P.area*x(2)/V(1)^2 ...
             +dd(3)/V(2)+d(3)*P.area*x(2)/V(2)^2);
        X(k,:)=x.';O(k,:)=os.';TH(k,:)=theta.';DBG(k,:)=cn(9:40).';
        UC(k)=uc;UA(k)=ua;REF(k,:)=r.';ETA(k,:)=eta.';
        DIST(k,:)=[d1,d2,d(2),d(3)];dd_limit(k,:)=[dd(1)/P.mass,dd2];
        acc(k)=f(2);last=k;
        if k==count,break;end
        % u[k]保持整个采样区间；cn中的新命令只能在下一个采样点输出。
        [ti,xx,te]=ode45(@(tt,zz)hydro_core('plant_rhs',tt,zz,ua,P), ...
            [t(k),t(k+1)],x,opt);
        segments=segments+1;tc{segments}=ti(2:end);xc{segments}=xx(2:end,:);
        x=xx(end,:).';cs=cn;os=on;
        if ~isempty(te)
            completed=false;message='到达压力/体积/行程检查边界，提前停止';break;
        end
    catch ME
        completed=false;message=ME.message;break;
    end
end
if last==0,error('Hydro:NoData','没有有效采样数据：%s',message);end
t=t(1:last);X=X(1:last,:);O=O(1:last,:);TH=TH(1:last,:);DBG=DBG(1:last,:);
UC=UC(1:last);UA=UA(1:last);REF=REF(1:last,:);ETA=ETA(1:last,:);
DIST=DIST(1:last,:);dd_limit=dd_limit(1:last,:);acc=acc(1:last);
td=[0;vertcat(tc{1:segments})];xd=[P.x0.';vertcat(xc{1:segments})];
ed=zeros(size(td));
for k=1:numel(td)
    rr=hydro_core('ref',td(k),P);ed(k)=xd(k,1)-rr(1);
end
tol=.02*(2*P.stroke_half); % 用户指定满行程2%，不是参考幅值2%
bad=find(abs(ed)>tol,1,'last');
if isempty(bad),settle=0;
elseif bad<numel(td),settle=td(bad+1);
else,settle=NaN;end
max_error=max(abs(ed));vol=[P.vol0(1)+P.area*xd(:,1),P.vol0(2)-P.area*xd(:,1)];
finite_ok=all(isfinite([X(:);O(:);TH(:);DBG(:);UA;UC]));
sat_ok=all(abs(UA)<=P.u_max+1e-12);
pressure_ok=all(xd(:,3:4)>P.press_min & xd(:,3:4)<P.press_max,'all');
volume_ok=all(vol>P.vol_min,'all');
reference_ok=all(abs(REF)<=P.bounds.ref.'+1e-10,'all');
state_ok=all(abs(xd(:,1))<=P.bounds.y_abs) && all(abs(xd(:,2))<=P.bounds.v_abs);
initial_ok=all(abs(P.x0)<=P.bounds.x0_abs) && ...
    all(P.x0(3:4)>P.press_min) && all(P.x0(3:4)<P.press_max);
parameter_ok=all(TH>=P.theta_min.'-1e-9 & TH<=P.theta_max.'+1e-9,'all');
dist_ok=all(abs(DIST)<= [P.bounds.d1,P.bounds.d2,P.bounds.q_abs.']+1e-10,'all') ...
    && all(abs(dd_limit)<=[P.bounds.dd1,P.bounds.dd2]+1e-10,'all');
observer_bound_ok=all(abs(O(:,2)-X(:,2))<=P.bounds.ev_abs);
acc_ok=all(abs(acc)<=P.bounds.La);
sta_gain_ok=P.lambda2>P.bounds.La && ...
    P.lambda1^2>2*P.bounds.La^2/(P.lambda2-P.bounds.La);
result=struct('P',P,'t',t,'x',X,'observer',O,'theta',TH,'debug',DBG, ...
    'u_unsat',UC,'u_applied',UA,'reference',REF,'eta_actual',ETA, ...
    'dense_time',td,'dense_error',ed,'completed',completed,'message',message, ...
    'settling_time',settle,'position_tolerance',tol,'max_error',max_error);
fprintf('\n=== MATLAB数字闭环自检（仅本工况、有限时间窗）===\n');
fprintf('状态：%s；对象积分至 %.6f s\n',message,td(end));
fprintf('误差界：+/- %.3f mm；最大跟踪误差：%.3f mm\n',tol*1e3,max_error*1e3);
fprintf('进入后在剩余记录内保持的时间：%.6g s（NaN表示未达到）\n',settle);
fprintf('全程实际电压限幅检查：%d；命令峰值：%.4g V；采样饱和比例：%.3f%%\n', ...
    sat_ok,max(abs(UC)),100*mean(abs(UC)>P.u_max));
fprintf('存在NaN/Inf：%d；正常完成：%d\n',~finite_ok,completed);
fprintf('压力/体积/状态范围：%d / %d / %d\n',pressure_ok,volume_ok,state_ok);
fprintf('初值/参数投影/扰动/参考界：%d / %d / %d / %d\n',initial_ok,parameter_ok,dist_ok,reference_ok);
fprintf('速度估计误差界/加速度界/STA增益条件：%d / %d / %d\n',observer_bound_ok,acc_ok,sta_gain_ok);
fprintf('候选截止时间 %.3f s；本记录满足：%d\n',P.time.T_goal, ...
    completed && isfinite(settle) && settle<=P.time.T_goal);
fprintf('完整Lyapunov集合、压力不变性、预设时间定理：尚未认证。\n');
fprintf('上述边界检查是数值记录核查，不是连续全域假设的证明。\n');
fprintf('ode45逐采样调用可能较慢；此脚本没有调用Simulink。\n');
figure('Name','Tracking and input');
subplot(3,1,1);plot(t,REF(:,1)*1e3,t,X(:,1)*1e3);ylabel('Position (mm)');legend('reference','plant');grid on;
subplot(3,1,2);plot(td,ed*1e3);yline(tol*1e3,'r--');yline(-tol*1e3,'r--');ylabel('Error (mm)');grid on;
subplot(3,1,3);stairs(t,UC);hold on;stairs(t,UA);yline(P.u_max,'r--');yline(-P.u_max,'r--');
ylabel('Voltage (V)');xlabel('Time (s)');legend('unsaturated','applied');grid on;
figure('Name','Observer and filter');
subplot(4,1,1);plot(t,O(:,2)-X(:,2));ylabel('Velocity error (m/s)');grid on;
subplot(4,1,2);plot(t,ETA(:,1)-O(:,5));ylabel('eta2 residual (m/s^2)');grid on;
subplot(4,1,3);plot(t,ETA(:,2)-O(:,6));ylabel('eta3 residual (Pa/s)');grid on;
subplot(4,1,4);plot(t,DBG(:,5));ylabel('Filter error (Pa)');xlabel('Time (s)');grid on;
figure('Name','Pressures');plot(t,X(:,3:4)/1e6);yline(P.press_min/1e6,'r--');yline(P.press_max/1e6,'r--');
ylabel('Pressure (MPa)');xlabel('Time (s)');legend('P1','P2');grid on;

function [value,isterminal,direction]=local_event(~,x,P)
V=[P.vol0(1)+P.area*x(1);P.vol0(2)-P.area*x(1)];
value=[x(3:4)-P.press_min;P.press_max-x(3:4);V-P.vol_min;P.stroke_half-abs(x(1))];
isterminal=ones(7,1);direction=-ones(7,1);
end
