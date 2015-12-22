function CSF=HVScal(img,d,h)
[n,~]=size(img);
a=0.31;
b=0.69;
c=0.29;
f=(pi*d*n)/(180*h*2*2);
Adjust=sqrt(0.25+(1/(pi^2))*log(2*pi*f/11.636+sqrt(4*pi^2*f^2/(11.636^2)+1))^2);
H=(a+b*f)*exp(-c*f);
CSF=Adjust*H;
end