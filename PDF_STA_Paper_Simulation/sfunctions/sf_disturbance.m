function sf_disturbance(block)
setup_ports(block,[],1,[],0);
block.RegBlockMethod('Outputs',@outputs);
end
function outputs(b)
b.OutputPort(1).Data=disturbance_signal(b.CurrentTime,b.DialogPrm(1).Data);
end
