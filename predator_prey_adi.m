function final_adi_v6_predator_prey
clf; clear all;

N = 100; %number of points 
h = 400/(N+1); %grid spacing

dt = 1/3;

Du = 1; %diffusion coefficient of u (alpha_1)
Dv = 1; %diffusion coefficient of v (alpha_2)

a = (Du*dt)/(2*h^2);
a2 = (Dv*dt)/(2*h^2);

alpha = 0.4;
beta = 2.0;
gama = 0.6;

uin = (alpha*gama)/(beta-gama);
vin = (1-uin)*(uin+alpha);

f = @(u,v) u.*(1-u)-(u.*v)./(u+alpha);
g = @(u,v) (beta*u.*v)./(u+alpha) - gama*v;

%Neumann boundary conditions


x = [0:h:400];
y = [0:h:400];

%% initial condition
U0 = NaN(N,N);
V0 = NaN(N,N);

ic1 = @(x,y) uin-2*10^(-7)*(x-0.1*y-225)*(x-0.1*y-675);
ic2 = @(x,y) vin-3*10^(-5)*(x-450)-1.2*10^(-4)*(y-150);

for j=1:N
    for k=1:N
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

s=surf(x(2:end-1),y(2:end-1),U0);
    s.EdgeColor = 'none';
    
    colorbar
    colormap jet
    view(2);
    axis equal
    xlim([0 400]);
    ylim([0 400]);
    title(sprintf('time = %1.3f',0), fontsize=20)
    set(gca,'FontSize',20)

%surf(x(2:end-1),y(2:end-1),V0); 
%creating matrix A to solve at each time step Au = B and Au = C, matrix A
%does not change at the time steps, matrix B and C need to be updated
A = zeros(N,N);
A(1,1) = 1+2*a;
A(1,2) = -2*a;
A(N,N-1) = -2*a;
A(N,N) = 1+2*a;
for i=2:N-1
    A(i,i-1) = -a;
    A(i,i) = 1+2*a;
    A(i,i+1) = -a;
end
A;

A2 = zeros(N,N);
A2(1,1) = 1+2*a2;
A2(1,2) = -2*a2;
A2(N,N-1) = -2*a2;
A2(N,N) = 1+2*a2;
for i=2:N-1
    A2(i,i-1) = -a2;
    A2(i,i) = 1+2*a2;
    A2(i,i+1) = -a2;
end
A2;

B = zeros(N,N);
B(1,1) = 1-2*a;
B(1,2) = 2*a;
B(N,N-1) = 2*a;
B(N,N) = 1-2*a;
for i=2:N-1
    B(i,i-1) = a;
    B(i,i) = 1-2*a;
    B(i,i+1) = a;
end
B;

B2 = zeros(N,N);
B2(1,1) = 1-2*a2;
B2(1,2) = 2*a2;
B2(N,N-1) = 2*a2;
B2(N,N) = 1-2*a2;
for i=2:N-1
    B2(i,i-1) = a2;
    B2(i,i) = 1-2*a2;
    B2(i,i+1) = a2;
end
B2;

time = 0;

Un = U0;
Vn = V0;
%s1=surf(x,y,Un);
%s1=surf(x(2:end-1),y(2:end-1),Vn);
zlim([-1 2])
title(sprintf('time = %1.3f',time))


%% Initialize video
% myVideo = VideoWriter('prey','MPEG-4'); %open video file
% myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
% open(myVideo)


for T=1:3000

    Ustar = NaN(N,N);
    Vstar = NaN(N,N);

    for k=1:N

        RHS = B*Un(:,k)+(dt/2)*f(Un(:,k),Vn(:,k));
        Ustark = A\RHS; %solving for Ustark
        Ustar(1:N,k) = Ustark; %Updating the k-th column of Ustar
        
        RHS = B2*Vn(:,k)+(dt/2)*g(Un(:,k),Vn(:,k));
        Vstark = A2\RHS; %solving for Vstark
        Vstar(1:N,k) = Vstark; %Updating the k-th column of Vstar
    end

    Unp1 = NaN(N,N);
    Vnp1 = NaN(N,N);

    for j=1:N

        RHS = B*(Ustar(j,:))'+(dt/2)*f((Ustar(j,:))',(Vstar(j,:))');
        Unp1j = A\RHS; %solving for U(n+1)_j
        Unp1(j,1:N) = Unp1j; %updating the j-th row of U(n+1)
        
        RHS = B2*(Vstar(j,:))'+(dt/2)*g((Ustar(j,:))',(Vstar(j,:))');
        Vnp1j = A2\RHS; %solving for V(n+1)_j
        Vnp1(j,1:N) = Vnp1j; %updating the j-th row of V(n+1)
    end
    Un = Unp1;
    Vn = Vnp1;
    time = time +dt;
    %if T==300 || T==600 || T==900 || T==1200 || T==5000 || T==6000 || T==7000 || T==8000
    s=surf(x(2:end-1),y(2:end-1),Un);
    s.EdgeColor = 'none';
    
    colorbar
    colormap jet
    view(2);
    axis equal
    xlim([0 400]);
    ylim([0 400]);
    title(sprintf('time = %1.3f',time), fontsize=20)
    set(gca,'FontSize',20)
    %shg
    %end
    pause(dt/1000)
    
    % frame = getframe(gcf); %get frame
    % writeVideo(myVideo, frame);
T
end

% close(myVideo)



