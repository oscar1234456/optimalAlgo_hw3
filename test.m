% binary to decimal
% b1 = [0 1 1 0];
% d1 = bi2de(b1);
% s = b1(1:3);
% b2 = [1 2 1 2];
% con = [];
% x = randi([0 1],1,26);
% x1 = bi2de(x(1:13));
% x2 = bi2de(x(14:26));
% 
% t = {};
% for i=1:20
%     x = randi([0 1],1,26);
%     t{i} = x;
% end
% 
% for i=1:20
%     fprintf("now: %d \n",i);
%     t1 = bi2de(t{i}(1:13));
%     t2 = bi2de(t{i}(14:26));
%     fprintf("t1: %d \n",t1);
%     fprintf("t2: %d \n",t2);
% end
% 
% outss = getNewGene(3);

% plot([0,1,2,3],[1,3,5,2])

x = linspace(-600, 600, 50);	% 在 x 軸 [-1.5,4] 之間取 50 點  
y = linspace(-600, 600, 50);	% 在 y 軸 [-3,3] 之間取 50 點  
[xx, yy] = meshgrid(x, y);	% xx 和 yy 都是 50x50 的矩陣  
%zz = sin(xx+yy)+((xx-yy).^2)-1.5.*xx+2.5.*yy+1;	% 計算函數值，zz 也是 50x50 的矩陣
zz = (xx.^2 +yy.^2)/4000 - cos(xx)*cos(yy/sqrt(2))+1;
mesh(xx, yy, zz);		% 畫出立體網狀圖 
% colormap(zeros(1,3));		% 以黑色呈現   
