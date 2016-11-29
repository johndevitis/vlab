function main()
%% main
% 
% 
% 
% author: john devitis
% create date: 29-Nov-2016 09:48:39
	
	load grid1_nfa
    
    % extract vertical modal dof and natural frequencies
    V = squeeze(nfa.U(:,3,:));
    F = nfa.freq;
    
    % get FRF matrix of size [no x ni x ns]
    %  note - without specifiying input & output dof, default to all
    [HH,AA,Wn,Qr,root,w] = nfa2frf(V,F); 
	
	% plot FRF measurement with contribution from each mode
    in = 6; out = 6;
    [hs,hh] = vibsFRF(AA,root,in,out,w);
    fh = vibsFRFplot(hs,hh,in,out,w);
    
    % plot equivalent measurement in time domain
    %  this is the impulse response function formed form the same residue
    %  matrix
    fs = 200; % sampling frequency [hz]
    l = 1;    % length of time vector (seconds)
    [hs,h] = vibsIRF(AA,root,in,out,fs,l);
    fh = vibsIRFplot(hs,h,in,out,fs,l);
end
