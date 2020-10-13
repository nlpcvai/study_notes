# Multimedia technology

1. what are four modes of operation in JPEG compression?

   sequential DCT-based, progressive DCT-based, lossless, and hierarchical  

2. Assume that we have the following quantized AC DCT coefficients, 0000000000000000003005

   write down the possible intermediate sysbol pairs.

   (15,0)  (2,2)(3)  (2,3)(5)

3. In JPEG compression, if three components of an image are interleaved, how many scans are there in a frame?

   A frame consists of one scan if all three components are
   interleaved together.  

4. In JPEG, an image has three components. The encoding of three components is interleaved. Assume that the sampling factors are

$$
H_1=2, V_1=2, H_2=1, V_2=1, H_3=1, V_3=1
$$

​	 respectively. Determine the number of data units in an MCU.
$$
2 * 2 + 1 * 2 + 1 * 1 = 7
$$

1. What are markers used for in JIF?

   Markers serve to identify the various structural parts of
   the compressed data formats. Most markers start
   marker segments containing a related group of
   parameters.  

2. Describe the full name of SOI, EOI, SOF, SOS.

   Start of image marker

   End of image marker

   Start of frame marker

   Start of Scan marker

3. What is JPEG file interchange format used for?

   JPEG File Interchange Format is a minimal file format which
   enables JPEG bitstreams to be exchanged between a wide
   variety of platforms and applications.  

4. An image contains 1 frame in the cases of sequential and progressive coding processes.

### T/F questions

1. H.263 is used in DVD.          --- F

2. The bit stream syntax is specified in MPEG video coding standard.  --- T

3. The encoding process is specified in MPEG coding standard.  --- F

4. MPEG-1 allows B frames.       --- T

5. P frames require more data than I frames because of temporal prediction.  F

6. In video coding the position of slices may change from picture to picture.  T

7. In video coding the GOP header specifies the temporal reference parameter.  --- F

8. H.264 baseline profile allows B frames.   --- F

9. H.261 has a motion vector resolution of 1/2 pixel.  --- F

10. H.264 has a motion vector resolution of 1/4 pixel.  --- T

11. In H.264 spatial intra prediction is not supported.   --- F

12. H.264 main profile supports CABAC.  --- T

13. A Main or Extended Profile picture in H.164 coding contains a mixture of I and P slices.    --- F

    and B.

14. In H.264, Intra 4x4 frame prediction is suited for coding very smooth area of a picture.      --- F

    16x16 is suited for coding very smooth area.

15. In H.264, the encoder bases its prediction on original video frame samples.   --- F

16. The core part of the DCT transform in H.264 is multiply-free.  --- T

17. In H.264 Exp-Golomb code is to encode transform coefficients.    --- F

18. The maximum of trailing ones in CAVLC used by H.264 is 3.   --- T

19. Human visual system is more sensitive to luminance than color.   --- T

20. In H.264 CAVLC, each run of zeros needs to be encoded.  --- T

21. The audio loudness only depends on the audio intensity.     --- F

    The audio loudness depends on duration, temporal and
    spectral structure in addition to intensity.  

22. In H.264 predictive coding is used to signal 4x4 intra modes.    --- T

    ![image-20200707112451781](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707112451781.png)

    4.   ---  F

       The masking curve levels are highest at frequencies
       near the masker frequency.  

    5. ---  F

       MPEG uses 16x16-pixel MC-prediction to reduce the temporal
       redundancies inherent in the video.  

23. ![image-20200707110759385](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707110759385.png)

    

![image-20200707111012545](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111012545.png)

1.  --- F

   In fact we don’t need all of the Fourier transform data to
   fully reconstruct the signal in the time domain.  

2. --- T

3. --- F

   Side information block is 136 bits long for single channel,
   and 256 bits long for dual channels.  

4. --- F

   Scalefactors serve to color the quantization noise to fit
   the varying frequency contours of the masking threshold.   

5. --- F


![image-20200707111052358](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111052358.png)

![image-20200707111116418](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111116418.png)

1. --- T
2. --- ?
3. --- F
4. --- T
5. ---  ?

![image-20200707111129369](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111129369.png)

![image-20200707111144131](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111144131.png)

![image-20200707111212698](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111212698.png)

![image-20200707111222246](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111222246.png)

![image-20200707111230972](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111230972.png)

![image-20200707111238118](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111238118.png)

![image-20200707111245332](C:\Users\DELL\AppData\Roaming\Typora\typora-user-images\image-20200707111245332.png)





