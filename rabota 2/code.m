clear, clc;

%1 ввод с клавиатуры
v = input('vector-stroka:');
w = input('vector-stplbec:');
m = input('matrica:');

%2 генерация матриц специального вида
m0 = zeros(2);
m1 = ones(2);
mr = rand(2);
me = diag([1,1]);

%3 вычисление матрицы по формуле
M = m.*mr+100;
%disp(M);

%4 применение функций для обработки данных
M_size = [size(M, 1), size(M, 2)];
M_max = max(max(M));
M_min = min(min(M));
M_sum = sum(sum(M));
M_prod = prod(prod(M));

A = rand(7);
C = rand(2);

%5 вывод матрицы A
disp('A:');
disp(A);

%6 выделение из матрицы A 
B = A(2:3, 2:3);

%7 умножение матрицы с точкой и без точки
B_1 = C.*B;
B_2 = C*B;

%8 разделение матрицы левым делением с точкой и без точки
%B_3 = B.'\A;
%B_4 = A\B;

%9 транспонирование матрицы
A = A.';
