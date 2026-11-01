function metrics=analyze_results(result)
% No claim of exact finite-time equality from sampled floating-point traces.
t=result.t; P=result.P; idx=t>=P.T;
metrics.maxTrackingAfterT=max(abs(result.xi(idx,1)));
metrics.rmsTrackingAfterT=sqrt(mean(result.xi(idx,1).^2));
metrics.peakControl=max(abs(result.u));
metrics.inputEnergy=trapz(t,result.u.^2);
metrics.maxObserverAfterTob=max(abs(result.ztrue(t>=P.Tob,:)-result.zh(t>=P.Tob,:)),[],1);
last=find(abs(result.xi(:,1))>P.errorTolerance,1,'last');
if isempty(last), metrics.sampledSettlingTime=0;
elseif last==numel(t), metrics.sampledSettlingTime=NaN;
else, metrics.sampledSettlingTime=t(last+1); end
disp(metrics);
folder=fullfile(fileparts(mfilename('fullpath')),'results');
save(fullfile(folder,'metrics.mat'),'metrics');
f=figure('Name','Paper Section V-D'); tiledlayout(4,1);
nexttile; plot(t,[result.x(:,1),result.r(:,1)]); xline(P.T); legend('q','yd'); grid on;
nexttile; plot(t,result.xi); xline(P.T); legend('xi1','xi2','xi3'); grid on;
nexttile; plot(t,result.ztrue-result.zh); xline(P.Tob); legend('z1 error','z2 error','z3 error'); grid on;
nexttile; plot(t,result.u); ylabel('u'); xlabel('Time (s)'); grid on;
exportgraphics(f,fullfile(folder,'matlab_summary.png'));
end
