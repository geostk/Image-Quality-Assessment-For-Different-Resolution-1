clear all
close all
% system('svm-scale -l -1 -u 1 -s range train_para.txt > train_scale');
% system('svm-train -b 1 -s 4 -g 0.05 -c 1024 -q train_scale model');
% system('svm-scale -r range para_avg_halfsqrsum_720.txt >> test_ind_scaled_720');
% system('svm-predict -b 1 test_ind_scaled_720 model output_720 >>dump');
% load output_720
% system('svm-scale -r range para_avg_halfsqrsum_540.txt >> test_ind_scaled_540');
% system('svm-predict -b 1 test_ind_scaled_540 model output_540 >>dump');
% load output_540
% system('svm-scale -r range para_avg_halfsqrsum_360.txt >> test_ind_scaled_360');
% system('svm-predict -b 1 test_ind_scaled_360 model output_360 >>dump');
% load output_360
% system('svm-scale -r range para_avg_halfsqrsum.txt >> test_ind_scaled');
% system('svm-predict -b 1 test_ind_scaled model output >>dump');
% load output
% disp('our algorithm');
system('svm-scale -l -1 -u 1 -s range train_ssim.txt > train_scale');
system('svm-train -b 1 -s 4 -g 0.05 -c 1024 -q train_scale model');
system('svm-scale -r range ssim_720.txt >> test_ind_scaled_720');
system('svm-predict -b 1 test_ind_scaled_720 model output_720 >>dump');
load output_720
system('svm-scale -r range ssim_540.txt >> test_ind_scaled_540');
system('svm-predict -b 1 test_ind_scaled_540 model output_540 >>dump');
load output_540
system('svm-scale -r range ssim_360.txt >> test_ind_scaled_360');
system('svm-predict -b 1 test_ind_scaled_360 model output_360 >>dump');
load output_360
system('svm-scale -r range ssim.txt >> test_ind_scaled');
system('svm-predict -b 1 test_ind_scaled model output >>dump');
load output
disp('SSIM');
load para_avg_halfsqrsum.txt
load para_avg_halfsqrsum_720.txt
load para_avg_halfsqrsum_540.txt
load para_avg_halfsqrsum_360.txt
score=[output,para_avg_halfsqrsum(:,1)];
score_720=[output_720,para_avg_halfsqrsum_720(:,1)];
score_540=[output_540,para_avg_halfsqrsum_540(:,1)];
score_360=[output_360,para_avg_halfsqrsum_360(:,1)];
[m,~]=size(score);
[n,~]=size(score_720);
%SROCC
RHO = corr(score(:,1), score(:,2),'type','spearman');
RHO_720 = corr(score_720(:,1), score_720(:,2),'type','spearman');
RHO_540 = corr(score_540(:,1), score_540(:,2),'type','spearman');
RHO_360 = corr(score_360(:,1), score_360(:,2),'type','spearman');
%LCC
Pearson_RHO_360 = calculatepearsoncorr(score_360(:,1), score_360(:,2));
Pearson_RHO_540 = calculatepearsoncorr(score_540(:,1), score_540(:,2));
Pearson_RHO_720 = calculatepearsoncorr(score_720(:,1), score_720(:,2));
Pearson_RHO = calculatepearsoncorr(score(:,1), score(:,2));
%MSE
MSE_360=sum((score_360(:,1)-score_360(:,2)).^2)/n;
MSE_540=sum((score_540(:,1)-score_540(:,2)).^2)/n;
MSE_720=sum((score_720(:,1)-score_720(:,2)).^2)/n;
MSE=sum((score(:,1)-score(:,2)).^2)/m;
%MAE
MAE_360=sum(abs(score_360(:,1)-score_360(:,2)))/n;
MAE_540=sum(abs(score_540(:,1)-score_540(:,2)))/n;
MAE_720=sum(abs(score_720(:,1)-score_720(:,2)))/n;
MAE=sum(abs(score(:,1)-score(:,2)))/m;