%% Chapter-4 Example-2:
% compute and visualizatoin  potential and stream lines
% flow of  sink + source + uniform

clc, clear

%% input

dx = 0.1;  % [m] x discretization
dy = 0.1;  % [m] y discretization

mSource = 30;  % source power
mSink = -30;   % sink power
mUniform = 100; % uniform flow speed

xBound = [-2 2]; % [m] x limitation
yBound = [-1 1]; % [m] y limitation

sourceCenter = [-0.5,0]; % [m] center of source
sinkCenter = [0.5,0];    % [m] center of sink

quiverScaleFactor = 0.9;  % quiver plot vector scale
phiContourLevelStep = 40; % contour line step for potential lines
psiContourLevelStep = 40; % contour line step for stream lines

%% process

x = xBound(1):dx:xBound(2);
y = yBound(1):dy:yBound(2);

[X,Y] = meshgrid(x,y);

singularPointIndex = logical(...
    (X == sourceCenter(1)).*(Y == sourceCenter(2))+...
    (X == sinkCenter(1)).*(Y == sinkCenter(2)));

[J,I] = find(singularPointIndex);

% Source
phiSource = (mSource/4*pi)*...
            log((X-sourceCenter(1)).^2+(Y-sourceCenter(2)).^2);
psiSource = (mSource/2*pi)*...
            atan2((Y-sourceCenter(2)),(X-sourceCenter(1)));

% Sink
phiSink = (mSink/4*pi)*...
          log((X-sinkCenter(1)).^2+(Y-sinkCenter(2)).^2);
psiSink = (mSink/2*pi)*...
          atan2(Y-sinkCenter(2),(X-sinkCenter(1)));

% Uniform flow
phiUnifrom = mUniform*X;
psiUniform = mUniform*Y;

phiTotal = phiSource + phiSink + phiUnifrom;
psiTotal = psiSource + psiSink + psiUniform;

for k = 1:numel(I)
    phiTotal(J(k),I(k)) = ...
        1.1*max([...
        phiTotal(J(k)-1,I(k)), phiTotal(J(k)+1,I(k)),...
        phiTotal(J(k),I(k)-1), phiTotal(J(k),I(k)+1)]);
end

[u,v] = gradient(phiTotal,dx,dy);

%% visualization
figure(1)
cla, hold on, box on

rectangle(...
    'Position',...
    [sourceCenter(1)-0.03,sourceCenter(2)-0.03,0.06,0.06],...
    'Curvature',[1,1],...
    'FaceColor','r')
rectangle(...
    'Position',...
    [sinkCenter(1)-0.03,sinkCenter(2)-0.03,0.06,0.06],...
    'Curvature',[1,1],...
    'FaceColor','b')

quiver(X,Y,u,v,...
    'AutoScaleFactor',quiverScaleFactor)

contour(X,Y,abs(psiTotal),...
    'LineStyle','--',...
    'LineWidth',1.5,...
    'LevelStep',psiContourLevelStep)

contour(X,Y,phiTotal,...
    'LineStyle',':',...
    'LineWidth',1.5,...
    'ShowText','on',...
    'LevelStep',phiContourLevelStep)
colormap([0 0 0; 0 0 0])
axis([xBound yBound])
axis equal