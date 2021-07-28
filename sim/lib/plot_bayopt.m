%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Plotting beta multipliers for SF%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plotting the residuals

clear all
close all
workdir = '/Users/fculha/Documents/git_classes/simulator_all/sim/plots';
cd(workdir)
load('wave2data')





objective = M(:,3);
p_home    = M(:,6);
beta      = M(:,5);

 x(:,1)= beta; x(:,2) = p_home; z = real(log10(objective));
 [X,Y] = meshgrid(x(:,1),x(:,2));




XX = [beta beta.^2 p_home p_home.^2 beta.*p_home]; %ones(length(beta),1) 
bb = XX\real(log10(objective));
ycal = XX*bb;
mdl = fitlm(XX,real(log10(objective)));
a = mdl.Coefficients(:,1);
a = a{:,:};
z_model = a(1) + a(2).*X + a(3).*X.^2 + a(4).*Y + a(5).*Y.^2+a(6).*X.*Y;
z_model2d = a(1) + a(2).*x(:,1) + a(3).*x(:,1).^2 + a(4).*x(:,2) + a(5).*x(:,2).^2+a(6).*x(:,1).*x(:,2);

%plot 3d data
% set printing options
str       = {'3D_obj_model_wave2'};
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

[M,c] = contour3(X,Y,z_model,50);
c.LineWidth = 3;
hold on
plot3(x(:,1),x(:,2),z,'.','MarkerSize',25)
y_p_model = (a(2) + 2.*a(3).*x(:,1) + a(4) + a(6)*x(:,1) )./-(a(6)+2.*a(5));

xlabel('$\beta$ [1/day]',TX{:},FS{[1,4]},UN{[1,3]});
ylabel('Probability of declining a travel for 2 weeks',TX{:},FS{[1,4]},UN{[1,3]});
zlabel('log$_{10}$(Objective)',TX{:},FS{[1,4]},UN{[1,3]});
title('wave 1')
if printfig
    workdir = '/Users/fculha/Documents/git_classes/simulator_all/sim/plots';
      cd(workdir);
    print(format,resl,rend,figname,'-loose');   
end





%plot data
setrangeval= [log(min(objective)) log(max(objective))];
sz = numel(objective);
newmapf = colormein(log(objective),[215,25,28; 255,255,191]./255,[255,255,191; 44,123,182]./255,[setrangeval(1) mean(setrangeval) setrangeval(end)]);
newmap = newmapf(end:-1:1,:);
color = floor(100*(setrangeval(2)-log(objective))/(setrangeval(2)-setrangeval(1)));
color(color==101) = 100;
color(color==0)   = 1;
for ii = 1:numel(color)
    objcol(ii,:) = newmap(color(ii),:);
end

Lbest = find(objective==max(objective));

%plot model
setrangeval= [min(z_model2d) max(z_model2d)];
sz = numel(z_model2d);
newmapf_model = colormein(z_model2d,[215,25,28; 255,255,191]./255,[255,255,191; 44,123,182]./255,[setrangeval(1) mean(setrangeval) setrangeval(end)]);
newmap_model = newmapf_model;
color = floor(100*(setrangeval(2)-z_model2d)/(setrangeval(2)-setrangeval(1)));
color(color==101) = 100;
color(color==0)   = 1;
for ii = 1:numel(color)
    modelcol(ii,:) = newmap_model(color(ii),:);
end



% set printing options
str       = {'BayesOpt_obj_wave2'};
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
ahs = 0.15;
avs = 0.15;
axb = 0.7;
axt = 0.2;
axl = 0.8;
axr = 0.5;
cbh = axh; cbw = 0.2;
fh = axb + 1*axh + 1*avs +           axt;
fw = axl + 1*axw + 1*ahs + 1.5*cbw + axr;

% initialize figure and axes
f = figure;
set(f,'Units','Inches','Position',[0.7 12 fw fh]);
set(f,'PaperPosition',[0 0 fw fh],'PaperSize',[fw fh]);
set(f,'Color','w','InvertHardcopy','off', 'MenuBar','none');
set(f,'Resize','off','Toolbar','none');
ax(1) = axes('Units','Inches','position',[axl         axb         axw axh]);
hold on
for ii = 1:numel(beta)
    hold on
     plot(beta(ii),p_home(ii),'.','Color',objcol(ii,:),'MarkerSize',35)
end
plot(beta(Lbest),p_home(Lbest),'ok','MarkerSize', 35)
xlabel('$\beta$ [1/day]',TX{:},FS{[1,4]},UN{[1,3]},'Position',[axw/2+ahs/2,-axb/2]);
ylabel('Probability of declining a travel for 2 weeks',TX{:},FS{[1,4]},UN{[1,3]},'Position',[-axl/2,axh/2]);
hold on
plot(x(:,1),y_p_model,'--','LineWidth',3,'Color',[44,123,182]./255)
xlim([min(beta) max(beta)])
ylim([min(p_home) max(p_home)])
R2O = mat2str(round(mdl.Rsquared.Ordinary*100)/100);
R2A = mat2str(round(mdl.Rsquared.Adjusted*100)/100);
str       = {'R$^2$ = ' R2O 'R$^2$ Adjusted = ' R2A};
R2   = char(strcat(str(1),str(2),str(3),str(4)));
text(.8,1,R2,UN{[1,2]},TX{:},FS{[1,4]},VA{[1,2]},HA{[1,4]},'Color',[0 0 0])

if printfig
    workdir = '/Users/fculha/Documents/git_classes/simulator_all/sim/plots';
      cd(workdir);
    print(f,format,resl,rend,figname,'-loose');   
end




