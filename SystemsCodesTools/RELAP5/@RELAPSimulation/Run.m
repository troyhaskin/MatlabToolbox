function ExecutionString = Run(RSim)
    
    Path = RSim.SimulationDirectory;
    
    VersionDirectory = [RSim.PathRoot,'\',RSim.VersionDirectory];
    RELAPDirectory   = [VersionDirectory,'\',RSim.RELAPFolder];
    RELAP = [RELAPDirectory,'\','relap5.exe '];
    
    Input     = ['-i ',Path,'\',RSim.InputFileName,' '];
    Output    = ['-o ',Path,'\',RSim.OutputFileName,' '];
    Restart   = ['-r ',Path,'\',RSim.SequentialFileName,' '];
    DARestart = ['-R ',Path,'\',RSim.DirectAccessFileName,' '];
    Plot      = ['-p ',Path,'\',RSim.PlotFileName,' '];
    Strip     = ['-s ',Path,'\',RSim.StripFileName,' '];
    
    Fluids = ['-w ',VersionDirectory,'\',RSim.FluidPropertyDirectory,'\','tpfh2o' ,' ',...
              '-W ',VersionDirectory,'\',RSim.FluidPropertyDirectory,'\','tpfh2on',' ',...
              '-n {} ',...
              '-d ',VersionDirectory,'\',RSim.FluidPropertyDirectory,'\','tpfd2o',' '];
    
    Misc   = strcat({' -'},{'f';'j';'c';'a';'A';'B'},{' '},RELAPDirectory,'\',{'ftb1';'jbinfo';'cdfile';'coupfl';'dumpfl1';'dumpfl2'},{' '});
    Misc   = strcat(Misc{:});
          
    ExecutionString = [RELAP,Input,Output,Restart,DARestart,Plot,Strip,Fluids,Misc];

    fprintf('RELAPSimulation: Handing over control to RELAP5 =======================\n');
    cd(RELAPDirectory);
    system(ExecutionString,'-echo');
    cd(RSim.SimulationDirectory);
    fprintf('RELAPSimulation: Received control from RELAP5 =======================\n');
end
