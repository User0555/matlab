clear, clc;

%1)
axis tight;
hold on;

fplot('x*exp(x)', [-pi pi]);
text(2.7, 38.99,' x*exp(x)');
fplot('sin(x) + x^2', [-pi pi]);
text(2.2, 5,' sin(x) + x^2');

hold off;

%2)

y1 = zeros(100);
y2 = zeros(100);

for i = 1:100
    x = -51 + i;
    if(x >= 0)
        y1(i) = sqrt(1 + 2*(x^2) - sin(x)^2);
    end
    
    if(x < 0)
        y2(i) = (2 + x)/((2+exp(-0.1*x))^(1/3));
    end
end

x = -pi:pi/50:pi;
y = sqrt(1 + 2*(x.^2) - sin(x).^2).*(x>=0) + ((2 + x)./((2+exp(-0.1*x)).^(1/3))).*(x<0);

figure;
hold on;

plot(y, 'bo-');

axis([0 100 -1 10]);
grid on;

xlabel('X');
ylabel('Y');

hold off;