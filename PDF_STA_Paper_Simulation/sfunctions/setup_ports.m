function setup_ports(block,inDims,outDims,feedthrough,nStates)
% Common Level-2 setup; called only by setup callbacks.
block.NumDialogPrms=1; % P parameter structure
block.DialogPrmsTunable={'Nontunable'};
block.NumInputPorts=numel(inDims); block.NumOutputPorts=numel(outDims);
block.SetPreCompInpPortInfoToDynamic; block.SetPreCompOutPortInfoToDynamic;
for j=1:numel(inDims)
 block.InputPort(j).Dimensions=inDims(j);
 block.InputPort(j).DatatypeID=0; block.InputPort(j).Complexity='Real';
 block.InputPort(j).DirectFeedthrough=feedthrough(j);
end
for j=1:numel(outDims)
 block.OutputPort(j).Dimensions=outDims(j);
 block.OutputPort(j).DatatypeID=0; block.OutputPort(j).Complexity='Real';
end
block.NumContStates=nStates; block.SampleTimes=[0 0];
block.SimStateCompliance='DefaultSimState';
end
