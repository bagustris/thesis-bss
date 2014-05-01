function flotmatrix(M,xstring,ystring,otherstring)
if nargin==1
    m = size(M,1);
    n = size(M,2);

    for row = 1:m
        for col = 1:n
            subplot(m,n,col+n*(row-1));
            val = M(row,col);
            fill([-1 1 1 -1]*sqrt(val) ,[1 1 -1 -1]*sqrt(val),'g')
            axis([-1 1 -1 1]*1.05);
            axis off, axis square
            h=title(sprintf('%3i%%',round(100*val)));
            pos = get(h,'position');
            set(h,'position',[pos(1) min(pos(2)*sqrt(val),1.001) pos(3)]);
        end
    end
elseif nargin==3
    m = size(M,1);
    n = size(M,2);
    for row = 1:m+1
        for col = 1:n+1
            subplot(m+1,n+1,col+(n+1)*(row-1));
            if row==1&&col==1%dont do nothin'
                axis off
            elseif row==1&&col~=1
                axis off
                a=text(0.5,0.1,xstring(col-1));
                set(a,'Rotation',90);
            elseif col==1&&row~=1
                axis off
                text(0.1,0.5,ystring(row-1))
            else
                val = M(row-1,col-1);
                fill([-1 1 1 -1]*sqrt(val) ,[1 1 -1 -1]*sqrt(val),'black')
                axis([-1 1 -1 1]*1.05);
                axis off, axis square
                h=title(sprintf('%3i%%',round(100*val)));
                pos = get(h,'position');
                set(h,'position',[pos(1) min(pos(2)*sqrt(val),1.001) pos(3)]);
            end
        end
    end
elseif nargin==4
    m = size(M,1);
    n = size(M,2);
    for row = 1:m+1
        for col = 1:n+1
            subplot(m+2,n+1,col+(n+1)*(row-1));
            if row==1&&col==1%dont do nothin'
                axis off
            elseif row==1&&col~=1
                axis off
                a=text(0.5,0.1,xstring(col-1));
                set(a,'Rotation',90);
            elseif col==1&&row~=1
                axis off
                text(0.1,0.5,ystring(row-1))
            else
                val = M(row-1,col-1);
                fill([-1 1 1 -1]*sqrt(val) ,[1 1 -1 -1]*sqrt(val),'black')
                axis([-1 1 -1 1]*1.05);
                axis off, axis square
                h=title(sprintf('%3i%%',round(100*val)));
                pos = get(h,'position');
                set(h,'position',[pos(1) min(pos(2)*sqrt(val),1.001) pos(3)]);
            end
        end
    end
    for col = 1:n+1
        subplot(m+2,n+1,col+(n+1)*(m+1));
        if col==1
                axis off
                text(0.1,0.8,ystring(end))
        else
        axis off
        text(0.5,0.8,strcat(num2str(round(otherstring(col-1)*100)),'%'))
        end
    end
else
    error('Incorrect number of input arguments!')
end
