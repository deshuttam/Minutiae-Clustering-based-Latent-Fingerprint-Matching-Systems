# Experimental Study on Latent Fingerprint Matching Using Clustered Minutiae Patterns
By Uttam U. Deshpande et al.,


A robust hash-based indexing techniques are proposed to perform matching on large latent fingerprint databases. In these methods, minutia local neighborhood information is extracted to create minutiae features. These obtained minutiae features are invariant to scale, translation, rotation and each minutia is represented as feature vector. This information is further used to construct hash-table and matching is performed
* To understand the implementation details, refer to the following paper, https://doi.org/10.1007/978-981-13-9184-2_35


## Introduction 
Latent minutiae fingerprints suffer from low resolution, background noise and non linear distortions. To address these problems, a minutiae feature based hash index
method is required. First we begin with minutiae feature extraction. After obtaining minutiae features, a fixed length minutiae descriptor is created to perform matching.
This descriptor is based on the neighborhood geometry pattern and is invariant to affine minutiae deformations. Hence, it can be directly applied on minutiae based templates. Another advantage of using this descriptor is that there is no need to detect singular points to align the templates.

![image](https://user-images.githubusercontent.com/107185323/197578591-02889a6b-3432-4aff-8221-7255660394bb.png)

## Minutiae Feature Extraction
The algorithm extracts the minutiae features from the skeletonized fingerprints. 

![image](https://user-images.githubusercontent.com/107185323/197579748-b189e3c1-0c68-4be1-964f-4070362c6d01.png)

The algorithm examines the thinned image containing the pixel ‘p’ after the thinning operation and locates minutiae. A Crossing-Number (CN) selects a value from 8-neighborhood pixels (3 x 3 windows) with ‘p’ as a center and traversing in an anticlockwise (circular) manner.

![image](https://user-images.githubusercontent.com/107185323/197579810-df6e068a-e2b0-4a86-a1ca-38fcf962eb5b.png)

## Latent minutiae representation
After extracting the minutiae features, a fixed-length local Minutiae Arrangement Vectors (MAV) for a complete image based on the distinctive Minutiae neighborhood Arrangements (MA) is defined. Fingerprint hash-table from the MAV is constructed for the gallery fingerprint database. Similarly, we build the hash table for input probe (query) fingerprints and compare the MAV from both tables to determine the fingerprint similarity. The benefit of the proposed approach is that it does not perform prior fingerprint alignment and does not depend on singular or key points. In the proposed work, we use combinations of different minutiae triangular structures to generate the invariants. Next, we explain the fingerprint registration and retrieval process. 

![image](https://user-images.githubusercontent.com/107185323/197580291-b220f096-ef66-408b-9e7f-66476fc9301d.png)


![image](https://user-images.githubusercontent.com/107185323/197580923-e92d1fee-e427-4df0-b56e-7e65ea2182aa.png)

### Fingerprint Hash-Table and Matching

Hash index is calculated using the ‘HTindex’ formula. Here, MAV is the one-dimensional minutiae arrangement vector of length mC4, ‘k ‘is the quantization level used to discretize the IAvg values, and ‘HTsize’ is the size of the hash table. The hash value is used to identify the query fingerprint and matching results are obtained.

![image](https://user-images.githubusercontent.com/107185323/197580966-96588d14-4e6f-4a33-a8f8-a9fdd5f34bf8.png)


The repository includes:

* Source code for Fingerprint Preprocessing and Feature Extraction.
* Matlab code.
* Source code for Latent minutiae representation, Fingerprint Hash-Table Construction and Matching.
* Visual Studio code, C, C++, Shell Script codes.

### Citing

@InProceedings {10.1007/978-981-13-9184-2_35,
author= {Deshpande, Uttam U. Deshpande},
editor= {Santosh, K. C. and Hegadi, Ravindra S.},
title= {Experimental Study on Latent Fingerprint Matching Using Clustered Minutiae Patterns},
booktitle= {Recent Trends in Image Processing and Pattern Recognition},
year= {2019},
pages= {381-394},
DOI= {https://doi.org/10.1007/978-981-13-9184-2_35},
isbn= {978-981-13-9184-2},
}

### Requirements: Software
* MATLAB
* Visual Studio

## Preprocessing and Feature Extraction
* Place input images in `Preprocessing` folder.
* Run `extract_db_FVC_2004_DB_4.m` code to preprocess and extract the minutiae features.
* Obtain the minutiae images in `Preprocessing` folder.

## Latent minutiae representation, and Hash-Table Construction
* Place the minutia image obtained in the previous step into `jpg` folder.
* Run `makedb` command to construct the hash table from the latent minutiae cluster.
* Refer the work for refernce https://github.com/opu-imp/LLAH-Nakai.

## Matching
* Run `server.exe` command.
* Run `client.ext` command to turn the camera on.
* Print the minutiae image to be tested on a paper and hold infront of the camera to perform matching.
* Refer the work for refernce https://github.com/opu-imp/LLAH-Nakai.
