%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Plotting beta multipliers for SF%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
workdir = '/Users/fculha/Documents/git_classes/simulator_all/sim/lib/data/beta_mult';
cd(workdir)
fid = readtable('beta_mult_sf.csv');
date = fid(1:5:end,3);
education_visits_t = fid(1:5:end,8);
office_visits_t = fid(2:5:end,8);
retail_visits_t = fid(3:5:end,8);
social_visits_t = fid(4:5:end,8);
supermarket_visits_t = fid(5:5:end,8);

education_bmult = fid(1:5:end,10);
office_bmult = fid(2:5:end,10);
retail_bmult = fid(3:5:end,10);
social_bmult = fid(4:5:end,10);
supermarket_bmult = fid(5:5:end,10);
homeg_bmult = mean([education_bmult{:,:} office_bmult{:,:} retail_bmult{:,:} social_bmult{:,:} supermarket_bmult{:,:}],2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%FIGURES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set printing options
str       = {'POI_mobility'};
figname   = char(strcat(str(1)));
% figname   = 'Case3_loss';
format    = '-dpng';
resl      = '-r200';
rend      = '-opengl';
printfig  = true;


% prepare formating options
HA = {'HorizontalAlignment','left','center','right'};
VA = {'VerticalAlignment','bottom','middle','top'};
UN = {'Units','Normalized','Inches'};
TX = {'Interpreter','Latex'};
TL = {'TickLabelInterpreter','Latex'};
LW = {'LineWidth',1,1.25,1.5,2};
FS = {'FontSize',10,15,18,21,24};
MS = {'MarkerSize',6,8,12};
LS = {'LineStyle','-','--','-.',':'};
% LC = {'Color',color};

% prepare axes/borders dimensions
axh = 3*2;
axw = axh;%4.5;
ahs = 0.5;
avs = 0.5;
axb = 0.7;
axt = 0.2;
axl = 0.8;
axr = 0.5;
cbh = axh; cbw = 0;
fh = axb + 1*axh + 1*avs +           axt;
fw = axl + 2*axw + 2*ahs + 1.5*cbw + axr;

% initialize figure and axes
f = figure;
set(f,'Units','Inches','Position',[0.7 12 fw fh]);
set(f,'PaperPosition',[0 0 fw fh],'PaperSize',[fw fh]);
set(f,'Color','w','InvertHardcopy','off', 'MenuBar','none');
set(f,'Resize','off','Toolbar','none');
ax(1) = axes('Units','Inches','position',[axl         axb         axw axh]);
ax(2) = axes('Units','Inches','position',[axl+axw+2*ahs         axb         axw axh]);

axes(ax(1)); hold on;
plot(date{2:end,:}, education_visits_t{2:end,:},'-','Color',[190,186,218]./255,'LineWidth',3)
plot(date{2:end,:}, office_visits_t{2:end,:},'-','Color',[251,128,114]./255,'LineWidth',3)
plot(date{2:end,:}, retail_visits_t{2:end,:},'-','Color',[128,177,211]./255,'LineWidth',3)
plot(date{2:end,:}, social_visits_t{2:end,:},'-','Color',[253,180,98]./255,'LineWidth',3)
plot(date{2:end,:}, supermarket_visits_t{2:end,:},'-','Color',[166,118,29]./255,'LineWidth',3)
xlabel('Date',TX{:},FS{[1,4]},UN{[1,3]},'Position',[axw/2+ahs/2,-axb/2]);
ylabel('Number of visits a week',TX{:},FS{[1,4]},UN{[1,3]},'Position',[-axl/2,axh/2]);
xlim([date{1,:} date{end,:}])
set(gca,'TickLabelInterpreter','latex',FS{[1,4]},UN{[1,3]})

axes(ax(2)); hold on;
plot(date{2:end,:}, education_bmult{2:end,:},'-','Color',[190,186,218]./255,'LineWidth',3)
plot(date{2:end,:}, office_bmult{2:end,:},'-','Color',[251,128,114]./255,'LineWidth',3)
plot(date{2:end,:}, retail_bmult{2:end,:},'-','Color',[128,177,211]./255,'LineWidth',3)
plot(date{2:end,:}, social_bmult{2:end,:},'-','Color',[253,180,98]./255,'LineWidth',3)
plot(date{2:end,:}, supermarket_bmult{2:end,:},'-','Color',[166,118,29]./255,'LineWidth',3)
plot(date{2:end,:}, homeg_bmult(2:end),'-','Color',[117,112,179]./255,'LineWidth',3)
xlabel('Date',TX{:},FS{[1,4]},UN{[1,3]},'Position',[axw/2+ahs/2,-axb/2]);
ylabel('Relative Mobility Ratio, $\overline{m}_{t,k}$',TX{:},FS{[1,4]},UN{[1,3]},'Position',[-axl/2,axh/2]);
xlim([date{1,:} date{end,:}])
text(0.15,1.05,'San Francisco Mobility',UN{[1,2]},TX{:},FS{[1,5]},VA{[1,2]},HA{[1,4]},'Color',[0 0 0]);
legend('education','office','retail','restaurants','supermarket','home gather',TX{:},FS{[1,5]},UN{[1,3]})
set(gca,'TickLabelInterpreter','latex',FS{[1,4]},UN{[1,3]})



if printfig
    workdir = '/Users/fculha/Documents/git_classes/simulator_all/sim/plots';
      cd(workdir);
    print(f,format,resl,rend,figname,'-loose');   
end
