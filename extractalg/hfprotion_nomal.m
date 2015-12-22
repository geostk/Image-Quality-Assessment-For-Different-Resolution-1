function sqrsum_high=hfprotion_nomal(image_re_dct,height_de,width_de)
[height,width]=size(image_re_dct);
if (height==height_de) && (width==width_de)
    space=0;
elseif (height==height_de) && (width>width_de)
    t1=image_re_dct(1:height,width_de+1:width,1);
    space=t1(:);
elseif (height>height_de) && (width==width_de)
    t2=image_re_dct(height_de+1:height,1:width,1);
    space=t2(:);    
else
    t1=image_re_dct(1:height,width_de+1:width,1);
    t1=t1(:);
    t2=image_re_dct(height_de+1:height,1:width_de,1);
    t2=t2(:);
    space=[t1;t2];   
end
ac=image_re_dct(1:height,1:width,1);
ac=ac(:);
ac=ac(2:end);
acsum=sum(ac.^2);
hfsum=sum(space.^2);
sqrsum_high=hfsum/acsum;
end