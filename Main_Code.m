%% Temperature over time
clear ll;
clf;
T_plot_1 = cat(1,T_all(1:30), nan(30,1));   % First segment (blue)
T_plot_2 = cat(1,T_all(31:60), nan(10,1));  % Second segment (red)
T_plot_3 = T_all(61:90);               % Third segment (green)
years = (1971:2100)'; % Years
% Plot each segment separately with different colors and thicker lines
hold on
plot(years(1:60), T_plot_1, 'Color', [100/255, 143/255, 255/255] , 'LineWidth', 2); % Blue for first segment
plot(years(61:100), T_plot_2, 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); % Red for second segment
plot(years(101:130), T_plot_3, 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); % Green for third segment
hold off
% Set axis properties
set(gca, 'fontsize', 22, ...
         'xtick', [1971 2000 2031 2060 2071 2100], ...
         'ytick', 280.15:1:288.15, ...
         'yticklabels', ["7" "8" "9" "10" "11" "12" "13" "14" "15"], ...
         'GridColor', [0.5, 0.5, 0.5]); % Light grey grid color
%xlabel('Years (a)'); 
ylabel('Average annual temperature (°C)'); 
% Place the "(b)" label in the top-left corner
% text(0.02, 1.03, 'b)', 'Units', 'normalized', ...
%      'FontSize', 60, 'FontWeight', 'bold', ...
%      'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
grid on;
box on;
xtickangle(45);
xlim([1970 2101]);
% Set the figure size (width and height in inches)
figure_width = 7.3; % in inches
figure_height = 6; % in inches

% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/temperature_plot.png', '-dpng', '-r300');
%% Plotting the fit of the 90% left-censoring threshold
clear ll;
clf;
a =mean(fit_smev,2);
plot(1:42,a,'LineWidth', 2,'Color',[100/255, 143/255, 255/255]);
set(gca,'fontsize',22,'xtick',1:20:42,'xticklabels',["45,8" "51,6" "57,4"],'ytick',2:4:30,'yticklabels',2:4:30); 
xlabel('Latitude (°N)'); ylabel('#Rx1h events outside the 90% CI'); 
xlim([0 43]);
% text(0.02, 1.03, 'c)', 'Units', 'normalized', ...
%      'FontSize', 60, 'FontWeight', 'bold', ...
%      'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
box on;
% Set the figure size (width and height in inches)
figure_width = 7.3; % in inches
figure_height = 6; % in inches

% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/SMEV_fit.png', '-dpng', '-r300');
%% GEV return levels
% Special Functiion: plottingPositions
RP = 5:5:200;
M=numel(squeeze(AMS(1,1,:)));
eRP = 1./(1-plottingPositions(M));
sortAMS = sort(AMS,3);
newAMS= squeeze(median(sortAMS,[1 2]));

eRP30 = 1./(1-plottingPositions(30));
sortAMS1 = sort(AMS(:,:,1:30),3);
newAMS1= squeeze(median(sortAMS1,[1 2]));
sortAMS2 = sort(AMS(:,:,31:60),3);
newAMS2= squeeze(median(sortAMS2,[1 2]));
sortAMS3 = sort(AMS(:,:,61:90),3);
newAMS3= squeeze(median(sortAMS3,[1 2]));

ll(1)=plot(log(RP),squeeze(median(GEV_RL(:,:,1,:),[1 2])),'-','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(2)=plot(log(RP),squeeze(median(GEV_RL(:,:,2,:),[1 2])),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(3)=plot(log(RP),squeeze(median(GEV_RL(:,:,3,:),[1 2])),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2); 
%ll(6)=plot(log(eRP30),newAMS1,'.','color','b','MarkerSize', 20); 
%ll(7)=plot(log(eRP30),newAMS2,'.','color','g','MarkerSize', 20); 
%ll(8)=plot(log(eRP30),newAMS3,'.','color','r','MarkerSize', 20); 
set(gca,'fontsize',18,'xtick',log([5 12.6 31.6 79.5 200]),'XTickLabel', ["5" "13" "32" "80" "200"],'ytick',-20:20:220); 
xlims = [log(5), log(200)];
ylims = [20, 90];
% Custom X grid (solid)
for xt = (linspace((xlims(1)), (xlims(2)), 5))
    line([xt xt], ylims, 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end

% Custom X grid (dashed)
for xt = log([6.9 8.8 10.7 17.35 22.1 26.85 43.575 55.55 67.525 109.625 139.75 169.875])
    line([xt xt], ylims, 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end

% Custom Y grid (solid)
for yt = -20:20:220
    line((xlims), [yt yt], 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end

% Custom Y grid (dashed)
for yt = 15:5:85
    line((xlims), [yt yt], 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end

xlim([log(5) log(200)]);
ylim([20 90]);
xlabel('RP (a)'); ylabel('RL (mm)'); box on
legend_handles = ll(1:3);
legend_labels = {
    '1971-2000', ...
    '2031-2060', ...
    '2071-2100', ...
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');% Set the figure size (width and height in inches)
uistack(ll, 'top')

figure_width = 7.3; % in inches
figure_height = 6; % in inches
% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/GEV_RL.png', '-dpng', '-r300');
%% SMEV return levels
RP = 5:5:200;
M=numel(squeeze(AMS(1,1,:)));
eRP = 1./(1-plottingPositions(M));
sortAMS = sort(AMS,3);
newAMS= squeeze(median(sortAMS,[1 2]));

eRP30 = 1./(1-plottingPositions(30));
sortAMS1 = sort(AMS(:,:,1:30),3);
newAMS1= squeeze(median(sortAMS1,[1 2]));
sortAMS2 = sort(AMS(:,:,31:60),3);
newAMS2= squeeze(median(sortAMS2,[1 2]));
sortAMS3 = sort(AMS(:,:,61:90),3);
newAMS3= squeeze(median(sortAMS3,[1 2]));

ll(1)=plot(log(RP),squeeze(median(SMEV_RL(:,:,1,:),[1 2])),'-','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(2)=plot(log(RP),squeeze(median(SMEV_RL(:,:,2,:),[1 2])),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(3)=plot(log(RP),squeeze(median(SMEV_RL(:,:,3,:),[1 2])),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2); 
%ll(6)=plot(log(eRP30),newAMS1,'.','color','b','MarkerSize', 20); 
%ll(7)=plot(log(eRP30),newAMS2,'.','color','g','MarkerSize', 20); 
%ll(8)=plot(log(eRP30),newAMS3,'.','color','r','MarkerSize', 20); 
set(gca,'fontsize',18,'xtick',log([5 12.6 31.6 79.5 200]),'XTickLabel', ["5" "13" "32" "80" "200"],'ytick',-20:20:220); 
xlims = [log(5), log(200)];
ylims = [20, 90];
% Custom X grid (solid)
for xt = (linspace((xlims(1)), (xlims(2)), 5))
    line([xt xt], ylims, 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end

% Custom X grid (dashed)
for xt = log([6.9 8.8 10.7 17.35 22.1 26.85 43.575 55.55 67.525 109.625 139.75 169.875])
    line([xt xt], ylims, 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end

% Custom Y grid (solid)
for yt = -20:20:220
    line((xlims), [yt yt], 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end

% Custom Y grid (dashed)
for yt = 15:5:85
    line((xlims), [yt yt], 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end
xlim([log(5) log(200)]);
ylim([20 90]);
xlabel('RP (a)'); ylabel('RL (mm)'); box on
legend_handles = ll(1:3);
legend_labels = {
    '1971-2000', ...
    '2031-2060', ...
    '2071-2100', ...
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');
figure_width = 7.3; % in inches
figure_height = 6; % in inches
uistack(ll, 'top')

% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/SMEV_RL.png', '-dpng', '-r300');
%% Difference in SMEV - GEV return levels
clear ll
RP = 5:5:200;
M=numel(squeeze(AMS(1,1,:)));
eRP = 1./(1-plottingPositions(M));
sortAMS = sort(AMS,3);
newAMS= squeeze(mean(sortAMS,[1 2]));
ll(1)=plot(log(RP),squeeze(median(SMEV_RL(:,:,1,:)-GEV_RL(:,:,1,:),[1 2])),'-','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(2)=plot(log(RP),squeeze(median(SMEV_RL(:,:,2,:)-GEV_RL(:,:,2,:),[1 2])),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2);
ll(3)=plot(log(RP),squeeze(median(SMEV_RL(:,:,3,:)-GEV_RL(:,:,3,:),[1 2])),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2);
xticks = get(gca, 'XTick');
set(gca,'fontsize',18,'xtick',log([5 12.6 31.6 79.5 200]),'XTickLabel', ["5" "13" "32" "80" "200"],'ytick',-10:2:10); 
xlims= ([log(5) log(200)]);
ylims= ([-4,8]);

xlim([log(5) log(200)]);
ylim([-4,8])
for xt = (linspace((xlims(1)), (xlims(2)), 5))
    line([xt xt], ylims, 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom X grid (dashed)
for xt = log([6.9 8.8 10.7 17.35 22.1 26.85 43.575 55.55 67.525 109.625 139.75 169.875])
    line([xt xt], ylims, 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end
% Custom Y grid (solid)
for yt = -20:20:220
    line((xlims), [yt yt], 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom Y grid (dashed)
for yt = [-6 -4 -2 2 4 6 8]
    line((xlims), [yt yt], 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end
legend(ll,{'1971-2000','2031-2060','2071-2100' },'fontsize',18,'location','southeast')
xlabel('RP (a)'); ylabel('RL difference (mm)'); box on
figure_width = 7.3; % in inches
figure_height = 6; % in inches
uistack(ll, 'top')
% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/Difference_RL.png', '-dpng', '-r300');
%% GEV parameter uncertainty
npar = 3;
Unc = nan(3,npar,5);
Unc(1,:,:) = squeeze(mean(GEV_prm_unc_1(:,:,5,:,:,:),[1 2]));
Unc(2,:,:) = squeeze(mean(GEV_prm_unc_2(:,:,5,:,:,:),[1 2]));
Unc(3,:,:) = squeeze(mean(GEV_prm_unc_3(:,:,5,:,:,:),[1 2]));
y_max = max([Unc(1,:,5)' Unc(2,:,5)' Unc(3,:,5)'],[],2);
y_min = min([Unc(1,:,1)' Unc(2,:,1)' Unc(3,:,1)'],[],2);
Y_diff = y_max-y_min;
% X positions for the 3-4 boxes
x_positions = 1:3;  % This places the boxes at x=1, x=2, and x=3
Title_graph = 'Spatial average 90% CI of the GEV Parameters';
varargin = [{'Shape Parameter'}, {'Scale Parameter'}, {'Location Parameter'}];
Median = squeeze(mean(GEV_prm(:,:,:,:),[1 2]));
ff=figure; 
hold on;
set(ff,'position',[0 0 1200 500]);
for j=1:npar
    subplot(1,3,j);
    xlim([0.5 3.5]);  % Adjust x-axis to show all boxes
    ylim([(y_min(j)-Y_diff(j)*0.2) (y_max(j)+Y_diff(j)*0.2)]);     % Adjust y-axis based on the provided values
    ylabel('Values');
    set(gca, 'XTick', x_positions, 'XTickLabel', {'1971-2000', '2031-2060', '2071-2100'});
    title(varargin(j));
    for i = 1:3
        % Draw the box (Q1 to Q3) using patch
        patch([x_positions(i)-0.1, x_positions(i)-0.1, x_positions(i)+0.1, x_positions(i)+0.1], ...
              [Unc(i,j,1), Unc(i,j,5), Unc(i,j,5), Unc(i,j,1)], 'b', 'FaceAlpha', 0.2); hold on;

        % Draw the median line (Q2)
        plot([x_positions(i)-0.1, x_positions(i)+0.1], [Median(i,j), ...
        Median(i,j)], 'k', 'LineWidth', 2); hold on;

        % Draw the bottom and top lines of the box
        plot([x_positions(i)-0.1, x_positions(i)+0.1], [Unc(i,j,1), Unc(i,j,1)], 'k', 'LineWidth', 1.5);  hold on;% Bottom
        plot([x_positions(i)-0.1, x_positions(i)+0.1], [Unc(i,j,5), Unc(i,j,5)], 'k', 'LineWidth', 1.5);  hold on;% Top
    end
end
sgtitle(Title_graph);
hold off;
%% SMEV parameter uncertainty
npar = 2;
Unc = nan(3,npar,5);
Unc(1,:,:) = squeeze(mean(SMEV_prm_unc_1(:,:,5,:,:,:),[1 2]));
Unc(2,:,:) = squeeze(mean(SMEV_prm_unc_2(:,:,5,:,:,:),[1 2]));
Unc(3,:,:) = squeeze(mean(SMEV_prm_unc_3(:,:,5,:,:,:),[1 2]));
y_max = max([Unc(1,:,5)' Unc(2,:,5)' Unc(3,:,5)'],[],2);
y_min = min([Unc(1,:,1)' Unc(2,:,1)' Unc(3,:,1)'],[],2);
Y_diff = y_max-y_min;
% X positions for the 3-4 boxes
x_positions = 1:3;  % This places the boxes at x=1, x=2, and x=3
Title_graph = 'Spatial average 90% CI of the SMEV Parameters';
varargin = [{'Shape Parameter'}, {'Scale Parameter'}];
Median = squeeze(mean(SMEV_prm(:,:,:,:),[1 2]));
ff=figure; 
hold on;
set(ff,'position',[0 0 1200 500]);
for j=1:npar
    subplot(1,2,j);
    xlim([0.5 3.5]);  % Adjust x-axis to show all boxes
    ylim([(y_min(j)-Y_diff(j)*0.2) (y_max(j)+Y_diff(j)*0.2)]);     % Adjust y-axis based on the provided values
    ylabel('Values');
    set(gca, 'XTick', x_positions, 'XTickLabel', {'1971-2000', '2031-2060', '2071-2100'});
    title(varargin(j));
    for i = 1:3
        % Draw the box (Q1 to Q3) using patch
        patch([x_positions(i)-0.1, x_positions(i)-0.1, x_positions(i)+0.1, x_positions(i)+0.1], ...
              [Unc(i,j,1), Unc(i,j,5), Unc(i,j,5), Unc(i,j,1)], 'b', 'FaceAlpha', 0.2); hold on;

        % Draw the median line (Q2)
        plot([x_positions(i)-0.1, x_positions(i)+0.1], [Median(i,j), ...
        Median(i,j)], 'k', 'LineWidth', 2); hold on;

        % Draw the bottom and top lines of the box
        plot([x_positions(i)-0.1, x_positions(i)+0.1], [Unc(i,j,1), Unc(i,j,1)], 'k', 'LineWidth', 1.5);  hold on;% Bottom
        plot([x_positions(i)-0.1, x_positions(i)+0.1], [Unc(i,j,5), Unc(i,j,5)], 'k', 'LineWidth', 1.5);  hold on;% Top
    end
end
sgtitle(Title_graph);
hold off;
%% Initializing return period
RP = 5:5:200;
eRP30 = 1./(1-plottingPositions(30));
eRP90 = 1./(1-plottingPositions(90));

inv_RP1 = nan(1,numel(eRP30));
for i = 1 : numel(eRP30)
    inv_RP1(i) = 1-1/eRP30(i);
end

inv_RP2 = nan(1,numel(eRP90));
for i = 1 : numel(eRP90)
    inv_RP2(i) = 1-1/eRP90(i);
end

inv_RP3 = nan(1,numel(RP));
for i = 1 : numel(RP)
    inv_RP3(i) = 1-1/RP(i);
end
[sortedAMS, sortIndices] = sort(AMS, 3);
[sortedAMS1, sortIndices1] = sort(AMS(:,:,1:30), 3);
[sortedAMS2, sortIndices2] = sort(AMS(:,:,31:60), 3);
[sortedAMS3, sortIndices3] = sort(AMS(:,:,61:90), 3);
%% Calculating the RL of the nsGEV and nsSMEV based on temperature values T_values
% Special functions used: SMEV_inversion
vguess = 10.^(log10(0.1):.05:log10(5e2));
T_values = min(T_all):0.1:max(T_all);
%T_values = [281.15 282.15 283.15 284.15 285.15 286.15];
%mean_nsGEV_RL_T_1 = nan(numel(RP),numel(T_values));
%mean_nsGEV_RL_T_2 = nan(numel(RP),numel(T_values));
%mean_nsGEV_RL_T_3 = nan(numel(RP),numel(T_values));
mean_nsGEV_RL_T_4 = nan(numel(RP),numel(T_values));
%mean_nsSMEV_RL_T_1 = nan(numel(RP),numel(T_values));
%mean_nsSMEV_RL_T_2 = nan(numel(RP),numel(T_values));
%mean_nsSMEV_RL_T_3 = nan(numel(RP),numel(T_values));
mean_nsSMEV_RL_T_4 = nan(numel(RP),numel(T_values));

for i=1:numel(RP)
    for k=1:numel(T_values)
%        mean_nsSMEV_RL_T_1(i,k) = SMEV_inversion([squeeze(median(nsSMEV_prm(:,:,1,2),[1,2]))*exp(T_values(k)*squeeze(median(nsSMEV_prm(:,:,1,3),[1,2]))) squeeze(median(nsSMEV_prm(:,:,1,1),[1,2])) squeeze(median(n0_per(:,:,1),[1,2])) + squeeze(median(n1_per(:,:,1),[1,2]))*T_values(k)],RP(i),vguess);
%        mean_nsSMEV_RL_T_2(i,k) = SMEV_inversion([squeeze(median(nsSMEV_prm(:,:,2,2),[1,2]))*exp(T_values(k)*squeeze(median(nsSMEV_prm(:,:,2,3),[1,2]))) squeeze(median(nsSMEV_prm(:,:,2,1),[1,2])) squeeze(median(n0_per(:,:,2),[1,2])) + squeeze(median(n1_per(:,:,2),[1,2]))*T_values(k)],RP(i),vguess);
%        mean_nsSMEV_RL_T_3(i,k) = SMEV_inversion([squeeze(median(nsSMEV_prm(:,:,3,2),[1,2]))*exp(T_values(k)*squeeze(median(nsSMEV_prm(:,:,3,3),[1,2]))) squeeze(median(nsSMEV_prm(:,:,3,1),[1,2])) squeeze(median(n0_per(:,:,3),[1,2])) + squeeze(median(n1_per(:,:,3),[1,2]))*T_values(k)],RP(i),vguess);
        mean_nsSMEV_RL_T_4(i,k) = SMEV_inversion([squeeze(median(nsSMEV_prm(:,:,4,2),[1,2]))*exp(T_values(k)*squeeze(median(nsSMEV_prm(:,:,4,3),[1,2]))) squeeze(median(nsSMEV_prm(:,:,4,1),[1,2])) squeeze(median(n0_per(:,:,4),[1,2])) + squeeze(median(n1_per(:,:,4),[1,2]))*T_values(k)],RP(i),vguess);
%        mean_nsGEV_RL_T_1(i,k) = gevinv(inv_RP3(i),squeeze(median(nsGEV_prm(:,:,1,1),[1,2])),squeeze(median(nsGEV_prm(:,:,1,2),[1,2])),squeeze(median(nsGEV_prm(:,:,1,3),[1,2]))+squeeze(median(nsGEV_prm(:,:,1,4),[1,2]))*T_values(k));
%        mean_nsGEV_RL_T_2(i,k) = gevinv(inv_RP3(i),squeeze(median(nsGEV_prm(:,:,2,1),[1,2])),squeeze(median(nsGEV_prm(:,:,2,2),[1,2])),squeeze(median(nsGEV_prm(:,:,2,3),[1,2]))+squeeze(median(nsGEV_prm(:,:,2,4),[1,2]))*T_values(k));
%        mean_nsGEV_RL_T_3(i,k) = gevinv(inv_RP3(i),squeeze(median(nsGEV_prm(:,:,3,1),[1,2])),squeeze(median(nsGEV_prm(:,:,3,2),[1,2])),squeeze(median(nsGEV_prm(:,:,3,3),[1,2]))+squeeze(median(nsGEV_prm(:,:,3,4),[1,2]))*T_values(k));
        mean_nsGEV_RL_T_4(i,k) = gevinv(inv_RP3(i),squeeze(median(nsGEV_prm(:,:,4,1),[1,2])),squeeze(median(nsGEV_prm(:,:,4,2),[1,2])),squeeze(median(nsGEV_prm(:,:,4,3),[1,2]))+squeeze(median(nsGEV_prm(:,:,4,4),[1,2]))*T_values(k));
    end
end
%% non-stationary 100 year return levels for all temperatures

vguess = 10.^(log10(0.1):.05:log10(5e2));
nsGEV_RL_T_100 = nan(423,415,4,numel(T_all));
nsSMEV_RL_T_100 = nan(423,415,4,numel(T_all));
for p=1:423
    for q=1:415
        for i=1:4
            for k=1:numel(T_all)
                nsSMEV_RL_T_100(p,q,i,k) = SMEV_inversion([nsSMEV_prm(p,q,i,2)*exp(T_all(k)*nsSMEV_prm(p,q,i,3)) nsSMEV_prm(p,q,i,1) n0_per(p,q,i)+n1_per(p,q,i)*T_all(k)],100,vguess);
                nsGEV_RL_T_100(p,q,i,k) = gevinv(1-1/100,nsGEV_prm(p,q,i,1),nsGEV_prm(p,q,i,2),nsGEV_prm(p,q,i,3)+nsGEV_prm(p,q,i,4)*T_all(k));
            end
        end
    end
end
%% Mean 100 year return levels
mean_nsSMEV_RL_T_100 = squeeze(mean(real(nsSMEV_RL_T_100),[1 2]));
mean_nsGEV_RL_T_100 = squeeze(mean(nsGEV_RL_T_100,[1 2]));

temp = squeeze(mean(SMEV_RL,[1 2]));
mean_RL_SMEV = temp(:,20);
temp = squeeze(mean(GEV_RL,[1 2]));
mean_RL_GEV = temp(:,20);
%% Visualizing nsSMEV 100 year return levels for all temperatures
clear ll;

t1 = mean_nsSMEV_RL_T_100(1,:);
t2 = mean_nsSMEV_RL_T_100(2,:);
t3 = mean_nsSMEV_RL_T_100(3,:);

% Fit exponential: log(y) = log(a) + b*x
p1 = polyfit(T_all(1:30), log(t1(1:30)), 1);
p2 = polyfit(T_all(31:60), log(t2(31:60)), 1);
p3 = polyfit(T_all(61:90), log(t3(61:90)), 1);
p4 = polyfit(T_all, log(mean_nsSMEV_RL_T_100(4,:)), 1);
x1_fit = linspace(min(T_all(1:30)), max(T_all(1:30)), 200);
x2_fit = linspace(min(T_all(31:60)), max(T_all(31:60)), 200);
x3_fit = linspace(min(T_all(61:90)), max(T_all(61:90)), 200);
x4_fit = linspace(min(T_all), max(T_all), 200);
y1_fit = exp(p1(2)) * exp(p1(1) * x1_fit);
y2_fit = exp(p2(2)) * exp(p2(1) * x2_fit);
y3_fit = exp(p3(2)) * exp(p3(1) * x3_fit);
y4_fit = exp(p4(2)) * exp(p4(1) * x4_fit);

ll(1) = plot(x1_fit, y1_fit, '-', 'Color', [100/255, 143/255, 255/255], 'LineWidth', 2); hold on
ll(4) = plot(x1_fit, mean_RL_SMEV(1) * ones(200,1), '--', 'Color', [100/255, 143/255, 255/255], 'LineWidth', 2); hold on
ll(2) = plot(x2_fit, y2_fit, '-', 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); hold on
ll(5) = plot(x2_fit, mean_RL_SMEV(2) * ones(200,1), '--', 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); hold on
ll(3) = plot(x3_fit, y3_fit, '-', 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); hold on
ll(6) = plot(x3_fit, mean_RL_SMEV(3) * ones(200,1), '--', 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); hold on
ll(4) = plot(x4_fit, y4_fit, '-', 'Color', 'k', 'LineWidth', 2); hold on
ll(7) = plot(x4_fit, mean_RL_SMEV(4) * ones(200,1), '--', 'Color', 'k', 'LineWidth', 2); hold on

% Axes limits
ylim([50 80]);
xlim([min(T_all), max(T_all)]);  % Fixed typo here

% Labels and title
xlabel('Spatial average annual temperature (°C)', 'FontSize', 18);
ylabel('RL (mm)', 'FontSize', 18);
box on;

% Legend (matching all 4 curves now)
legend_handles = ll(1:4);
legend_labels = {
    '1971-2000', ...
    '2031-2060', ...
    '2061-2090', ...
    'All periods combined'
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');

% Figure size
figure_width = 7.3; % inches
figure_height = 6;  % inches
xticks(280.15:290.15);
xticklabels(7:17);
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Major & minor grid lines
grid on;                      % Major grid
ax = gca;                     % Get axes handle
ax.FontSize = 18;

print(gcf, 'Matlab_Plots/nsSMEV_RL_100.png', '-dpng', '-r300');
%% Visualizing nsGEV 100-year return levels for all temperatures
clear ll;

t1 = mean_nsGEV_RL_T_100(1,:);
t2 = mean_nsGEV_RL_T_100(2,:);
t3 = mean_nsGEV_RL_T_100(3,:);

% Fit exponential: log(y) = log(a) + b*x
p1 = polyfit(T_all(1:30), log(t1(1:30)), 1);
p2 = polyfit(T_all(31:60), log(t2(31:60)), 1);
p3 = polyfit(T_all(61:90), log(t3(61:90)), 1);
p4 = polyfit(T_all, log(mean_nsGEV_RL_T_100(4,:)), 1);
x1_fit = linspace(min(T_all(1:30)), max(T_all(1:30)), 200);
x2_fit = linspace(min(T_all(31:60)), max(T_all(31:60)), 200);
x3_fit = linspace(min(T_all(61:90)), max(T_all(61:90)), 200);
x4_fit = linspace(min(T_all), max(T_all), 200);
y1_fit = exp(p1(2)) * exp(p1(1) * x1_fit);
y2_fit = exp(p2(2)) * exp(p2(1) * x2_fit);
y3_fit = exp(p3(2)) * exp(p3(1) * x3_fit);
y4_fit = exp(p4(2)) * exp(p4(1) * x4_fit);

ll(1) = plot(x1_fit, y1_fit, '-', 'Color', [100/255, 143/255, 255/255], 'LineWidth', 2); hold on
ll(4) = plot(x1_fit, mean_RL_GEV(1) * ones(200,1), '--', 'Color', [100/255, 143/255, 255/255], 'LineWidth', 2); hold on
ll(2) = plot(x2_fit, y2_fit, '-', 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); hold on
ll(5) = plot(x2_fit, mean_RL_GEV(2) * ones(200,1), '--', 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); hold on
ll(3) = plot(x3_fit, y3_fit, '-', 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); hold on
ll(6) = plot(x3_fit, mean_RL_GEV(3) * ones(200,1), '--', 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); hold on
ll(4) = plot(x4_fit, y4_fit, '-', 'Color', 'k', 'LineWidth', 2); hold on
ll(7) = plot(x4_fit, mean_RL_GEV(4) * ones(200,1), '--', 'Color', 'k', 'LineWidth', 2); hold on

% Axes limits
ylim([50 80]);
xlim([min(T_all), max(T_all)]);  % Fixed typo here

% Labels and title
xlabel('Spatial average annual temperature (°C)', 'FontSize', 18);
ylabel('RL (mm)', 'FontSize', 18);
box on;

% Legend (matching all 4 curves now)
legend_handles = ll(1:4);
legend_labels = {
    '1971-2000', ...
    '2031-2060', ...
    '2061-2090', ...
    'All periods combined'
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');

% Figure size
figure_width = 7.3; % inches
figure_height = 6;  % inches
xticks(280.15:290.15);
xticklabels(7:17);
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Major & minor grid lines
grid on;                      % Major grid
ax = gca;                     % Get axes handle
ax.FontSize = 18;

print(gcf, 'Matlab_Plots/nsGEV_RL_100.png', '-dpng', '-r300');
%% Median 100 year RL
median_nsSMEV_RL_T_100 = squeeze(median(real(nsSMEV_RL_T_100),[1 2]));
median_nsGEV_RL_T_100 = squeeze(median(nsGEV_RL_T_100,[1 2]));

temp = squeeze(median(SMEV_RL,[1 2]));
median_RL_SMEV = temp(:,20);
temp = squeeze(median(GEV_RL,[1 2]));
median_RL_GEV = temp(:,20);
%% Visualizing nsSMEV median 100 year return levels for all temperatures
clear ll;

t1 = median_nsSMEV_RL_T_100(1,:);
t2 = median_nsSMEV_RL_T_100(2,:);
t3 = median_nsSMEV_RL_T_100(3,:);

% Fit exponential: log(y) = log(a) + b*x
p1 = polyfit(T_all(1:30), log(t1(1:30)), 1);
p2 = polyfit(T_all(31:60), log(t2(31:60)), 1);
p3 = polyfit(T_all(61:90), log(t3(61:90)), 1);
p4 = polyfit(T_all, log(median_nsSMEV_RL_T_100(4,:)), 1);
x1_fit = linspace(min(T_all(1:30)), max(T_all(1:30)), 200);
x2_fit = linspace(min(T_all(31:60)), max(T_all(31:60)), 200);
x3_fit = linspace(min(T_all(61:90)), max(T_all(61:90)), 200);
x4_fit = linspace(min(T_all), max(T_all), 200);
y1_fit = exp(p1(2)) * exp(p1(1) * x1_fit);
y2_fit = exp(p2(2)) * exp(p2(1) * x2_fit);
y3_fit = exp(p3(2)) * exp(p3(1) * x3_fit);
y4_fit = exp(p4(2)) * exp(p4(1) * x4_fit);

ll(1) = plot(x1_fit, y1_fit, '-', 'Color', [100/255, 143/255, 255/255], 'LineWidth', 2); hold on
ll(4) = plot(x1_fit, median_RL_SMEV(1) * ones(200,1), '--', 'Color', [100/255, 143/255, 255/255], 'LineWidth', 2); hold on
ll(2) = plot(x2_fit, y2_fit, '-', 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); hold on
ll(5) = plot(x2_fit, median_RL_SMEV(2) * ones(200,1), '--', 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); hold on
ll(3) = plot(x3_fit, y3_fit, '-', 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); hold on
ll(6) = plot(x3_fit, median_RL_SMEV(3) * ones(200,1), '--', 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); hold on
ll(4) = plot(x4_fit, y4_fit, '-', 'Color', 'k', 'LineWidth', 2); hold on
ll(7) = plot(x4_fit, median_RL_SMEV(4) * ones(200,1), '--', 'Color', 'k', 'LineWidth', 2); hold on

% Axes limits
ylim([50 80]);
xlim([min(T_all), max(T_all)]);  % Fixed typo here

% Labels and title
xlabel('Spatial average annual temperature (°C)', 'FontSize', 18);
ylabel('RL (mm)', 'FontSize', 18);
box on;

% Legend (matching all 4 curves now)
legend_handles = ll(1:4);
legend_labels = {
    '1971-2000', ...
    '2031-2060', ...
    '2061-2090', ...
    'All periods combined'
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');

% Figure size
figure_width = 7.3; % inches
figure_height = 6;  % inches
xticks(280.15:290.15);
xticklabels(7:17);
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Major & minor grid lines
grid on;                      % Major grid
ax = gca;                     % Get axes handle
ax.FontSize = 18;

print(gcf, 'Matlab_Plots/nsSMEV_RL_median_100.png', '-dpng', '-r300');
%% Visualizing nsGEV median 100-year return levels for all temperatures
clear ll;

t1 = median_nsGEV_RL_T_100(1,:);
t2 = median_nsGEV_RL_T_100(2,:);
t3 = median_nsGEV_RL_T_100(3,:);

% Fit exponential: log(y) = log(a) + b*x
p1 = polyfit(T_all(1:30), log(t1(1:30)), 1);
p2 = polyfit(T_all(31:60), log(t2(31:60)), 1);
p3 = polyfit(T_all(61:90), log(t3(61:90)), 1);
p4 = polyfit(T_all, log(median_nsGEV_RL_T_100(4,:)), 1);
x1_fit = linspace(min(T_all(1:30)), max(T_all(1:30)), 200);
x2_fit = linspace(min(T_all(31:60)), max(T_all(31:60)), 200);
x3_fit = linspace(min(T_all(61:90)), max(T_all(61:90)), 200);
x4_fit = linspace(min(T_all), max(T_all), 200);
y1_fit = exp(p1(2)) * exp(p1(1) * x1_fit);
y2_fit = exp(p2(2)) * exp(p2(1) * x2_fit);
y3_fit = exp(p3(2)) * exp(p3(1) * x3_fit);
y4_fit = exp(p4(2)) * exp(p4(1) * x4_fit);

ll(1) = plot(x1_fit, y1_fit, '-', 'Color', [100/255, 143/255, 255/255], 'LineWidth', 2); hold on
ll(4) = plot(x1_fit, median_RL_GEV(1) * ones(200,1), '--', 'Color', [100/255, 143/255, 255/255], 'LineWidth', 2); hold on
ll(2) = plot(x2_fit, y2_fit, '-', 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); hold on
ll(5) = plot(x2_fit, median_RL_GEV(2) * ones(200,1), '--', 'Color', [0.8627, 0.1490, 0.4980], 'LineWidth', 2); hold on
ll(3) = plot(x3_fit, y3_fit, '-', 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); hold on
ll(6) = plot(x3_fit, median_RL_GEV(3) * ones(200,1), '--', 'Color', [1.0000, 0.6902, 0.0000], 'LineWidth', 2); hold on
ll(4) = plot(x4_fit, y4_fit, '-', 'Color', 'k', 'LineWidth', 2); hold on
ll(7) = plot(x4_fit, median_RL_GEV(4) * ones(200,1), '--', 'Color', 'k', 'LineWidth', 2); hold on

% Axes limits
ylim([50 80]);
xlim([min(T_all), max(T_all)]);  % Fixed typo here

% Labels and title
xlabel('Spatial average annual temperature (°C)', 'FontSize', 18);
ylabel('RL (mm)', 'FontSize', 18);
box on;

% Legend (matching all 4 curves now)
legend_handles = ll(1:4);
legend_labels = {
    '1971-2000', ...
    '2031-2060', ...
    '2061-2090', ...
    'All periods combined'
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');

% Figure size
figure_width = 7.3; % inches
figure_height = 6;  % inches
xticks(280.15:290.15);
xticklabels(7:17);
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Major & minor grid lines
grid on;                      % Major grid
ax = gca;                     % Get axes handle
ax.FontSize = 18;

print(gcf, 'Matlab_Plots/nsGEV_RL_median_100.png', '-dpng', '-r300');
%% Calculating the return levels for the non-stationary distributions for average temperatures in the time periods
RP = 5:5:200;
vguess = 10.^(log10(0.1):.05:log10(5e2));
T_RL = [squeeze(mean(T_all(1:30))) squeeze(mean(T_all(31:60))) squeeze(mean(T_all(61:90)))];
inv_RP3 = nan(1,numel(RP));
for i = 1 : numel(RP)
    inv_RP3(i) = 1-1/RP(i);
end
nsGEV_prm_new = squeeze(median(nsGEV_prm,[1 2]));
nsGEV_RL_new = nan(2,4,40);
nsSMEV_prm_new = squeeze(median(nsSMEV_prm,[1 2]));
nsSMEV_RL_new = nan(2,4,40);
for k=1:3
    nsGEV_RL_new(1,k,:) = gevinv(inv_RP3,nsGEV_prm_new(k,1),nsGEV_prm_new(k,2),nsGEV_prm_new(k,3)+nsGEV_prm_new(k,4)*T_RL(k));
    nsSMEV_RL_new(1,k,:) = SMEV_inversion([nsSMEV_prm_new(k,2)*exp(nsSMEV_prm_new(k,3)*T_RL(k)) nsSMEV_prm_new(k,1) median(n0_per(:,:,k),[1 2])+T_RL(k)*median(n1_per(:,:,k),[1 2])],RP,vguess);
end
for k=1:3
    nsGEV_RL_new(2,k,:) = gevinv(inv_RP3,nsGEV_prm_new(4,1),nsGEV_prm_new(4,2),nsGEV_prm_new(4,3)+nsGEV_prm_new(4,4)*T_RL(k));
    nsSMEV_RL_new(2,k,:) = SMEV_inversion([nsSMEV_prm_new(4,2)*exp(nsSMEV_prm_new(4,3)*T_RL(k)) nsSMEV_prm_new(4,1) median(n0_per(:,:,4),[1 2])+T_RL(k)*median(n1_per(:,:,4),[1 2])],RP,vguess);
end
%% nsGEV return levels for averge temperatures
clear ll;
RP = 5:5:200;
M=numel(squeeze(AMS(1,1,:)));
eRP = 1./(1-plottingPositions(M));
sortAMS = sort(AMS,3);
newAMS= squeeze(median(sortAMS,[1 2]));

eRP30 = 1./(1-plottingPositions(30));
sortAMS1 = sort(AMS(:,:,1:30),3);
newAMS1= squeeze(median(sortAMS1,[1 2]));
sortAMS2 = sort(AMS(:,:,31:60),3);
newAMS2= squeeze(median(sortAMS2,[1 2]));
sortAMS3 = sort(AMS(:,:,61:90),3);
newAMS3= squeeze(median(sortAMS3,[1 2]));

ll(1)=plot(log(RP),squeeze(median(nsGEV_RL(:,:,1,:),[1 2])),'-','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(2)=plot(log(RP),squeeze(median(nsGEV_RL(:,:,2,:),[1 2])),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(3)=plot(log(RP),squeeze(median(nsGEV_RL(:,:,3,:),[1 2])),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2); 
ll(4)=plot(log(RP),squeeze(nsGEV_RL_new(2,1,:)),'--','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(5)=plot(log(RP),squeeze(nsGEV_RL_new(2,2,:)),'--','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(6)=plot(log(RP),squeeze(nsGEV_RL_new(2,3,:)),'--','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2); 
%ll(6)=plot(log(eRP30),newAMS1,'.','color','b','MarkerSize', 20); 
%ll(7)=plot(log(eRP30),newAMS2,'.','color','g','MarkerSize', 20); 
%ll(8)=plot(log(eRP30),newAMS3,'.','color','r','MarkerSize', 20); 

xlim([log(5) log(200)]);
ylim([20 90]);
xlims = xlim;
ylims = ylim;

for xt = (linspace((xlims(1)), (xlims(2)), 5))
    line([xt xt], ylims, 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom X grid (dashed)
for xt = log([6.9 8.8 10.7 17.35 22.1 26.85 43.575 55.55 67.525 109.625 139.75 169.875])
    line([xt xt], ylims, 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end
% Custom Y grid (solid)
for yt = -20:20:220
    line((xlims), [yt yt], 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom Y grid (dashed)
for yt = [-6 -4 -2 2 4 6 8]
    line((xlims), [yt yt], 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end

set(gca,'fontsize',18,'xtick',log([5 12.6 31.6 79.5 200]),'XTickLabel', ["5" "13" "32" "80" "200"],'ytick',-20:20:220); 

xlabel('RP (a)'); ylabel('RL (mm)'); box on
h1 = plot(NaN, NaN, 'o', 'MarkerSize', 10, 'MarkerFaceColor', [100/255, 143/255, 255/255], 'MarkerEdgeColor', 'none');
h2 = plot(NaN, NaN, 'o', 'MarkerSize', 10, 'MarkerFaceColor', [0.8627, 0.1490, 0.4980], 'MarkerEdgeColor', 'none');
h3 = plot(NaN, NaN, 'o', 'MarkerSize', 10, 'MarkerFaceColor', [1.0000, 0.6902, 0.0000], 'MarkerEdgeColor', 'none');

legend_handles = [h1, h2, h3];
legend_labels = {
    'Average 1971-2000 temperature', ...
    'Average 2031-2060 temperature', ...
    'Average 2071-2100 temperature', ...
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');
figure_width = 7.3; % in inches
figure_height = 6; % in inches
set(gca, 'XMinorTick', 'off');
set(gca, 'XGrid', 'off', 'YGrid', 'off'); 
uistack(ll, 'top')
% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/nsGEV_RL.png', '-dpng', '-r300');
%% nsSMEV return levels for averge temperatures
clear ll;
RP = 5:5:200;
M=numel(squeeze(AMS(1,1,:)));
eRP = 1./(1-plottingPositions(M));
sortAMS = sort(AMS,3);
newAMS= squeeze(median(sortAMS,[1 2]));

eRP30 = 1./(1-plottingPositions(30));
sortAMS1 = sort(AMS(:,:,1:30),3);
newAMS1= squeeze(median(sortAMS1,[1 2]));
sortAMS2 = sort(AMS(:,:,31:60),3);
newAMS2= squeeze(median(sortAMS2,[1 2]));
sortAMS3 = sort(AMS(:,:,61:90),3);
newAMS3= squeeze(median(sortAMS3,[1 2]));

ll(1)=plot(log(RP),squeeze(median(nsSMEV_RL(:,:,1,:),[1 2])),'-','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(2)=plot(log(RP),squeeze(median(nsSMEV_RL(:,:,2,:),[1 2])),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(3)=plot(log(RP),squeeze(median(nsSMEV_RL(:,:,3,:),[1 2])),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2);
ll(4)=plot(log(RP),squeeze(nsSMEV_RL_new(2,1,:)),'--','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(5)=plot(log(RP),squeeze(nsSMEV_RL_new(2,2,:)),'--','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(6)=plot(log(RP),squeeze(nsSMEV_RL_new(2,3,:)),'--','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2); 
%ll(6)=plot(log(eRP30),newAMS1,'.','color','b','MarkerSize', 20); 
%ll(7)=plot(log(eRP30),newAMS2,'.','color','g','MarkerSize', 20); 
%ll(8)=plot(log(eRP30),newAMS3,'.','color','r','MarkerSize', 20);

xlim([log(5) log(200)]);
ylim([20 90]);
xlims = xlim;
ylims = ylim;

for xt = (linspace((xlims(1)), (xlims(2)), 5))
    line([xt xt], ylims, 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom X grid (dashed)
for xt = log([6.9 8.8 10.7 17.35 22.1 26.85 43.575 55.55 67.525 109.625 139.75 169.875])
    line([xt xt], ylims, 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end
% Custom Y grid (solid)
for yt = -20:20:220
    line((xlims), [yt yt], 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom Y grid (dashed)
for yt = [-6 -4 -2 2 4 6 8]
    line((xlims), [yt yt], 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end

set(gca,'fontsize',18,'xtick',log([5 12.6 31.6 79.5 200]),'XTickLabel', ["5" "13" "32" "80" "200"],'ytick',-20:20:220); 
xlim([log(5) log(200)]);
ylim([20 90]);
xlabel('RP (a)'); ylabel('RL (mm)'); box on
h1 = plot(NaN, NaN, 'o', 'MarkerSize', 10, 'MarkerFaceColor', [100/255, 143/255, 255/255], 'MarkerEdgeColor', 'none');
h2 = plot(NaN, NaN, 'o', 'MarkerSize', 10, 'MarkerFaceColor', [0.8627, 0.1490, 0.4980], 'MarkerEdgeColor', 'none');
h3 = plot(NaN, NaN, 'o', 'MarkerSize', 10, 'MarkerFaceColor', [1.0000, 0.6902, 0.0000], 'MarkerEdgeColor', 'none');

legend_handles = [h1, h2, h3];
legend_labels = {
    'Average 1971-2000 temperature', ...
    'Average 2031-2060 temperature', ...
    'Average 2071-2100 temperature', ...
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');
figure_width = 7.3; % in inches
figure_height = 6; % in inches
set(gca, 'XMinorTick', 'off');
set(gca, 'XGrid', 'off', 'YGrid', 'off'); 
uistack(ll, 'top')
% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/nsSMEV_RL.png', '-dpng', '-r300');
%% nsGEV return levels for average temperatures
clear ll;
RP = 5:5:200;
M=numel(squeeze(AMS(1,1,:)));
eRP = 1./(1-plottingPositions(M));
sortAMS = sort(AMS,3);
newAMS= squeeze(median(sortAMS,[1 2]));

eRP30 = 1./(1-plottingPositions(30));
sortAMS1 = sort(AMS(:,:,1:30),3);
newAMS1= squeeze(median(sortAMS1,[1 2]));
sortAMS2 = sort(AMS(:,:,31:60),3);
newAMS2= squeeze(median(sortAMS2,[1 2]));
sortAMS3 = sort(AMS(:,:,61:90),3);
newAMS3= squeeze(median(sortAMS3,[1 2]));

ll(1)=plot(log(RP),median_nsGEV_RL_T_4(:,1),'-','color',[22,6,138]/255,'LineWidth', 2); hold on
ll(2)=plot(log(RP),median_nsGEV_RL_T_4(:,2),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(3)=plot(log(RP),median_nsGEV_RL_T_4(:,3),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2); 
ll(4)=plot(log(RP),median_nsGEV_RL_T_4(:,4),'-','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(5)=plot(log(RP),median_nsGEV_RL_T_4(:,5),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(6)=plot(log(RP),median_nsGEV_RL_T_4(:,6),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2);

xlim([log(5) log(200)]);
ylim([20 90]);
xlims = xlim;
ylims = ylim;

for xt = (linspace((xlims(1)), (xlims(2)), 5))
    line([xt xt], ylims, 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom X grid (dashed)
for xt = log([6.9 8.8 10.7 17.35 22.1 26.85 43.575 55.55 67.525 109.625 139.75 169.875])
    line([xt xt], ylims, 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end
% Custom Y grid (solid)
for yt = -20:20:220
    line((xlims), [yt yt], 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom Y grid (dashed)
for yt = [-6 -4 -2 2 4 6 8]
    line((xlims), [yt yt], 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end

set(gca,'fontsize',18,'xtick',log([5 12.6 31.6 79.5 200]),'XTickLabel', ["5" "13" "32" "80" "200"],'ytick',-20:20:220); 

xlabel('RP (a)'); ylabel('RL (mm)'); box on
legend_handles = ll(1:6);
legend_labels = {
    'NS-GEV with T = 8°C', ...
    'NS-GEV with T = 9°C', ...
    'NS-GEV with T = 10°C', ...
    'NS-GEV with T = 11°C', ...
    'NS-GEV with T = 12°C', ...
    'NS-GEV with T = 13°C', ...
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');
figure_width = 7.3; % in inches
figure_height = 6; % in inches
set(gca, 'XMinorTick', 'off');
set(gca, 'XGrid', 'off', 'YGrid', 'off'); 
uistack(ll, 'top')

% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/nsGEV_T_RL.png', '-dpng', '-r300');
%% nsSMEV return levels for averge temperatures
clear ll;
RP = 5:5:200;
M=numel(squeeze(AMS(1,1,:)));
eRP = 1./(1-plottingPositions(M));
sortAMS = sort(AMS,3);
newAMS= squeeze(median(sortAMS,[1 2]));

eRP30 = 1./(1-plottingPositions(30));
sortAMS1 = sort(AMS(:,:,1:30),3);
newAMS1= squeeze(median(sortAMS1,[1 2]));
sortAMS2 = sort(AMS(:,:,31:60),3);
newAMS2= squeeze(median(sortAMS2,[1 2]));
sortAMS3 = sort(AMS(:,:,61:90),3);
newAMS3= squeeze(median(sortAMS3,[1 2]));

ll(1)=plot(log(RP),median_nsSMEV_RL_T_4(:,1),'-','color',[22,6,138]/255,'LineWidth', 2); hold on
ll(2)=plot(log(RP),median_nsSMEV_RL_T_4(:,2),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(3)=plot(log(RP),median_nsSMEV_RL_T_4(:,3),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2); 
ll(4)=plot(log(RP),median_nsSMEV_RL_T_4(:,4),'-','color',[100/255, 143/255, 255/255],'LineWidth', 2); hold on
ll(5)=plot(log(RP),median_nsSMEV_RL_T_4(:,5),'-','color',[0.8627, 0.1490, 0.4980],'LineWidth', 2); 
ll(6)=plot(log(RP),median_nsSMEV_RL_T_4(:,6),'-','color',[1.0000, 0.6902, 0.0000],'LineWidth', 2);
xlim([log(5) log(200)]);
ylim([20 90]);
xlims = xlim;
ylims = ylim;

for xt = (linspace((xlims(1)), (xlims(2)), 5))
    line([xt xt], ylims, 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom X grid (dashed)
for xt = log([6.9 8.8 10.7 17.35 22.1 26.85 43.575 55.55 67.525 109.625 139.75 169.875])
    line([xt xt], ylims, 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end
% Custom Y grid (solid)
for yt = -20:20:220
    line((xlims), [yt yt], 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
end
% Custom Y grid (dashed)
for yt = [-6 -4 -2 2 4 6 8]
    line((xlims), [yt yt], 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
end

set(gca,'fontsize',18,'xtick',log([5 12.6 31.6 79.5 200]),'XTickLabel', ["5" "13" "32" "80" "200"],'ytick',-20:20:220); 

xlabel('RP (a)'); ylabel('RL (mm)'); box on
legend_handles = ll(1:6);
legend_labels = {
    'NS-SMEV with T = 8°C', ...
    'NS-SMEV with T = 9°C', ...
    'NS-SMEV with T = 10°C', ...
    'NS-SMEV with T = 11°C', ...
    'NS-SMEV with T = 12°C', ...
    'NS-SMEV with T = 13°C', ...
};
legend(legend_handles, legend_labels, 'FontSize', 18, 'Location', 'southeast');
figure_width = 7.3; % in inches
figure_height = 6; % in inches
set(gca, 'XMinorTick', 'off');
set(gca, 'XGrid', 'off', 'YGrid', 'off'); 
uistack(ll, 'top')

% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/nsSMEV_T_RL.png', '-dpng', '-r300');
%% Plotting RL of GEV and sMEV
clear ll;
fig = figure;
fig.Position = [100, 400, 800, 450];
RP = 5:5:200;
ll = TENAX_fig_vis3(AMS(:,:,:),log(RP),squeeze(mean(GEV_RL(:,:,:,:),[1 2])),squeeze(mean(SMEV_RL(:,:,:,:),[1 2])),squeeze(mean(GEV_RL_unc_4(:,:,:,:,:,:),[1 2])),squeeze(mean(SMEV_RL_unc_4(:,:,:,:,:,:),[1 2])));
title('Average GEV and SMEV RLs for the combined periods');
set(gca,'fontsize',14,'ytick',0:20:280,'xtick',[log(5) log(12) log(32) log(88) log(200)],'XTickLabel', ["5" "12" "32" "88" "200"]); 
xlabel=('Return period');
ylabel =('Return level in mm');
xlim([log(5) log(200)]);
ylim([20 140]);
legend(ll,{'AMS','GEV with 90% CI from bootstrapping 30 years','SMEV with 90% CI from bootstrapping 30 years'},'fontsize',12,'location','northwest')
%%
T1 = mean(T_all(1:30))-273.15;
T2 = mean(T_all(31:60))-273.15;
T3 = mean(T_all(61:90))-273.15;
%% Plotting the difference of nsGEV and nsSMEV
clear ll;
figure('Position', [100, 350, 800, 600]);
surf(T_values,log(RP),mean_nsSMEV_RL_T_4-mean_nsGEV_RL_T_4); hold on;
set(gca,'fontsize',22,'xtick',280.15:1:288.15,'xticklabels',{"7" "" "9" "" "11" "" "13" "" "15"},'ytick',[log(5) log(12) log(32) log(88) log(200)],'YTickLabel', ["5" "12" "32" "88" "200"]); 
ylim([log(5) log(200)]);
colormap(custom_cmap3);
cb = colorbar('Ticks',-10:5:10);
cb.Label.String= 'Return level difference in mm';
cb.Label.FontSize = 22;
clim([-10 10])
xtickangle(0); 
xlabel('Temperature in °C');
ylabel('RP in years');
zlabel('Return level difference in mm');
%title('(NS-sMEV)-(NS-GEV) from all periods combined');
print(gcf, 'Matlab_Plots/nsGEV_nsSMEV_RL.png', '-dpng', '-r300');
box on;
%% Plotting the difference of nsGEV
clear ll;
figure('Position', [100, 350, 800, 600]);
surf(T_values,log(RP),mean_nsGEV_RL_T_4); hold on;
set(gca,'fontsize',22,'xtick',280.15:1:288.15,'xticklabels',{"7" "" "9" "" "11" "" "13" "" "15"},'ytick',[log(5) log(12) log(32) log(88) log(200)],'YTickLabel', ["5" "12" "32" "88" "200"]); 
ylim([log(5) log(200)]);
colormap(viridis2);
cb = colorbar('Ticks',-10:10:100);
cb.Label.String= 'Return level difference in mm';
cb.Label.FontSize = 22;
zlim([20 90])
clim([20 80])
xtickangle(0); 
xlabel('Temperature in °C');
ylabel('RP in years');
zl = zlabel('Return level difference in mm');
zl.Position(1) = zl.Position(1) - 0.2;
%title('(NS-sMEV)-(NS-GEV) from all periods combined');
print(gcf, 'Matlab_Plots/nsGEV_RL_T_4.png', '-dpng', '-r300');
box on;
%% Plotting the difference of nsSMEV
clear ll;
figure('Position', [100, 350, 800, 600]);
surf(T_values,log(RP),mean_nsSMEV_RL_T_4); hold on;
set(gca,'fontsize',22,'xtick',280.15:1:288.15,'xticklabels',{"7" "" "9" "" "11" "" "13" "" "15"},'ytick',[log(5) log(12) log(32) log(88) log(200)],'YTickLabel', ["5" "12" "32" "88" "200"]); 
ylim([log(5) log(200)]);
colormap(viridis2);
cb = colorbar('Ticks',-10:10:100);
cb.Label.String= 'Return level difference in mm';
cb.Label.FontSize = 22;
zlim([20 90])
clim([20 80])
xtickangle(0); 
xlabel('Temperature in °C');
ylabel('RP in years');
zl = zlabel('Return level difference in mm');
zl.Position(1) = zl.Position(1) - 0.2;
%title('(NS-sMEV)-(NS-GEV) from all periods combined');
print(gcf, 'Matlab_Plots/nsSMEV_RL_T_4.png', '-dpng', '-r300');
box on;
%% Plotting the difference of the nsGEV from period 1 and the combined periods
clear ll;
figure('Position', [100, 350, 800, 600]);
surf(T_values,log(RP),nsGEV_RL_T_4-nsGEV_RL_T_1); hold on;
set(gca,'fontsize',14,'xtick',280.15:1:288.15,'xticklabels',{"7" "8" "9" "10" "11" "12" "13" "14" "15"},'ytick',[log(5) log(12) log(32) log(88) log(200)],'YTickLabel', ["5" "12" "32" "88" "200"]); 
ylim([log(5) log(200)]);
colormap(custom_cmap);
cb = colorbar('Ticks',-10:5:20);
cb.Label.String= 'Return level difference in mm';
clim([0 15]);  
zlim([0 20]);
xlabel('Temperature in °C');
ylabel('RP in years');
zlabel('Return levels difference in mm');
title('(NS-GEV combined period) - (NS-GEV 1971-2000)')
box on;
%% Plotting the difference of the nsSMEV from period 1 and the combined periods
clear ll;
figure('Position', [100, 350, 800, 600]);
surf(T_values,log(RP),nsSMEV_RL_T_4-nsSMEV_RL_T_1); hold on;
set(gca,'fontsize',14,'xtick',280.15:1:288.15,'xticklabels',{"7" "8" "9" "10" "11" "12" "13" "14" "15"},'ytick',[log(5) log(12) log(32) log(88) log(200)],'YTickLabel', ["5" "12" "32" "88" "200"]); 
ylim([log(5) log(200)]);
colormap(custom_cmap);
cb = colorbar('Ticks',-10:5:20);
cb.Label.String= 'Return level difference in mm';
clim([0 15]); 
xlabel('Temperature in °C');
ylabel('RP in years');
zlabel('Return level difference in mm');
title('(NS-sMEV combined period) - (NS-sMEV 1971-2000)');
box on;
%% Plotting the nsGEV distribution
clear ll;
figure('Position', [100, 350, 800, 600]);
surf(T_values,log(RP),nsGEV_RL_T_4);
set(gca,'fontsize',14,'xtick',280.15:1:288.15,'xticklabels',{"7" "8" "9" "10" "11" "12" "13" "14" "15"},'ytick',[log(5) log(12) log(32) log(88) log(200)],'YTickLabel', ["5" "12" "32" "88" "200"]); 
ylim([log(5) log(200)]);
colormap(parula);
cb = colorbar('Ticks',-10:10:200);
cb.Label.String= 'Return level difference in mm';
clim([25 85]);  
xlabel('Temperature in °C');
ylabel('RP in years');
zlabel('Return levels in mm');
title('NS-GEV from all periods combined')
zlim([20 90]);
box on;
%% Plotting the nsSMEV distribution
clear ll;
figure('Position', [100, 350, 800, 600]);
surf(T_values,log(RP),nsSMEV_RL_T_4);
set(gca,'fontsize',14,'xtick',280.15:1:288.15,'xticklabels',{"7" "8" "9" "10" "11" "12" "13" "14" "15"},'ytick',[log(5) log(12) log(32) log(88) log(200)],'YTickLabel', ["5" "12" "32" "88" "200"]); 
ylim([log(5) log(200)]);
colormap(parula);
cb = colorbar('Ticks',-10:10:200);
cb.Label.String= 'Return level difference in mm';
clim([25 85]); 
xlabel('Temperature in °C');
ylabel('RP in years');
zlabel('Return levels in mm');
title('NS-sMEV from all periods combined')
zlim([20 90]);
box on;
%% Relative root mean square error GEV
fig = figure;
fig.Position = [100, 400, 1200, 400]; % This sets a wider figure
b=squeeze(mean(GEV_rmse_4(:,:,1:16,:), [1 2]));
imagesc(b); hold on; % Visualize the data       
set(gca, 'ColorScale', 'log');
colorbarObj = colorbar; % Add colorbar and get its handle
% Set custom ticks
colorbarObj.FontSize = 22;
colorbarObj.Ticks = [0.003 0.01 0.03 0.1 0.3 1 3 10 ] ; % Specify tick positions
% Set custom tick labels
colorbarObj.TickLabels = ["3%" "10%" "30%" "100%" "300%" "1000%" "3000%" "10000%" ]; % Custom labels               % Add a colorbar
colormap(flipud(viridis(220)));
colorbarObj.Label.String = 'RRMSE';
axis xy;                % Ensure the origin is at the top-left
clim([0.003 10]);           % Set the color bar limits explicitly
xlabel('Return period (a)');       % Add labels
ylabel('Sample length (a)');
% Adjust axis properties if needed
set(gca, 'FontSize', 22,'xtick',5:5:40,'xticklabels',25:25:200,'ytick',1:2:16,'yticklabel',10:10:85); % Increase font size
plot(1:40,1:40,'Color','k');
box on;
hold off;
x_limits = xlim;
y_limits = ylim;

figure_width = 18; % in inches
figure_height = 6; % in inches
% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/GEV_RRMSE.png', '-dpng', '-r300');
%% Relative root mean square error SMEV
fig = figure;
fig.Position = [100, 400, 1200, 400]; % This sets a wider figure
imagesc(squeeze(mean(SMEV_rmse_4(:,:,1:16,:), [1 2]))); hold on; % Visualize the data   
set(gca, 'ColorScale', 'log');
colorbarObj = colorbar; % Add colorbar and get its handle
% Set custom ticks
colorbarObj.FontSize = 22;
colorbarObj.Ticks = [0.003 0.01 0.03 0.1 0.3 1 3 10 ] ; % Specify tick positions
% Set custom tick labels
colorbarObj.TickLabels = ["3%" "10%" "30%" "100%" "300%" "1000%" "3000%" "10000%" ]; % Custom labels               % Add a colorbar
colormap(flipud(viridis(220)));
colorbarObj.Label.String = 'RRMSE';
axis xy;                % Ensure the origin is at the top-left
clim([0.003 10]);           % Set the color bar limits explicitly
xlabel('Return period (a)');       % Add labels
ylabel('Sample length (a)');
% Adjust axis properties if needed
set(gca, 'FontSize', 22,'xtick',5:5:40,'xticklabels',25:25:200,'ytick',1:2:16,'yticklabel',10:10:85); % Increase font size
plot(1:40,1:40,'Color','k');
box on;
hold off;
x_limits = xlim;

figure_width = 18; % in inches
figure_height = 6; % in inches
% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/SMEV_RRMSE.png', '-dpng', '-r300');
%% Relative root mean square error SMEV / GEV
fig = figure;
fig.Position = [100, 400, 1200, 400]; % This sets a wider figure
a = squeeze(mean(SMEV_rmse_4(:,:,1:16,:), [1 2]))./squeeze(mean(GEV_rmse_4(:,:,1:16,:), [1 2]));
imagesc(a); hold on; % Visualize the data       
colorbarObj = colorbar; % Add colorbar and get its handle
colorbarObj.FontSize = 22;
% Set custom ticks
colorbarObj.Ticks = 0:0.1:1; % Specify tick positions
% Set custom tick labels
colorbarObj.TickLabels = 0:0.1:1; % Custom labels               % Add a colorbar
colormap(flipud(parula));
colorbarObj.Label.String = 'Quotient of the RRMSE';
axis xy;                % Ensure the origin is at the top-left
clim([0 1]);           % Set the color bar limits explicitly
xlabel('Return period (a)');       % Add labels
ylabel('Sample length (a)');
% Adjust axis properties if needed
set(gca, 'FontSize', 22,'xtick',5:5:40,'xticklabels',25:25:200,'ytick',1:2:16,'yticklabel',10:10:85); % Increase font size
plot(1:40,1:40,'Color','k');
box on;
hold off;
x_limits = xlim;
y_limits = ylim;

figure_width = 18; % in inches
figure_height = 6; % in inches
% Set the figure size in the current figure window
set(gcf, 'Units', 'Inches', 'Position', [1, 1, figure_width, figure_height]);

% Save the figure as a PNG file with 300 DPI
print(gcf, 'Matlab_Plots/GEV_SMEV_RRMSE.png', '-dpng', '-r300');
%% Violinplot GEV
fig = figure;
fig.Position = [100, 400, 900, 500]; % This sets a wider figure

% First subplot (top)
subplot(1,3,1);
A = reshape(GEV_prm(:,:,[1:3],1),415*423,3);
daviolinplot(A(:,:),'violin','full','outliers',0,'xtlabels',["1971-2000","2031-2060","2071-2100"]); hold on;
ylim([-0.2 0.5]);
title('Shape', 'FontWeight', 'normal');
set(gca,'fontsize',18); box on;

subplot(1,3,2);
B = reshape(GEV_prm(:,:,[1:3],2),415*423,3);
daviolinplot(B(:,:),'violin','full','outliers',0,'xtlabels',["1971-2000","2031-2060","2071-2100"])
ylim([2 12]);
title('Scale', 'FontWeight', 'normal');
set(gca,'fontsize',18); box on;

subplot(1,3,3);
C = reshape(GEV_prm(:,:,[1:3],3),415*423,3);
daviolinplot(C(:,:),'violin','full','outliers',0,'xtlabels',["1971-2000","2031-2060","2071-2100"])
ylim([7 25]);
title('Location', 'FontWeight', 'normal');
set(gca,'fontsize',18);
box on;
%print(gcf, 'Matlab_Plots/GEV_prm.png', '-dpng', '-r300');
%% Violinplot sMEV
fig = figure;
fig.Position = [100, 400, 900, 500]; % This sets a wider figure
% First subplot (top)
subplot(1,3,1);
A = reshape(SMEV_prm(:,:,[1:3],1),415*423,3);
daviolinplot(A(:,:),'violin','full','outliers',0,'xtlabels',["1971-2000","2031-2060","2071-2100"])
ylim([0.4 0.7]);
title('Inverse shape', 'FontWeight', 'normal');
set(gca,'fontsize',18); box on;

subplot(1,3,2);
B = reshape(SMEV_prm(:,:,[1:3],2),415*423,3);
daviolinplot(B(:,:),'violin','full','outliers',0,'xtlabels',["1971-2000","2031-2060","2071-2100"])
ylim([0.3 1.2]);
title('Scale', 'FontWeight', 'normal');
set(gca,'fontsize',18); box on;

subplot(1,3,3);
C = reshape(N(:,:,[1:3],3),415*423,3);
daviolinplot(C(:,:),'violin','full','outliers',0,'xtlabels',["1971-2000","2031-2060","2071-2100"])
ylim([95 130]);
title('#Ordinary events', 'FontWeight', 'normal');
set(gca,'fontsize',18);
box on;

print(gcf, 'Matlab_Plots/SMEV_prm.png', '-dpng', '-r300');

%% Temperature Scaling
Scaling1_GEV = flipud(squeeze((GEV_RL(:,:,2,:)./GEV_RL(:,:,1,:)-1)/(mean(T_all(31:60))-mean(T_all(1:30)))));
Scaling2_GEV = flipud(squeeze((GEV_RL(:,:,3,:)./GEV_RL(:,:,1,:)-1)/(mean(T_all(61:90))-mean(T_all(1:30)))));
Scaling1_SMEV = flipud(squeeze((SMEV_RL(:,:,2,:)./SMEV_RL(:,:,1,:)-1)/(mean(T_all(31:60))-mean(T_all(1:30)))));
Scaling2_SMEV = flipud(squeeze((SMEV_RL(:,:,3,:)./SMEV_RL(:,:,1,:)-1)/(mean(T_all(61:90))-mean(T_all(1:30)))));
%% Scaling GEV
fig = figure;
fig.Position = [100, 400, 600, 700]; % This sets a wider figure
% First subplot (top)
A = [reshape(Scaling1_GEV(:,:,2),415*423,1) reshape(Scaling2_GEV(:,:,2),415*423,1) reshape(Scaling1_GEV(:,:,20),415*423,1) reshape(Scaling2_GEV(:,:,20),415*423,1)];
daviolinplot(A(:,:),'violin','full','outliers',0,'xtlabels',["1. - 2. Period","1. - 3. Period","1. - 2. Period","1. - 3. Period"])
ylim([-0.1 0.3]);
yline(0.07, '--k', 'LineWidth', 1.5);
title('10-year RP                 100-year RP', 'FontWeight', 'normal');
set(gca,'fontsize',18); box on;
box on;
print(gcf, 'Matlab_Plots/GEV_scaling.png', '-dpng', '-r300');
%% Scaling sMEV
fig = figure;
fig.Position = [100, 400, 600, 700]; % This sets a wider figure
B = [reshape(Scaling1_SMEV(:,:,2),415*423,1) reshape(Scaling2_SMEV(:,:,2),415*423,1) reshape(Scaling1_SMEV(:,:,20),415*423,1) reshape(Scaling2_SMEV(:,:,20),415*423,1) ];
daviolinplot(B(:,:),'violin','full','outliers',0,'xtlabels',["1. - 2. Period","1. - 3. Period","1. - 2. Period","1. - 3. Period"])
ylim([-0.1 0.3]);
yline(0.07, '--k', 'LineWidth', 1.5);
title('10-year RP                 100-year RP', 'FontWeight', 'normal');
set(gca,'fontsize',18);
box on;
print(gcf, 'Matlab_Plots/SMEV_scaling.png', '-dpng', '-r300');
%% Sensitivity
close all;
x = linspace(5,200);
vguess = 10.^(log10(0.1):.05:log10(5e2));
% Function handles
funcs = {
    @(x,a,b,c) gevinv(1-(1./x), a, b, c),  % GEV
    @(x,a,b,c) SMEV_inversion([b, a, c],x,vguess);  % sMEV
};
func_names = {'GEV', 'sMEV'};
param_labels = {{'Shape', 'Scale', 'Location'},{'Inverse Shape', 'Scale', '#Ordinary events'}};

% Base parameters: one row per function
paramet = {
    [0.1631, 0.1525, 0.1389; 5.71, 6.57,7.43; 13.96,15.33, 17.75],   % for GEV
    [0.522, 0.497, 0.488; 0.702, 0.676, 0.727; 109.57, 108.18, 108.43]    % for sMEV
};

colors = {[86, 180, 233]/255,[0, 158, 115]/255,[230, 159, 0]/255};

for fi = 1:2
    f = funcs{fi};
    
    figure('Name', func_names{fi}, 'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
    
    for pi = 1:3
        subplot(1,3,pi);
        hold on;
        
        % Custom X grid (solid)
        for xt = exp(linspace(log(xlims(1)), log(xlims(2)), 5))
            line([xt xt], ylims, 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
        end

        % Custom X grid (dashed)
        for xt = [6.9 8.8 10.7 17.35 22.1 26.85 43.575 55.55 67.525 109.625 139.75 169.875]
            line([xt xt], ylims, 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
        end

        % Custom Y grid (solid)
        for yt = -20:20:220
            line(xlims, [yt yt], 'Color', [0.8 0.8 0.8], 'LineStyle', '-', 'HandleVisibility', 'off');
        end

        % Custom Y grid (dashed)
        for yt = 15:5:85
            line(xlims, [yt yt], 'Color', [0.9 0.9 0.9], 'LineStyle', '--', 'HandleVisibility', 'off');
        end

        for vi = 1:3
            params = paramet{fi}(:,1);
            params(pi) = paramet{fi}(pi,vi);% Get a copy of [a, b, c]       % Modify one parameter
            y = f(x, params(1), params(2), params(3));
            plot(x, y, 'DisplayName', sprintf('%.2f', paramet{fi}(pi,vi)), 'LineWidth', 1.5, 'color', colors{vi});
        end
        set(gca,'XScale', 'log','fontsize',18,'xtick',[5 12.6 31.6 79.5 200],'XTickLabel', ["5" "13" "32" "80" "200"],'ytick',-20:20:220); 
        ylim([20, 90]);
        xlim([5 200]);
        xlims = xlim;
        ylims = ylim;
        xlabel('RP (a)');
        ylabel('RL (mm)');
        title(sprintf('%s', param_labels{fi}{pi}));
        legend('show', 'FontSize', 18, 'Location', 'northwest');
        set(gca, 'XMinorTick', 'off');
        set(gca, 'XGrid', 'off', 'YGrid', 'off'); 
    end
    box on;
    print(gcf, sprintf('Matlab_Plots/%s_sensi.png',func_names{fi}), '-dpng', '-r300');
end
%%
paramet{fi}(:,vi)