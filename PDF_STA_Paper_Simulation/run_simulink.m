function out=run_simulink(modelName,P)
% Run a manually assembled model without persisting solver overrides.
in=Simulink.SimulationInput(modelName);
in=in.setVariable('P',P);
in=in.setModelParameter('StopTime',num2str(P.stopTime),'SolverType','Fixed-step', ...
 'Solver','ode4','FixedStep',num2str(P.dt),'SignalLogging','on');
out=sim(in);
disp(out.logsout.getElementNames);
end
