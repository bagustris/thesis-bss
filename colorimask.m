function [iL,iR]=colorimask(imaskL,imaskR,Fs)
%%% plots ideal binary masks in different colors (used for evaluation)
[a,b]=size(imaskL{1});
iL=zeros(size(imaskL{1}));
iR=zeros(size(imaskR{1}));
iLs=zeros(size(imaskL{1}));
iRs=zeros(size(imaskR{1}));

val=linspace(1,0,length(imaskL)+1);
%%% cmap defines the colors. white + colors of up to 6 sources
cmap=[1,1,1;1,0,0;0,1,0;1,1,0;0,0,1;0.5,0,0.5;1,0.5,0];
cmap=[1,1,1;...     %white
    1,0,0;...       %red
    0,1,0;...       %green
    0,0,1;...       %blue
    0.5,0,0.5;...   %purple
    1,0.5,0;...     %orange
    1,1,0];         %yellow

for i=1:length(imaskL)
    iLs=iLs+imaskL{i};
    iRs=iRs+imaskR{i};
end
mL=iLs<2;
mR=iRs<2;
for i=1:length(imaskL)
    iL=iL+imaskL{i}*val(i);
    iR=iR+imaskR{i}*val(i);
end    
iL=iL.*mL;    
iR=iR.*mR; 
if(0)
figure    
subplot(211)
imagesc(linspace(0,50000/Fs,a),linspace(0,Fs/2,b),(iL));
axis xy
colormap(cmap(1:(length(imaskL)+1),:));
subplot(212)
imagesc(linspace(0,50000/Fs,a),linspace(0,Fs/2,b),iR);
axis xy
colormap(cmap(1:(length(imaskL)+1),:));


fig=figure    
imagesc(linspace(0,50000/Fs,a),linspace(0,Fs/2,b),(iL));
axis xy
colormap(cmap(1:(length(imaskL)+1),:));
set(fig,'PaperPosition',[0.25 2.5 8 3])
saveas(fig,'allmasks.png')
end
if(0)%%%plot masks
    for i=1:length(imaskL)
        fig=figure
        imagesc(linspace(0,50000/Fs,a),linspace(0,Fs/2,b),(imaskL{i}));
        axis xy
        colormap(cmap([1,length(imaskL)+2-i],:));
        set(fig,'PaperPosition',[0.25 2.5 8 3])
        saveas(fig,strcat('imask',num2str(i),'.png'))
    end

end

