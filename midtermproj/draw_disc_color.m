function outvar=draw_disc_color(x,y,r,z)
n=100;
for i=1:n
    theta=i*(2*pi/n);
    X(i)=x+r*cos(theta);
    Y(i)=y+r*sin(theta);
end
if z == 'r'
    fill(X,Y,'r'); % fills (in red 'r') the 2-D polygon defined by vectors X and Y
end 
if z == 'b'
    fill(X,Y,'b'); % fills (in blue 'b') the 2-D polygon defined by vectors X and Y
end
    

axis square;
title('A Bouncing Ball','FontSize',14);
set(gca,'xtick',[]); set(gca,'xticklabel',[]);
set(gca,'ytick',[]); set(gca,'yticklabel',[]);
end