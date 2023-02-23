clc
clear 
close all

Va = 67.969;
Vg = 42.993;
Vc = 59;
Vd = 1.5*Vc;
V = 0:0.1:Vd;
 
rho = 0.95697;
Sw = 22.42;
Clmax = 1.73;
mtow = 2378.8;

i = 1;
while V(i)<Va
    n(i) = (0.5*rho*V(i)^2*Sw*Clmax)/(mtow*9.81);
    i = i+1;
end

while V(i)<=Vd
    n(i) = 3.674;
    i = i+1;
    if i == length(V)+1
        break
    end
end

V1 = [V,Vd];
n(i) = 0;
i = 1;
V2 = V;

while V2(i)<Vg
    n1(i) = -(0.5*rho*V(i)^2*Sw*Clmax)/(mtow*9.81);
    i = i+1;
end

while V2(i)<=Vc
    n1(i) = -1.470;
    i = i+1;
end

while V2(i)<=Vd
    n1(i) = (-1.470/(Vc-Vd))*V(i) + (1.470*Vd/(Vc-Vd));
    i = i+1;
    if i == length(V)+1
        break
    end
end

V = [V1, flip(V)];
n = [n, flip(n1)];

plot(V,n)
xlim([0,Vd+10])
ylim([-2,4])
hold on

n1M = 3.468;
n1m = -1.468;
n2M = 2.62;
n2m = -0.62;
n3M = 2.22;
n3m = -0.22;

X = [0, Vc, Va, Vd, Vd, Va, Vc, 0];
Y = [1, n2M, n1M, n3M, n3m, n1m, n2m, 1];
plot(X,Y);
hold off
ylabel('Load Factor, n');
xlabel('Velocity, V [m/s]');
legend('V-n diagram without gusts', 'V-n diagram with gust');