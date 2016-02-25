
 
function [retval] = Billiards ()
 

tCurrent=0; ur=1; uplot=ur; tplot=0;
 
% X_UPPER_BOUNDS = 1
% X_LOWE_BOUNDS = 0
 
% Y_UPPER_BOUND = 1
% Y_LOWER_BOUND = 0

% Universal Constants
radius = 0.075;
A = eye(2);
dt = 0.03;
fixed_dt = 0.03; 
friction = 0.8;

% Red's initial position and velocity
xRed = [0.1;0.1];
vRed = [0.3;0.4];

% Blue's initial position and velocity
xBlue = [0.5;1];
vBlue = [0;0];


 
while tCurrent <= 500
    if tCurrent + dt > 500
        dt = 50 - tCurrent;
    end
    
    red = [xRed,vRed];
    blue = [xBlue,vBlue];
    
    % Look into the future...
    redNext = [xRed + vRed*dt, vRed]; 
    blueNext = [xBlue + vBlue*dt, vBlue];
    tNext = tCurrent + dt;
    
    % Check for wall collisions in the future 
   

    if redNext(1,1) > 1 - radius
        dtWall = getdt(1,radius, red(1,1), red(1,2)); % stick to the wall
        redNext(:,1) = red(:,1) + red(:,2) * dtWall; % update position
        redNext(:,2) = (-A(:,1) + A(:,mod(1,2)+1)).*red(:,2)*friction; % update velocity
    end

    if redNext(1,1) < radius
        dtWall = getdt(0,-radius,red(1,1),red(1,2));
        redNext(:,1) = red(:,1) + red(:,2) * dtWall;
        redNext(:,2) = (-A(:,1) + A(:,mod(1,2)+1)).*red(:,2)*friction;
    end

    if blueNext(1,1) > 1 - radius 
        dtWall = getdt(1,radius, blue(1,1), blue(1,2)); % stick to the wall
        blueNext(:,1) = blue(:,1) + blue(:,2) * dtWall; % update position
        blueNext(:,2) = (-A(:,1) + A(:,mod(1,2)+1)).*blue(:,2)*friction; % update velocity
    end

    if blueNext(1,1) < radius
        dtWall = getdt(0,-radius,blue(1,1),blue(1,2));
        blueNext(:,1) = blue(:,1) + blue(:,2) * dtWall;
        blueNext(:,2) = (-A(:,1) + A(:,mod(1,2)+1)).*blue(:,2)*friction;
    end

    if redNext(2,1) > 2 - radius 
        dtWall = getdt(2,radius, red(2,1), red(2,2)); % stick to the wall
        redNext(:,1) = red(:,1) + red(:,2) * dtWall; % update position
        redNext(:,2) = (-A(:,2) + A(:,mod(2,2)+1)).*red(:,2)*friction; % update velocity
    end

    if redNext(2,1) < radius
        dtWall = getdt(0,-radius,red(2,1),red(2,2));
        redNext(:,1) = red(:,1) + red(:,2) * dtWall;
        redNext(:,2) = (-A(:,2) + A(:,mod(2,2)+1)).*red(:,2)*friction;
    end

    if blueNext(2,1) > 2 - radius
        dtWall = getdt(2,radius, blue(2,1), blue(2,2)); % stick to the wall
        blueNext(:,1) = blue(:,1) + blue(:,2) * dtWall; % update position
        blueNext(:,2) = (-A(:,2) + A(:,mod(2,2)+1)).*blue(:,2)*friction; % update velocity
    end

    if blueNext(2,1) < radius
        dtWall = getdt(0,-radius,blue(2,1),blue(2,2));
        blueNext(:,1) = blue(:,1) + blue(:,2) * dtWall;
        blueNext(:,2) = (-A(:,2) + A(:,mod(2,2)+1)).*blue(:,2)*friction;
    end

    
    
    % Check for ball collision in the future
    if pdist([blueNext(:,1)';redNext(:,1)']) <= 2*radius 
        dtBall = getdtBall(blue(1,1)-red(1,1),blue(1,2)-red(1,2),blue(2,1) - red(2,1),blue(2,2) -red(2,2));
        blueNext(:,1) = blue(:,1) + blue(:,2) * dtBall;
        redNext(:,1) = red(:,1) + red(:,2) * dtBall;
        n = [blueNext(1,1) - redNext(1,1),blueNext(2,1)-redNext(2,1)];
        t = [1,-n(1)/n(2)];
        B = [n;t];
        blueNext(:,2) = B * blue(:,2);
        redNext(:,2) = B * red(:,2);
        tmp = blueNext(1,2);
        blueNext(1,2) = redNext(1,2);
        redNext(1,2) = tmp;
        blueNext(:,2) = B\blueNext(:,2);
        redNext(:,2) = B\redNext(:,2);          
    end
            
    % plot the balls
    draw_disc_color(red(1,1),red(2,1),radius,'r');
    hold on
    draw_disc_color(blue(1,1),blue(2,1),radius,'b');
    hold off
    axis([0,1,0,2]);
    daspect([1,1,1]);

    pause(fixed_dt/5);
    dt = fixed_dt;
    
    tCurrent = tNext;
    xRed = redNext(:,1);
    vRed = redNext(:,2);
    xBlue = blueNext(:,1);
    vBlue = blueNext(:,2);
end
end
        
       
   
    
    
    
    