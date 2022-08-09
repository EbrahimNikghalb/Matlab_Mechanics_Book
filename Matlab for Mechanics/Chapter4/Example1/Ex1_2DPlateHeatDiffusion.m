%% Chapter-4 Example-1:
% heat diffusion in 2D plate
% explicit form of diffusion equation

clc, clear

%% input

kAl = 202.4;        % [W/(m.C)] Aluminum Heat Conductivity

h = 0.01;           % [m] x,y discretization (h=dx=dy)
alpha = 0.85464e-4; % [m^2/s] diffusion constant

width = 0.2;        % [m] width of plate
height = 0.1;       % [m] length of plate

Tright = 60;        % [C] right temperature
Ttop= 8;            % [C] left temperature
Tdown = 30;         % [C] down BC: constant temperature
qConst = 40;        % [KW/m] constant heat flux

Tinitial = 30;      % [C] plate initial temperature

ts = 30;            % [Sec] simulation time
dt = 0.1;           % [Sec] time discretization
err = 1e-2;         % [C] stop criteria: |T(i+1)-T(i)|

%% process
b = qConst*1000/kAl;
c = alpha*dt/(h^2);

xNodeNo = width/h+1;
yNodeNo = height/h+1;

Tmapk = Tinitial*ones(yNodeNo,xNodeNo);
Tmapk(1,:) = Tdown;
Tmapk(end,:) = Ttop;
Tmapk(:,end) = Tright;
Tmapk(:,1) = Tmapk(:,2)+b*h;

TmapTime = cell(1);
TmapTime{1} = Tmapk;

timeIndex = 1;
for t = dt:dt:ts
    
    TmapkNew = zeros(yNodeNo,xNodeNo);
    Tmapk = TmapTime{timeIndex};
    
    for m = 2:yNodeNo-1
        for n = 2:xNodeNo-1
            TmapkNew(m,n) = Tmapk(m,n) + c*(...
                Tmapk(m-1,n)+...
                Tmapk(m+1,n)+...
                Tmapk(m,n-1)+...
                Tmapk(m,n+1)-...
                4*Tmapk(m,n));
        end
    end
    
    % implement BC
    TmapBC = TmapkNew(:,2)+b*h;
    for m = 2:yNodeNo-1
        TmapkNew(m,1) = Tmapk(m,1) + c*(...
            Tmapk(m-1,1)+...
            Tmapk(m+1,1)+...
            TmapBC(m,1)+...
            Tmapk(m,2)...
            -4*Tmapk(m,1));
    end
    TmapkNew(:,end) = Tright;
    TmapkNew(1,:) = Tdown;
    TmapkNew(end,:) = Ttop;
    
    % check for steady state
    if max(max(abs(TmapkNew-Tmapk))) < err
        break
    end
    
    timeIndex = timeIndex+1;
    TmapTime{timeIndex} = TmapkNew;
    
end

%% visualization
[X,Y] = meshgrid(0:h:width,0:h:height);

figure 
contourf(X,Y,TmapTime{1})
colorbar
axis tight
ax = gca;
ax.NextPlot = 'replacechildren';

for j = 2:numel(TmapTime)
    contourf(X,Y,TmapTime{j})
    title(['t = ' num2str((j-1)*dt) ' Sec'])
    drawnow
end