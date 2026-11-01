function sf_reference(block)
setup_ports(block,[],4,[],0);
block.RegBlockMethod('Outputs',@outputs);
end
function outputs(b)
b.OutputPort(1).Data=reference_signal(b.CurrentTime,b.DialogPrm(1).Data);
end
