function [ssim, sqrsum_high, half_sqrsum]=imageassessment_DCT(image_re,image_de,d,h)
[height_re,width_re]=size(image_re);
[height_de,width_de]=size(image_de);
image_re_dct=dct2(image_re);
%Low Frequency extract
image_re_dct_down=image_re_dct(1:height_de,1:width_de).*sqrt((height_de*width_de)/(height_re*width_re));
image_re_down=idct2(image_re_dct_down);
%call SSIM
[ssim_raw,~]=ssim_index(image_re_down,image_de);
%HVS calculation
hvspara=HVScal(image_de,d,h);
ssim=ssim_raw*hvspara;
%High Frequency extract
sqrsum_high=hfprotion_nomal(image_re_dct,height_de,width_de);
%Half High Frequency extract
half_sqrsum=hfprotion_nomal(image_re_dct,height_re/2,width_re/2);
end