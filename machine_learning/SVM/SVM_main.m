clear
clc
type = 2;%2��Ӧ����ʽ�˺��� 3��Ӧ��˹�˺���
p = [0,1,3];% kernel����
C = 1e5;
load('data.mat');
X = data(:,[1,2]);
Y = data(:,3);
X(51,:) = [1.7,3.2];
save('data.mat','data');
[len,~] =size(X);


[ Alphas,fval,exitflag ] = svm_learn( X,Y,type,p);
sv_indexs = find(Alphas>sqrt(eps(8)));%�Ҵ���0��alpha

%��b��ֵ
indexs = sv_indexs(Alphas(sv_indexs)<C);%��<C
if(length(indexs)<=0)
   error('Cֵ����'); 
end
Alpha_Temp  = repmat(Alphas(sv_indexs),1,length(indexs));
Y_Temp  = repmat(Y(sv_indexs),1,length(indexs));

b = mean(Y(indexs)' - sum(Alpha_Temp.* Y_Temp .* kernel(X(sv_indexs,:),X(indexs,:),type,p),1));
%��train�����
[f1,f2] = plotData(X,Y);
%�����ߵĵȸ���
[x1,x2] = meshgrid(min(X(:,1))-0.1:0.01:max(X(:,1))+0.1,min(X(:,2))-0.1:0.01:max(X(:,2))+0.1);
[M,N] = size(x1);    
Length = M*N;                    
Datas = [reshape(x1,1,Length);reshape(x2,1,Length)]; 
result = predict(Alphas(sv_indexs), Y(sv_indexs), kernel(X(sv_indexs,:), Datas',type,p),b);

Z = reshape(result,[M,N]);
hold on;
contour(x1,x2,Z,[0,0],'g');%���ȸ���

% %����֧������
f3 = plot(X(sv_indexs, 1), X(sv_indexs, 2), 'ms','MarkerSize', 10,'LineWidth',1.5);
%����˵��
xlabel('x1');
ylabel('x2');
legend([f1,f2,f3],'������','������','֧������');
hold off