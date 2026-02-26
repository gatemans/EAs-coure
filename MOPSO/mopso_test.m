clc; clear; close all;

% Read data
data = readtable("data.xlsx");

% Objective values
cost   = data.Cost;
Moment = min([data.M1_pos, data.M2_pos], [], 2);

% Add computed objective to table (IMPORTANT)
data.Moment = Moment;

% MOPSO objectives (both are minimized)
f1 = -Moment;   % maximize Moment
f2 = cost;      % minimize Cost

% MOPSO parameters
nPop  = 30;                 % number of particles
nIter = length(table2cell(data));                % number of iterations

w  = 0.7;                   % inertia weight
c1 = 1.5;                   % cognitive coefficient
c2 = 1.5;                   % social coefficient

nDesigns = height(data);    % number of available designs

% Particle initialization
pos = randi(nDesigns, nPop, 1); 
vel = zeros(nPop,1);

pbest   = pos;
pbest_f = [f1(pos), f2(pos)];

% Pareto archive
archive_pos = [];
archive_f   = [];

% Convergence history 
convergence = zeros(nIter,1);
alpha = 0.5;   

% MOPSO loop
for it = 1:nIter

    for i = 1:nPop

        %% --- Leader selection ---
        if isempty(archive_pos)
            leader = pbest(i);
        else
            leader = archive_pos(randi(numel(archive_pos)));
        end

        %% --- Velocity update ---
        vel(i) = w*vel(i) ...
               + c1*rand*(pbest(i) - pos(i)) ...
               + c2*rand*(leader   - pos(i));

        %% --- Position update (discrete) ---
        pos(i) = round(pos(i) + vel(i));
        pos(i) = max(1, min(nDesigns, pos(i)));

        %% --- Objective evaluation ---
        curr_f = [f1(pos(i)), f2(pos(i))];

        %% --- Personal best update (dominance) ---
        if all(curr_f <= pbest_f(i,:)) && any(curr_f < pbest_f(i,:))
            pbest(i)     = pos(i);
            pbest_f(i,:) = curr_f;
        end

        %% --- Pareto archive update ---
        if isempty(archive_pos)

            archive_pos = pos(i);
            archive_f   = curr_f;

        else
            dominated = false;
            removeIdx = [];

            for k = 1:size(archive_f,1)

                % Archive dominates new solution
                if all(archive_f(k,:) <= curr_f) && any(archive_f(k,:) < curr_f)
                    dominated = true;
                    break
                end

                % New solution dominates archive member
                if all(curr_f <= archive_f(k,:)) && any(curr_f < archive_f(k,:))
                    removeIdx(end+1) = k; 
                end
            end

            if ~dominated
                archive_f(removeIdx,:)   = [];
                archive_pos(removeIdx,:) = [];

                archive_pos(end+1,1) = pos(i);
                archive_f(end+1,:)   = curr_f;
            end
        end
    end

    %% --- Convergence monitoring ---
    if ~isempty(archive_pos)
        M = data.Moment(archive_pos);
        C = data.Cost(archive_pos);

        Mn = (M - min(M)) / (max(M) - min(M) + eps);
        Cn = (C - min(C)) / (max(C) - min(C) + eps);

        convergence(it) = max(alpha*Mn + (1-alpha)*(1-Cn));
    end
end

% Knee point selection 
M = data.Moment(archive_pos);
C = data.Cost(archive_pos);

Mn = (M - min(M)) / (max(M) - min(M) + eps);
Cn = (C - min(C)) / (max(C) - min(C) + eps);

dist = sqrt((1 - Mn).^2 + Cn.^2);
[~, idx] = min(dist);

bestDesign = data(archive_pos(idx), :);

disp('Selected Optimal Design (Knee Point):');
disp(bestDesign);

% Plot results

% Convergence history
figure;
plot(convergence ,'LineWidth',1.5);
xlabel('Iteration');
ylabel('Convergence Index');
title('MOPSO Convergence History');
grid on;

% Pareto front
figure;
scatter(data.Moment, data.Cost);
hold on;
scatter(M, C);
scatter(bestDesign.Moment, bestDesign.Cost,100,'*','LineWidth',3);
xlabel('Moment');
ylabel('Cost');
legend('All Designs','Pareto Front','Selected Knee Point','Location','best');
grid on;
