function [ Alphas,fval,exitflag ] = svm_learn( X,Y,type,p)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[len] = length(Y);
H = 0.5*((Y*Y').* kernel(X,X,type,p));
f = -ones(len,1);
A = [];
B = [];
Aeq = Y';
beq = 0;
[Alphas,fval,exitflag] = quadprog(H,f,A,B,Aeq,beq,zeros(len,1));
end

