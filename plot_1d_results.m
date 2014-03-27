% plot all energy spectra cases in one figure for 1D signals


% set parameters according to those set in main files
SAVEDLOC='./';
N=1024*32;
SIMN0=64;  %4
SIMN0t=num2str(SIMN0);
mstr='synth';
K=num2str(284);
EXTRA='';
% manually adjust M (Mmin) if not correct
M1=num2str(4132); %other
M2=num2str(2066); %speso

% which simulation cases to plot?
PLOTCASES=1:4;  % all: 1:SIMN0


var1=load([SAVEDLOC,'saved_1d_',num2str(N),'_',M1,'_',SIMN0t,'_',mstr,'_',K,'_1_31_',EXTRA,'.mat']);
var1b=load([SAVEDLOC,'saved_1d_',num2str(N),'_',M1,'_',SIMN0t,'_',mstr,'_',K,'_1_312_',EXTRA,'.mat']);
var2=load([SAVEDLOC,'saved_1d_',num2str(N),'_',M1,'_',SIMN0t,'_',mstr,'_',K,'_1_32_',EXTRA,'.mat']);
var3=load([SAVEDLOC,'saved_1d_',num2str(N),'_',M1,'_',SIMN0t,'_',mstr,'_',K,'_1_1_',EXTRA,'.mat']);
var4=load([SAVEDLOC,'saved_1d_',num2str(N),'_',M2,'_',SIMN0t,'_',mstr,'_',K,'_1_82_',EXTRA,'.mat']);


%==============================

kvec=var1b.k_os{1};

figure;
for ii=PLOTCASES
	% original
	hh0=loglog(kvec,var1b.E_os{ii,1},'-','Color',[0.7 0 0.7],'LineWidth',1.4);
	hold all
	
	% M-best
	hh1b=loglog(kvec,var1b.E_cs_res1{ii,1},'--','Color',[0.2 0.2 1],'LineWidth',1.3);
	
	% M/2-best
	hh1=loglog(kvec,var1.E_cs_res1{ii,1},'--','Color',[0.2 0.2 1],'LineWidth',0.7);
	
	% Shannon
	hh2=loglog(kvec,var2.E_cs_res1{ii,1},':','Color',[1 0.2 0.2],'LineWidth',1.3);

	% LOMP
	hh3=loglog(kvec,var3.E_cs_res1{ii,1},':','Color',[0 0.6 0],'LineWidth',0.8);
	
	% QOM good
	hh4=loglog(kvec,var4.E_cs_res1{ii,1},'-','Color',[0 0 0],'LineWidth',0.8);
	
end


ylimit=[min(var1b.E_os{ii,1}(1:end-10))/2,max(var1b.E_os{ii,1}(1:end-10))];
C1=1;C2=1;p1=-3;p2=-5/3;

loglog([700,1e4],C2*3e-7*[700,1e4].^p2,'k--','LineWidth',0.8)

ylabel('E(k)','FontSize', 11);
xlabel('k','FontSize', 11);

axis tight
ylim(ylimit)
xlim([50 N/2])

legend([hh0,hh1b,hh1,hh2,hh3,hh4],{'original','$M$-best','$M/2$-best','Shannon','LOMP','SpESO'}...
	,'interpreter', 'latex','Location','southwest');




% Copyright (C) 2014  Gudmundur Adalsteinsson
% See file LICENCE for licence and warranty details