%plot model
% set printing options
str       = {'Model_fit_wave2'};
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
ahs = 0.15;
avs = 0.15;
axb = 0.7;
axt = 0.2;
axl = 0.8;
axr = 0.5;
cbh = axh; cbw = 0.2;
fh = axb + 1*axh + 1*avs +           axt;
fw = axl + 1*axw + 1*ahs + 1.5*cbw + axr;

% initialize figure and axes
f = figure;
set(f,'Units','Inches','Position',[0.7 12 fw fh]);
set(f,'PaperPosition',[0 0 fw fh],'PaperSize',[fw fh]);
set(f,'Color','w','InvertHardcopy','off', 'MenuBar','none');
set(f,'Resize','off','Toolbar','none');
ax(1) = axes('Units','Inches','position',[axl         axb         axw axh]);
hold on
for ii = 1:numel(beta)
    hold on
     plot(beta(ii),p_home(ii),'.','Color',modelcol(ii,:),'MarkerSize',35)
end
xlabel('$\beta$ [1/day]',TX{:},FS{[1,4]},UN{[1,3]},'Position',[axw/2+ahs/2,-axb/2]);
ylabel('Probability of declining a travel for 2 weeks',TX{:},FS{[1,4]},UN{[1,3]},'Position',[-axl/2,axh/2]);
str       = sprintf('Model (wv2) $z =%.1f + %.1f X + %.1f X^2 + %.1f Y + %.1f Y^2 + %.1f XY$', a(1),...
    a(2), a(3), a(4), a(5), a(6));
equation   = char(strcat(str));


title(equation,TX{:},FS{[1,4]},UN{[1,3]});
hold on
plot(x(:,1),y_p_model,'-','LineWidth',3)
xlim([min(beta) max(beta)])
ylim([min(p_home) max(p_home)])

if printfig
    workdir = '/Users/fculha/Documents/git_classes/simulator_all/sim/plots';
      cd(workdir);
    print(f,format,resl,rend,figname,'-loose');   
end










% 
% 
% % initialize figure and axes
% str       = {'LR_beta_obj'};
% figname   = char(strcat(str(1)));
% f = figure;
% set(f,'Units','Inches','Position',[0.7 12 fw fh]);
% set(f,'PaperPosition',[0 0 fw fh],'PaperSize',[fw fh]);
% set(f,'Color','w','InvertHardcopy','off', 'MenuBar','none');
% set(f,'Resize','off','Toolbar','none');
% ax(1) = axes('Units','Inches','position',[axl         axb         axw axh]);
% plot(beta,log10(objective),'.','MarkerSize',25)
% hold on
% X = [ones(length(beta),1) beta];
% bb = X\log10(objective);
% ycal = X*bb;
% mdl = fitlm(beta,real(log10(objective)));
% R2O = mat2str(round(mdl.Rsquared.Ordinary*100)/100);
% R2A = mat2str(round(mdl.Rsquared.Adjusted*100)/100);
% plot(beta,ycal,'-','LineWidth',2)
% str       = {'R$^2$ = ' R2O 'R$^2$ Adjusted = ' R2A};
% R2   = char(strcat(str(1),str(2),str(3),str(4)));
% text(.8,1,R2,UN{[1,2]},TX{:},FS{[1,4]},VA{[1,2]},HA{[1,4]},'Color',[0 0 0])
% 
% xlabel('$\beta$ [1/day]',TX{:},FS{[1,4]},UN{[1,3]},'Position',[axw/2+ahs/2,-axb/2]);
% ylabel('Objective',TX{:},FS{[1,4]},UN{[1,3]},'Position',[-axl/2,axh/2]);
% 
% if printfig
%     workdir = '/Users/fculha/Documents/git_classes/simulator_all/sim/plots';
%       cd(workdir);
%     print(f,format,resl,rend,figname,'-loose');   
% end
% 
% 
% 
% % initialize figure and axes
% str       = {'LR_p_obj'};
% figname   = char(strcat(str(1)));
% f = figure;
% set(f,'Units','Inches','Position',[0.7 12 fw fh]);
% set(f,'PaperPosition',[0 0 fw fh],'PaperSize',[fw fh]);
% set(f,'Color','w','InvertHardcopy','off', 'MenuBar','none');
% set(f,'Resize','off','Toolbar','none');
% ax(1) = axes('Units','Inches','position',[axl         axb         axw axh]);
% plot(p_home,log10(objective),'.','MarkerSize',25)
% hold on
% X = [ones(length(p_home),1) p_home];
% bb = X\log10(objective);
% ycal = X*bb;
% mdl = fitlm(p_home,real(log10(objective)));
% R2O = mat2str(round(mdl.Rsquared.Ordinary*100)/100);
% R2A = mat2str(round(mdl.Rsquared.Adjusted*100)/100);
% plot(p_home,ycal,'-','LineWidth',2)
% str       = {'R$^2$ = ' R2O 'R$^2$ Adjusted = ' R2A};
% R2   = char(strcat(str(1),str(2),str(3),str(4)));
% text(.8,1,R2,UN{[1,2]},TX{:},FS{[1,4]},VA{[1,2]},HA{[1,4]},'Color',[0 0 0])
% 
% 
% xlabel('p stay at home',TX{:},FS{[1,4]},UN{[1,3]},'Position',[axw/2+ahs/2,-axb/2]);
% ylabel('Objective',TX{:},FS{[1,4]},UN{[1,3]},'Position',[-axl/2,axh/2]);
% 
% if printfig
%     workdir = '/Users/fculha/Documents/git_classes/simulator_all/sim/plots';
%       cd(workdir);
%     print(f,format,resl,rend,figname,'-loose');   
% end

save('wave2')
