function ctrl(block)
% 作者：OpenAI Codex；2026-10-20；R2025a Level-2离散S函数。
% 来源：原式(78),(83),(88)；U1指令滤波；U2电压；U3投影更新。
% Ts=P.Ts_ctrl；ode4固定步长<=Ts_ctrl/10，默认P.Ts_plant。
% 输入1 y(3)；输入2 reference(3)=[yd;yd_dot;yd_ddot]；
% 输入3 observer_bus(8)=[xhat(4);dhat(4)]；输入4 u_applied(1)[V]。
% 输出1 u_unsat(1)[V]；输出2 debug(32)；输出3 theta_hat(5)。
% 输出完全锁存：u[k]由上一次Update计算，一拍计算延迟是实现近似。
% 输入4是抗饱和回传接口：用于实际输入回归与诊断，没有新增积分冻结。
% 实现对照表：公式编号 | 对应代码 | 备注
% (75)--(77) | hydro_core.m:166 (local_kernel) | 原PDF核，非近似正弦核
% (78),(83),(88) | hydro_core.m:89 (local_ctrl) | Dwork环形历史，整数采样时延
% U1 | hydro_core.m:89 (local_ctrl) | xi前向欧拉，不输入dot(alpha2)
% U2/U3 | hydro_core.m:89 (local_ctrl) | 未饱和输出；实际u回归；欧拉+盒投影
local_setup(block);
end
function local_setup(block)
block.NumDialogPrms=1;block.DialogPrmsTunable={'Nontunable'};
P=block.DialogPrm(1).Data;hydro_core('validate',P);
block.NumInputPorts=4;block.NumOutputPorts=3;
block.SetPreCompInpPortInfoToDynamic;block.SetPreCompOutPortInfoToDynamic;
di=[P.p,P.ref_dim,P.obs_bus_dim,P.m];do=[P.m,P.debug_dim,5];
for j=1:4
    block.InputPort(j).Dimensions=di(j);block.InputPort(j).DatatypeID=0;
    block.InputPort(j).Complexity='Real';block.InputPort(j).DirectFeedthrough=false;
end
for j=1:3
    block.OutputPort(j).Dimensions=do(j);block.OutputPort(j).DatatypeID=0;
    block.OutputPort(j).Complexity='Real';
end
block.NumContStates=0;block.SampleTimes=[P.Ts_ctrl 0];
block.SimStateCompliance='DefaultSimState';
block.RegBlockMethod('PostPropagationSetup',@local_dwork);
block.RegBlockMethod('InitializeConditions',@local_init);
block.RegBlockMethod('Outputs',@local_outputs);
block.RegBlockMethod('Update',@local_update);
end
function local_dwork(block)
P=block.DialogPrm(1).Data;block.NumDworks=1;
block.Dwork(1).Name='controller_state_history';block.Dwork(1).Dimensions=40+4*P.hist_len;
block.Dwork(1).DatatypeID=0;block.Dwork(1).Complexity='Real';
block.Dwork(1).UsedAsDiscState=true;
end
function local_init(block)
block.Dwork(1).Data=hydro_core('ctrl_init',block.DialogPrm(1).Data);
end
function local_outputs(block)
[u,dbg,theta]=hydro_core('ctrl_out',block.Dwork(1).Data,block.DialogPrm(1).Data);
block.OutputPort(1).Data=u;block.OutputPort(2).Data=dbg;block.OutputPort(3).Data=theta;
end
function local_update(block)
block.Dwork(1).Data=hydro_core('ctrl_step',block.Dwork(1).Data,block.CurrentTime, ...
    block.InputPort(1).Data,block.InputPort(2).Data,block.InputPort(3).Data, ...
    block.InputPort(4).Data,block.DialogPrm(1).Data);
end
