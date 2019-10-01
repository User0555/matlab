a = 3.5;
b = 0.35;
x = 1.523;
k = -2;

y=(10^4)*((a*x)/(b^2))-abs((a-b)/(k*x))+((log10(3))/((a*(x^2)+(b^2))^(1/3)))-exp(-k*x);
 
disp(y);

vec1 = [a,b,x,k];
vec2 = [1,1,1,1];

dif_v = vec1 - vec2;
disp(dif_v);

max_v = max(vec1);
disp(max_v);