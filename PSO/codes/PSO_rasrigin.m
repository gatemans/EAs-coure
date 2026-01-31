clc;
clear all;

func = @(x,y) -20 -(x.^2-10*cos(pi*x))- (y.^2-10*cos(pi*y)); 

% ---------------- PSO Parameters ----------------

lb = -5.12;        % Lower bound 
ub =  5.12;        % Upper bound 

nPOP  = 20;        % particles 
MaxIt = 100;       % iterations 

w  = 0.6;          % Inertia weight:
                   % Controls the influence of previous velocity
                   % 0 < w < 1 ensures a balance between exploration and exploitation

c1 = 1.5;          % Cognitive coefficient:
                   % Controls the particle's tendency to return to its personal best (pBest)

c2 = 1.5;          % Social coefficient:   

%% define particles

x = lb+(ub-lb)*rand(nPOP , 1);
y = lb+(ub-lb)*rand(nPOP , 1);

vx = zeros(nPOP,1);
vy = zeros(nPOP,1);

pBestx = x;
pBesty = y;
pBestVal = func(x,y);


%% Minimazation
[gBestVal , i] = max(pBestVal);
gbestx = x(i);
gbesty = y(i);

hist = zeros(MaxIt,1);


[X ,Y] = meshgrid(-5.12:0.1:5.12 , -5.12:0.1:5.12);
Z = func(X,Y);

figure;
%% main loop
for index = 1:MaxIt
    
    %% -------- PSO CORE --------
    vx = w*vx + c1*rand(nPOP ,1).*(pBestx - x) ...
        + c2*rand(nPOP , 1).*(gbestx - x);

    vy = w*vy + c1*rand(nPOP ,1).*(pBesty - y) ...
        + c2*rand(nPOP , 1).*(gbesty - y);

    x = x+vx;
    y = y+vy;

    x = max(max(x,ub),lb);
    y = max(max(y,ub),lb);

    fval = func(x,y);

    i = fval>pBestVal;
    pBestx(i) = x(i);
    pBesty(i) = y(i);
    pBestVal(i) = fval(i);

    [best_iter ,i] = min(pBestVal);
    if best_iter>gBestVal
        gBestVal = best_iter;
        gbestx = pBestx(i);
        gbesty = pBesty(i);
    end

    hist(index) = gBestVal; 

    %% -------- VISUALIZATION --------
    clf
    subplot(1,3,1)
    surf(X,Y,Z,'EdgeColor','texturemap')
    hold on
    plot3(x,y,func(x,y),'ro','MarkerSize',4)
    plot3(gbestx,gbesty,gBestVal,'kp','MarkerSize',10,'MarkerFaceColor','y')
    title(['Iter = ' num2str(index)])
    view(45,45)
    shading interp

    subplot(1,3,2)
    contour(X,Y,Z)
    hold on
    plot(x,y,'ro','MarkerSize',4)
    plot(gbestx,gbesty,'kp','MarkerSize',10,'MarkerFaceColor','y')
    grid on
    title('w = 0.7      c1 = 1.5        c2=1.5')
    

    subplot(1,3,3)
    semilogy(hist,'LineWidth',1.5)
    grid on
    xlabel('Iteration')
    ylabel('Best Cost')
    title('Convergence Curve - Best Value =' ,num2str(gBestVal));


    drawnow
end

gBestVal
