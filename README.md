# Image-Quality-Assessment-For-Different-Resolution
# Introduction
Nowadays people use different devices to acquire visual information, so an algorithm to assess quality of images with different resolution is in need. In this article, we propose a full reference image quality assessment algorithm for different resolution and test its performance. Moreover, we have tested and analyzed the difference of choosing different regression training methods to the same parameters extracted. Hope to provide a reference for the choice of training method in future development of image quality assessment.

# Analytics

Full-reference image quality assessment for different resolution can be divided into 5 parts, introducing the effect of quality loss due to degradation, different assessment basis of observer because of resolution and content difference and Human Visual System. 

1)DCT Transform 
According to the energy concentration property of DCT, the DCT coefficients of reference image is able to divided into low frequency part, high frequency part and half high frequency part for calculation. 

2)SSIM calculation of low frequency part of reference image and target image 
The SSIM calculation of low frequency part of reference image and target image is to measure the loss of quality in the process of degradation. Multiplying with the Human Visual System parameter acquired by the distance from observer to screen, the height of screen and the resolution of image, the SSIM is also able to reflect the influence of observing pattern. 

3)The proportion of high frequency part of reference image to all alternating current coefficients 
The characteristic of high frequency part is described in 2.4. Detailed calculation is to compute the square sum of all high frequency coefficients of reference image, representing the loss in energy due to the reduction in resolution. Then compute the square sum of all alternating current coefficients, representing the total energy of details in reference image. Finally, compute the quotient of the square sum of all high frequency coefficients to the square sum of all alternating current coefficients, representing the proportion of loss in details due to the reduction of resolution. The quotient has a high correlation with the content and resolution. For image with same resolution, image rich in detail has a higher proportion than image with less detail. For images with the same content, the higher the resolution is, the less the proportion is. As a result, this proportion satisfies the requirement of extracting parameter related to content and resolution. 

4)The proportion of half high frequency part of reference image to all alternating current coefficients 
The half high frequency part of reference image is the rest part of reference image to an imaginary target image with the half height and width of the reference image. The calculation process is similar to the proportion of high frequency part of reference image to all alternating current coefficients. This proportion is only related to the content of image. 

Finally, three reasonable parameters related to image quality assessment are extracted. Input the three parameters into the trained model of regression, to get the objective quality score of the image. 

# Dataset
The image dataset with different resolution is created by us. We choose the original 8 images with resolution 720*1280 varying in content and down sample them into three different resolution:720*1280, 540*960, 360*640. Then we degrade them with blur, jpeg compression and noise with different parameters. The total number of images is 504. We collect the subject quality score of the dataset by calculate the average score of ten people. We split the dataset to training set with 72 image, 24 for each resolution.

# Language
MATLAB,OpenGL,Spark

# Code structure
The openGLplayer folder contain the test environment for collecting subjective score.
The imagedataset folder is the image dataset we create.
The extractalg folder is our algorithm to extract parameters from high resolution reference image and low resolution target image.
The trainandtest folder is the training and testing algorithm. The training set is described by trainingset.txt

# Run extract parameter algorithm
Run the imgassess.m code to get the parameter.
