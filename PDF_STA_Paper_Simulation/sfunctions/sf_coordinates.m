function sf_coordinates(block)
setup_ports(block,[3 4],[3 1 1],[true true],0);
block.RegBlockMethod('Outputs',@outputs);
end
function outputs(b)
[xi,f,g]=coordinate_map(b.InputPort(1).Data,b.InputPort(2).Data,b.DialogPrm(1).Data);
b.OutputPort(1).Data=xi; b.OutputPort(2).Data=f; b.OutputPort(3).Data=g;
end
