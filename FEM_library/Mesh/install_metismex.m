function install_metismex()
%INSTALL_METISMEX installs METIS and METISMEX interface for graph partitioning.
%
%   Requires: CMAKE and GIT
%
%   For further details see:
%   https://github.com/dgleich/metismex

%   This file is part of redbKIT.
%   Copyright (c) 2016, Ecole Polytechnique Federale de Lausanne (EPFL)
%   Author: Federico Negri <federico.negri at epfl.ch> 


reply = input('\nDid you already install CMAKE? \n(check by typing ''cmake --version'' in a terminal) Y/N:','s');
if isempty(reply)
    reply = 'N';
end

if strcmp(reply,'N')
   fprintf('\nPlease install CMAKE before continuing.')
   fprintf('\n\nOn Linux: sudo apt-get install cmake')
   fprintf('\nOn Mac OSX: if you have XCode, go to preferences --> downloads --> command line tools')
   fprintf('\n\nPress Enter to continue\n')
   pause()
end


%% Download METIS
url_metis = 'https://ftp.mcs.anl.gov/pub/petsc/externalpackages/metis-5.1.0-p3.tar.gz';



fprintf('Download and untar metis-5.1.0 from\n%s\n...\n',url_metis);
untar(url_metis);
system("mv metis-5.1.0-p3 metis-5.1.0");
cd metis-5.1.0

% fix file include/metis.h for 64bit arch.
if ~isempty(regexp(computer('arch'),'64'))

    path_terminal = pwd;
    fprintf('\n*****************************************************\n');
    fprintf('ATTENTION: please open a terminal and type:\n%s\n',['cd ',path_terminal]);
    fprintf('\nThen run the following commands (requires CMAKE!):\n')
    fprintf('\nmake config openmp=set  longindex=set doubleprecision=set\n')
    fprintf('make all\n')


    
else
    path_terminal = pwd;
    fprintf('\n*****************************************************\n');
    fprintf('ATTENTION: please open a terminal and type:\n%s\n',['cd ',path_terminal]);
    fprintf('\nThen run the following commands (requires CMAKE!):\n')
    fprintf('\nmake config\n')
    fprintf('make all\n')

end

%% Run cmake

%!make config
%!make all

%% Ask user to open a terminal and run cmake

reply2 = input('\nDid you succeed? Y/N:','s');
if isempty(reply2)
    reply2 = 'N';
end

if strcmp(reply2,'Y')
    
    %% download and install metismex
    fprintf('\nDownload metismex from  https://github.com/Qicang/metismex.git (requires GIT!) ...')
    system('git clone https://github.com/Qicang/metismex.git');
    cd metismex
    
    fprintf('\nCompile metismex ...')
    make config
    make
 
    
    fprintf('\nFinished!\n')
    cd ../../
else
    cd ..
    fprintf('\nAborted, try again.\n')
    
end
end
