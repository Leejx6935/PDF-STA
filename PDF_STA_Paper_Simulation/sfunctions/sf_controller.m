function sf_controller(block)
setup_ports(block,[3 3 1 1 6],[1 6],true(1,5),0);
block.RegBlockMethod('Outputs',@outputs);
end
function outputs(b)
[u,h]=controller_core(b.CurrentTime,b.InputPort(1).Data,b.InputPort(2).Data, ...
 b.InputPort(3).Data,b.InputPort(4).Data,b.InputPort(5).Data,b.DialogPrm(1).Data);
b.OutputPort(1).Data=u; b.OutputPort(2).Data=h;
end
