function [ res ] = predict(Alpha,Y,K,b)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
N = size(K,2);
H = Y .* Alpha;
H = repmat(H,1,N);
T = H .* K;
res = sum(T,1)+b;

end

