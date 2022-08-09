%% Chapter-2 Example-4:
% 2D truss solution with finite element method (FEM)

clc, clear

%% input
% constant variable
A = 3e-4;  % [m^2] link cross-section area
E = 200e9; % [Pa] link elastic module
Mg = 1000; % [N] external force

% define linkage
nodeList = [0,0; 0,1; 1,1; 1,0];      % [m] node list coordinate
linkList = [1,2; 2,3; 3,4; 1,4; 1,3]; % link list (node number)

linkData = zeros(size(linkList,1),6);
for k = 1:size(linkList,1)
    [th,L] = cart2pol(nodeList(linkList(k,2),1)-nodeList(linkList(k,1),1),...
        nodeList(linkList(k,2),2)-nodeList(linkList(k,1),2));
    linkData(k,1) = L;
    linkData(k,2) = th;
    linkData(k,3:end) = [2*(linkList(k,1)-1)+1,...
        2*(linkList(k,1)-1)+2,...
        2*(linkList(k,2)-1)+1,...
        2*(linkList(k,2)-1)+2];
end

% define force & support
forceList = [4 0 -1000];
forceData = zeros(size(forceList,1),2);
for k = 1:size(forceList,1)
    forceData(k,1:end) = [2*(forceList(k,1)-1)+1,...
        2*(forceList(k,1)-1)+2];
end

supportList = [1 1 0; 2 1 1];
supportData = zeros(size(supportList,1),2);
for k = 1:size(supportList,1)
    if supportList(k,2) ==  1
        supportData(k,1) = 2*(supportList(k,1)-1)+1;
    end
    
    if supportList(k,3) ==  1
        supportData(k,2) = 2*(supportList(k,1)-1)+2;
    end
end

%% process
% assemble stiffness matrix
Ktotal = zeros(2*size(nodeList,1));
for k = 1:size(linkList,1)
    
    L = linkData(k,1);
    th = linkData(k,2);
    indexMapping = linkData(k,3:end);
    c = cos(th);
    s = sin(th);
    sc = sin(th)*cos(th);
    
    Kelement = (E*A/L)*...
        [c^2 sc -c^2 -sc;
        sc s^2 -sc -s^2;
        -c^2 -sc c^2 sc;
        -sc -s^2 sc s^2];
    for m = 1:4
        for n = 1:4
            Ktotal(indexMapping(m),indexMapping(n)) = ...
                Ktotal(indexMapping(m),indexMapping(n)) + ...
                Kelement(m,n);
        end
    end
end

% assemble force matrix
Ftotal = zeros(2*size(nodeList,1),1);
for k = 1:size(forceList,1)
    indexMapping = forceData(k,:);
    
    for m = 1:2
        Ftotal(indexMapping(m)) = ...
            Ftotal(indexMapping(m)) + forceList(k,m+1);
    end
end

% implement support constraint
totalIndex = 1:2*size(nodeList,1);
supportIndex = supportData(:);
supportIndex(supportIndex == 0) = [];
totalIndex(supportIndex) = [];
KtotalReduced = Ktotal;
KtotalReduced(supportIndex,:) = [];
KtotalReduced(:,supportIndex) = [];
FtotalReduced = Ftotal;
FtotalReduced(supportIndex,:) = [];

% solve the equation & post process
Ureduced = KtotalReduced\FtotalReduced;

Utotal = zeros(2*size(nodeList,1),1);
Utotal(totalIndex) = Ureduced;
FtotalResult = Ktotal*Utotal;
FtotalResult(abs(FtotalResult)<1e-6) = 0;

linkDelta = zeros(size(linkList,1),1);
linkForce = zeros(size(linkList,1),1);
linkStress = zeros(size(linkList,1),1);
for k = 1:size(linkList,1)
    indexMapping = linkData(k,3:end);
    L = linkData(k,1);
    th = linkData(k,2);
    c = cos(th);
    s = sin(th);
    linkDelta(k) = Utotal(indexMapping(3))*c + ...
        Utotal(indexMapping(4))*s - ...
        Utotal(indexMapping(1))*c - ...
        Utotal(indexMapping(2))*s;
    linkForce(k) = (E*A/L)*linkDelta(k);
    linkStress(k) = linkForce(k)/A;
end

%% visualization
disp('Total External/Support Force:')
formatSpec = 'External/Support force at Node%2.0d x is %4.1f N\n';
fprintf(formatSpec,[(1:4);FtotalResult(1:2:end)'])
disp(' ')
formatSpec = 'External/Support force at Node%2.0d y is %4.1f N\n';
fprintf(formatSpec,[(1:4);FtotalResult(2:2:end)'])
disp(' ')

disp('Link displacement(mm):')
formatSpec = 'Link%2.0d displacement is %2.4f mm\n';
fprintf(formatSpec,[(1:5);(linkDelta*1000)'])
disp(' ')

disp('Link Force(N):')
formatSpec = 'Link%2.0d force is %4.1f N\n';
fprintf(formatSpec,[(1:5);linkForce'])
disp(' ')

disp('Link Stress(MPa):')
formatSpec = 'Link%2.0d stress is %3.2f MPa\n';
fprintf(formatSpec,[(1:5);(linkStress/1e6)'])