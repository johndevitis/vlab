%% Little script to run an nfa
% local directory to find the model
localdir = 'C:\Users\John\Projects_Git\vlab\modules\models\grid';

%% setup st7 file info
sys = st7model();
sys.pathname = localdir;
sys.filename = 'grid1.st7';
sys.scratchpath = 'C:\Temp';

%% setup nfa info
nfa = NFA();
nfa.name = fullfile(sys.pathname,[sys.filename(1:end-4) '.NFA']);
nfa.nmodes = 10; % set number of modes to compute
nfa.run = 1;

% specify experimental dof
nfa.nodeid = [1:5 94 109 150 164 193 358 373 414 428 457 ...
    606 621 662 676 705 859 874 915 929 958];

% run natural frequency solver
APIop = apiOptions();
APIop.keepLoaded = 1;
APIop.keepOpen = 0;

apish(@solver,sys,nfa,APIop)
