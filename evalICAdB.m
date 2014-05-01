function evalICAdB(W,theta_est,theta,N,Ns,labelvec,u)
%%plots ica output beampatterns and sources. 
th=linspace(0,2*pi,360);
resp=zeros(length(th),2);
for m=1:2
    for i=1:length(th)
        resp(i,m)=abs(W(m,:)*[1+u*cos(th(i));1-u*cos(th(i))]);
    end
end
%%% ICA step 1 evaluation
mindB=30
fig=figure 
mx=max(max(resp));
mx=max(max(20*log10(resp)))+mindB;
mx=50;%20+mindB
cmap=[1,1,1;1,0,0;0,1,0;1,1,0;0,0,1;0.5,0,0.5;1,0.5,0];%white,red,green,yellow,blue,purple,orange
order=[7,6,5,4,3,2];
for i=1:N
    d=polara([0,theta(i)],[0,ceil(mx)],'k');
    hold on
    xd=get(d,'Xdata');
    yd=get(d,'Ydata');
    if(0)  
    text(xd(2),yd(2),labelvec{Ns(i)},'Fontsize',20);
    else
        c=plot(xd(2),yd(2),'o')
        set(c,'Linewidth',20)
        set(c,'Color',cmap(order(i),:))
    end
end
for i=1:2
    b=polara([theta_est(i)],[ceil(mx)],'k*');
    set(b,'Linewidth',5)
    
end
resp=20*log10(resp);
for a=1:size(resp,1)
    for b=1:size(resp,2)
if resp(a,b)<-mindB
   resp(a,b)=-mindB;
end
end
end

resp=resp+mindB;

min((resp))
% 
% a=polar(th,resp(:,1)','b');
% set(a,'Linewidth',2)
% polar(th,resp(:,2)','b');
  a=polara(th,resp(:,1)','b');
  set(a,'Linewidth',2)
  polara(th,resp(:,2)','b');

 r=0
 ud=1.2
% text(0+r,ud,'-30dB','HorizontalAlignment','center','Fontsize',12)
 text(10+r,ud,'-20dB','HorizontalAlignment','center','Fontsize',12)
 text(20+r,ud,'-10dB','HorizontalAlignment','center','Fontsize',12)
 text(30+r,ud,'0dB','HorizontalAlignment','center','Fontsize',12)
 text(40+r,ud,'10dB','HorizontalAlignment','center','Fontsize',12)
  text(50+r,ud,'20dB','HorizontalAlignment','center','Fontsize',12)

%%% ICA step 1 evaluation
if(0)
  str2=strcat('polar',int2str(round(rem(now,1)*1000000)),'.png');
  saveas(fig,str2)
end

