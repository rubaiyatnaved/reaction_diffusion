function output=final_hopscotch2_predator_prey
clf; clear all;

N = 199; %number of points 
h = 400/(N+1); %grid spacing

dt = 1/4;


Du = 1; %diffusion coefficient of u (alpha_1)
Dv = 1; %diffusion coefficient of v (alpha_2)

a = (Du*dt)/(h^2);
a2 = (Dv*dt)/(h^2);

alpha = 0.4;
beta = 2.0;
gama = 0.6;

uin = (alpha*gama)/(beta-gama);
vin = (1-uin)*(uin+alpha);

f = @(u,v) u.*(1-u)-(u.*v)./(u+alpha);
g = @(u,v) (beta*u.*v)./(u+alpha) - gama*v;

x = [0:h:400];
y = [0:h:400];

%% initial condition
U0 = NaN(N+2,N+2);
V0 = NaN(N+2,N+2);

ic1 = @(x,y) uin-2*10^(-7)*(x-0.1*y-225)*(x-0.1*y-675);
ic2 = @(x,y) vin-3*10^(-5)*(x-450)-1.2*10^(-4)*(y-150);
%ic2 = @(x,y) x+sin(2.*pi.*x).*sin(2.*pi.*y);

for j=1:N+2
    for k=1:N+2
        U0(j,k) = ic1(x(j),y(k));
        V0(j,k) = ic2(x(j),y(k)) +rand(1);
%         if (x(j)-100)^2 + (y(k)-100)^2 <=9
%             V0(j,k) = 1;
%         elseif (x(j)>=206) && (x(j)<=207) && (y(k)>=205) && (y(k)<=206)
%             V0(j,k) = 1;
%         elseif (x(j)>=204) && (x(j)<=205) && (y(k)>=205) && (y(k)<=206)
%             V0(j,k) = 1;
%         elseif (x(j)>=205) && (x(j)<=206) && (y(k)>=206) && (y(k)<=207)
%             V0(j,k) = 1;
%         elseif (x(j)>=205) && (x(j)<=206) && (y(k)>=204) && (y(k)<=205)
%             V0(j,k) = 1;
%         else
            V0(j,k) = ic2(x(j),y(k));
%         end
    end
end

time = 0;

Un = U0;
Vn = V0;


%% Initialize video
% myVideo = VideoWriter('prey','MPEG-4'); %open video file
% myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
% open(myVideo)

%% time loop
for T=1:2000

    Unp1 = zeros(N+2,N+2);
    Vnp1 = zeros(N+2,N+2);

    for j=2:N+1
        for k=2:N+1
            if rem((T-1+j-1+k-1),2)==0
                Unp1(j,k) = a*(Un(j-1,k)+Un(j+1,k)+Un(j,k-1)+Un(j,k+1)-4*Un(j,k))+Un(j,k)+dt*f(Un(j,k),Vn(j,k));
                Vnp1(j,k) = a2*(Vn(j-1,k)+Vn(j+1,k)+Vn(j,k-1)+Vn(j,k+1)-4*Vn(j,k))+Vn(j,k)+dt*g(Un(j,k),Vn(j,k));
            end
            
        end
    end
    
    Unp1(1,2:N+1) = Unp1(N+1,2:N+1); 
    Unp1(N+2,2:N+1) = Unp1(2,2:N+1);
    Vnp1(1,2:N+1) = Vnp1(N+1,2:N+1); 
    Vnp1(N+2,2:N+1) = Vnp1(2,2:N+1);
    
    Unp1(2:N+1,1) = Unp1(2:N+1,N+1);
    Unp1(2:N+1,N+2) = Unp1(2:N+1,2);
    Vnp1(2:N+1,1) = Vnp1(2:N+1,N+1);
    Vnp1(2:N+1,N+2) = Vnp1(2:N+1,2);


    for j=2:N+1
        for k=2:N+1
            if rem((T-1+j-1+k-1),2)==1
                Unp1(j,k) = (a*(Unp1(j-1,k)+Unp1(j+1,k)+Unp1(j,k-1)+Unp1(j,k+1))+Un(j,k)+dt*f(Un(j,k),Vn(j,k)))/(1+4*a);
                Vnp1(j,k) = (a2*(Vnp1(j-1,k)+Vnp1(j+1,k)+Vnp1(j,k-1)+Vn(j,k+1))+Vn(j,k)+dt*g(Un(j,k),Vn(j,k)))/(1+4*a2);

                
            end
        end
    end
    
    %periodic boundary conditions
    Unp1(1,2:N+1) = Unp1(N+1,2:N+1); 
    Unp1(N+2,2:N+1) = Unp1(2,2:N+1);
    Vnp1(1,2:N+1) = Vnp1(N+1,2:N+1); 
    Vnp1(N+2,2:N+1) = Vnp1(2,2:N+1);
    
    Unp1(2:N+1,1) = Unp1(2:N+1,N+1);
    Unp1(2:N+1,N+2) = Unp1(2:N+1,2);
    Vnp1(2:N+1,1) = Vnp1(2:N+1,N+1);
    Vnp1(2:N+1,N+2) = Vnp1(2:N+1,2);

    Un = Unp1;
    Vn = Vnp1;
    time = time + dt;
    s=surf(x(2:end-1),y(2:end-1),Un(2:end-1,2:end-1));
    s.EdgeColor = 'none';
    
    colorbar
    colormap jet
    view(2);
    axis equal
    xlim([0 400]);
    ylim([0 400]);
    title(sprintf('time = %1.3f',time), fontsize=20)
    set(gca,'FontSize',20)
    pause(dt/1000)
%     
    % frame = getframe(gcf); %get frame
    % writeVideo(myVideo, frame);
T
end

output = Un;
% close(myVideo)



