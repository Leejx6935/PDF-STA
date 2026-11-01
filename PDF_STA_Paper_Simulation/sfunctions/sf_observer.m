function sf_observer(block)
setup_ports(block,[3 1 6],[3 3 6],[true false false],6);
block.RegBlockMethod('InitializeConditions',@init);
block.RegBlockMethod('Outputs',@outputs);
block.RegBlockMethod('Derivatives',@derivatives);
end
function init(b)
P=b.DialogPrm(1).Data; b.ContStates.Data=[P.zh0;P.D0];
end
function outputs(b)
z=b.ContStates.Data; xi=b.InputPort(1).Data;
b.OutputPort(1).Data=z(1:3); b.OutputPort(2).Data=z(4:6);
e=xi-[0;z(4:5)]-z(1:3);
b.OutputPort(3).Data=reshape([e.';z(4:6).'],6,1);
end
function derivatives(b)
b.Derivatives.Data=observer_rhs(b.CurrentTime,b.ContStates.Data, ...
 b.InputPort(1).Data,b.InputPort(2).Data,b.InputPort(3).Data,b.DialogPrm(1).Data);
end
