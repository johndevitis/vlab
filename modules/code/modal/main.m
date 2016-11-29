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
    vibsFRFplot(hs,hh,in,out,w);
    
    % plot equivalent measurement in time domain
    %  this is the impulse response function formed form the same residue
    %  matrix
    fs = 200; % sampling frequency [hz]
    l = 1;    % length of time vector (seconds)
    [hsi,h] = vibsIRF(AA,root,in,out,fs,l);
    vibsIRFplot(hsi,h,in,out,fs,l);
    
    % obligatory phase plot
    vibsPhaseplot(hs,hh,in,out,w);
    
    
    %% modal flexibility
    flex = zeros(size(V,1),size(V,1));  % pre-allocate dof flex
    Ma = 1./Qr;                         % unit ModalA based on unit Qr, based on modal mass=1 (due to normalized eigenvectors)    
    for ii = 1:size(V,2)                % loop modes for flexibility
        tmp = (V(:,ii)*V(:,ii).')/(Ma(ii)*root(ii));
        flex = flex+tmp+conj(tmp);
    end
    %  compare displacements from strand7 model and modal model
    % st7 LSA comparison (unit load at st7 nodeid 94)
    fvec = zeros(size(V,1),1);
    fvec(6) = 1;
    modaldisp = flex*fvec;
    st7disp = -3.759771e-6;
    % modal flex percent difference
    d = (modaldisp(6)-st7disp)/st7disp*100;
    fprintf('Difference in displacement predictions:\t%2.2f%%\n',d);
end
