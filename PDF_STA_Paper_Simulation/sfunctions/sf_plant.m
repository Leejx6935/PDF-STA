function sf_plant(block)
setup_ports(block,[1 1],3,[false false],3);
block.RegBlockMethod('InitializeConditions',@init);
block.RegBlockMethod('Outputs',@outputs);
block.RegBlockMethod('Derivatives',@derivatives);
end
function init(b)
b.ContStates.Data=b.DialogPrm(1).Data.x0;
end
function outputs(b)
b.OutputPort(1).Data=b.ContStates.Data;
end
function derivatives(b)
b.Derivatives.Data=plant_rhs(b.ContStates.Data,b.InputPort(1).Data, ...
 b.InputPort(2).Data,b.DialogPrm(1).Data);
end
