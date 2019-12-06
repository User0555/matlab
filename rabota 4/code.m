clear, clc;

%1)
str_1 = 'Петров Олег 1980 5 5 5 4 4 5';
str_1_count = sum(str_1 ~= ' ');
disp('1)');
disp(str_1_count);

%2)
str_arr = strsplit(str_1);

tmp_1 = str_arr(1);
tmp_2 = str_arr(length(str_arr));
str_arr(1) = tmp_2;
str_arr(length(str_arr)) = tmp_1;

new_str_1 = '';
for i = 1:length(str_arr)
    new_str_1 = [new_str_1 char(str_arr(i)) ' '];
end

disp('2)');
disp(str_1);
disp(new_str_1);

%3)

str_arr = strsplit(str_1);
for i = 1:length(str_arr)
    switch char(str_arr(i))
        case '1'
            str_arr(i) = {'один'};
        case '2'
            str_arr(i) = {'два'};
        case '3'
            str_arr(i) = {'три'};
        case '4'
            str_arr(i) = {'четыре'};
        case '5'
            str_arr(i) = {'пять'};
        case '6'
            str_arr(i) = {'шесть'};
        case '7'
            str_arr(i) = {'семь'};
        case '8'
            str_arr(i) = {'восемь'};
        case '9'
            str_arr(i) = {'девять'};
        case '0'
            str_arr(i) = {'ноль'};
    end
end

new_str_2 = '';
for i = 1:length(str_arr)
    new_str_2 = [new_str_2 char(str_arr(i)) ' '];
end
disp('3)');
disp(new_str_2);

%4)
num_arr = [];
str_arr = strsplit(str_1);
for i = 1:length(str_arr)
    num_arr = [num_arr str2num(char(str_arr(i)))];
end
disp('4)');
disp(num_arr);

%6)
fid = fopen('in6.txt', 'r');
file_data = textscan(fid,'%s','delimiter','\n'); 

arr_1 = str2num(char(strsplit(char(file_data{1}{2}))));
arr_2 = str2num(char(strsplit(char(file_data{1}{3}))));
arr_3 = str2num(char(strsplit(char(file_data{1}{4}))));

disp('5)');
disp(arr_1);
disp(arr_2);
disp(arr_3);

%7)
FileHtml = fopen('lab4_6.html','wt'); 

fprintf(FileHtml, '<HTML>\n');
fprintf(FileHtml, '<head>\n');
fprintf(FileHtml, '<title>Отчет по лабораторной работе \n');
fprintf(FileHtml, '</title>\n');
fprintf(FileHtml, '<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows">\n');
fprintf(FileHtml, '</head>\n');
fprintf(FileHtml, '<body>\n');
fprintf(FileHtml, '<center><H3>ОТЧЕТ<br>по лабораторной работе</h3></center>\n');

n1=1;
n2=5;
fprintf(FileHtml, '<h3>Исходные данные</h3>\n');
fprintf(FileHtml, '<br>%-5.0f%-5.0f\n', n1, n2);

h1 = figure('Name','Модельное изображение (исходное Image0)im3d');
hold on
%выполнить расчеты
x = 1:0.01:5;
for beta=-0.5:0.1:0.5
y=exp(beta*x).*sin(6*x);
plot(x,y)
end
hold off

saveas(h1, 'var6.jpg');

fprintf(FileHtml, '<br><br> Графики \n');
fprintf(FileHtml, '<a href="var6.jpg">');
fprintf(FileHtml, '<br><img src="var6.jpg" height="200" >\n');
fprintf(FileHtml, '</a>\n');
fprintf(FileHtml, '</body>\n');
fprintf(FileHtml, '</HTML>\n');
fclose(FileHtml);

disp('Вычисления завершены');

