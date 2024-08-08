function output = final_adi_v3_maybeworking
clf; clear all;

N = 100; %number of points 
h = 400/(N+1); %grid spacing

dt = 1;

Du = 1; %diffusion coefficient of u (alpha_1)
Dv = 0.5; %diffusion coefficient of v (alpha_2)

a = (Du*dt)/(2*h^2);
a2 = (Dv*dt)/(2*h^2);

F = 0.022; %feed rate
K = 0.051; %kill rate

f = @(u,v) -u.*v.^2 + F*(1-u);
g = @(u,v) u.*v.^2 - (F+K).*v;

x = [0:h:400];
y = [0:h:400];

%% initial condition
U0 = NaN(N,N);
V0 = NaN(N,N);

ic1 = @(x,y) 1;
ic2 = @(x,y) 0;

for j=1:N
    for k=1:N
        U0(j,k) = ic1(x(j),y(k));
        %V0(j,k) = ic2(x(j),y(k)) +rand(1);
        if (x(j)>=175) && (x(j)<=225) && (y(k)>=175) && (y(k)<=225)
            V0(j,k) = 1;
        % elseif (x(j)>=320) && (x(j)<=370) && (y(k)>=200) && (y(k)<=250)
        %     V0(j,k) = 1;
        % elseif (x(j)>=110) && (x(j)<=165) && (y(k)>=110) && (y(k)<=165)
        %     V0(j,k) = 1;
        % elseif (x(j)>=215) && (x(j)<=255) && (y(k)>=210) && (y(k)<=220)
        %     V0(j,k) = 1;
        % elseif (x(j)>=20) && (x(j)<=206) && (y(k)>=20) && (y(k)<=30)
        %     V0(j,k) = 1;
        else
            V0(j,k) = ic2(x(j),y(k));
        end
    end
end

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
A = sparse(A);

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
A2=sparse(A2);

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
B=sparse(B);

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
B2=sparse(B2);

time = 0;

Un = U0;
Vn = V0;

%% time loop
for T=1:6000

    Ustar = NaN(N,N);
    Vstar = NaN(N,N);


    for k=1:N

        RHS = B*Un(:,k)+(dt/2)*f(Un(:,k),Vn(:,k));
        RHS = sparse(RHS);
        Ustark = A\RHS; %solving for Ustark
        Ustar(1:N,k) = Ustark; %Updating the k-th column of Ustar
        
        RHS = B2*Vn(:,k)+(dt/2)*g(Un(:,k),Vn(:,k));
        RHS = sparse(RHS);
        Vstark = A2\RHS; %solving for Vstark
        Vstar(1:N,k) = Vstark; %Updating the k-th column of Vstar
    end

    Unp1 = NaN(N,N);
    Vnp1 = NaN(N,N);


    for j=1:N

        RHS = B*(Ustar(j,:))'+(dt/2)*f((Ustar(j,:))',(Vstar(j,:))');
        RHS = sparse(RHS);
        Unp1j = A\RHS; %solving for U(n+1)_j
        Unp1(j,1:N) = Unp1j; %updating the j-th row of U(n+1)
        
        RHS = B2*(Vstar(j,:))'+(dt/2)*g((Ustar(j,:))',(Vstar(j,:))');
        RHS = sparse(RHS);
        Vnp1j = A2\RHS; %solving for U(n+1)_j
        Vnp1(j,1:N) = Vnp1j; %updating the j-th row of U(n+1)
    end
    Un = Unp1;
    Vn = Vnp1;
    time = time + dt;
    %if T==1000 || T==2000 || T==3000 || T==4000 || T==5000 || T==6000 || T==7000 || T==8000
    s = surf(x(2:end-1),y(2:end-1),Vn);
    s.EdgeColor = 'none';
    view(2)
    colorbar
    colormap jet
    %view(2);
    axis equal
    xlim([0 400]);
    ylim([0 400]);
    title(sprintf('t = %1.3f, F = %1.3f, k = %1.3f',time,F,K), fontsize=20)
    set(gca,'FontSize',20)
    shg
    %end
    pause(dt/1000)
    
    % frame = getframe(gcf); %get frame
    % writeVideo(myVideo, frame);
T
end
output = Un;
% close(myVideo)



