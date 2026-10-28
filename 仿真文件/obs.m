function obs(block)
% 作者：OpenAI Codex；2026-10-20；R2025a Level-2离散S函数。
% 来源：原式(14),(38)--(43)。Ts=P.Ts_obs；ode4步长<=Ts_ctrl/10。
% 输入1 y_meas(3)=[y;P1;P2]；输入2 u_applied(1)[V]；输入3 theta_hat(5)。
% 输出1 xhat(4)=[xhat1;xhat2;P1_last;P2_last]，物理状态次序。
% 输出2 dhat(4)=[etahat2;etahat3;zo2;zo3]；前两项为集总估计，非纯物理扰动。
% 后两压力通道只是上次测量锁存。Dwork显式保存全部观测状态。
% 实现对照表：公式编号 | 对应代码 | 备注
% (14) | hydro_core.m:76 (local_obs) | 显式前向欧拉；STA积分为矩形累加
% (38),(39),(42) | hydro_core.m:76 (local_obs) | 不冻结积分、不偷用真实速度
% sig^p | hydro_core.m:178 (local_sig) | 小死区近似，连续理想结论不直接沿用
local_setup(block);
end
function local_setup(block)
block.NumDialogPrms=1;block.DialogPrmsTunable={'Nontunable'};
P=block.DialogPrm(1).Data;hydro_core('validate',P);
block.NumInputPorts=3;block.NumOutputPorts=2;
block.SetPreCompInpPortInfoToDynamic;block.SetPreCompOutPortInfoToDynamic;
dims=[P.p,P.m,5];
for j=1:3
    block.InputPort(j).Dimensions=dims(j);block.InputPort(j).DatatypeID=0;
    block.InputPort(j).Complexity='Real';block.InputPort(j).DirectFeedthrough=false;
end
for j=1:2
    block.OutputPort(j).Dimensions=4;block.OutputPort(j).DatatypeID=0;
    block.OutputPort(j).Complexity='Real';
end
block.NumContStates=0;block.SampleTimes=[P.Ts_obs 0];
block.SimStateCompliance='DefaultSimState';
block.RegBlockMethod('PostPropagationSetup',@local_dwork);
block.RegBlockMethod('InitializeConditions',@local_init);
block.RegBlockMethod('Outputs',@local_outputs);
block.RegBlockMethod('Update',@local_update);
end
function local_dwork(block)
block.NumDworks=1;block.Dwork(1).Name='observer_state';
block.Dwork(1).Dimensions=8;block.Dwork(1).DatatypeID=0;
block.Dwork(1).Complexity='Real';block.Dwork(1).UsedAsDiscState=true;
end
function local_init(block)
block.Dwork(1).Data=hydro_core('obs_init',block.DialogPrm(1).Data);
end
function local_outputs(block)
[xh,dh]=hydro_core('obs_out',block.Dwork(1).Data);
block.OutputPort(1).Data=xh;block.OutputPort(2).Data=dh;
end
function local_update(block)
block.Dwork(1).Data=hydro_core('obs_step',block.Dwork(1).Data, ...
    block.InputPort(1).Data,block.InputPort(2).Data, ...
    block.InputPort(3).Data,block.DialogPrm(1).Data);
end
