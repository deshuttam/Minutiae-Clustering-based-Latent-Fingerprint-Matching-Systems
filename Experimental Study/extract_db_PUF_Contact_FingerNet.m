%    Author: Joshua Abraham
%    Email: algorithm007@hotmail.com
%    Description: Extracts and stores the features of a fingerprint database.
%                 Currently, the extraction is tuned for the FVC2002 DB1 database.  
%                 All features are stored in csv files in the database directory.
%
%
%
%

close all
clear all
clc

myFolder = 'E:\PhD\Matlab backup-20220704T035721Z-001\Matlab backup\sc_minu_Backup_16-12-2020\temp\';
if exist(myFolder, 'dir') ~= 7
  Message = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(Message));
  return;
end

filePattern = fullfile(myFolder, '*.bmp');
jpegFiles   = dir(filePattern);
for kk = 1:length(jpegFiles)
  baseFileName = jpegFiles(kk).name;
  fullFileName = fullfile(myFolder, baseFileName);

im = imread(fullFileName);

if ndims(im) == 3
   im = rgb2gray(im);
end

% Binarize the image
disp(['Extractingfeaturesfrom' baseFileName ' ...']);

image=im;

image(:,:,1)>160;

[newim, binim, mask, reliability] =  testfin_FingerNet_fft(image,baseFileName);
%[newim, binim, mask, reliability] =  FingerNet_testfin_skelonly(image,baseFileName);
end 


files = dir('F:\PhD\Software\Matlab\sc_minutia\sc_minutia\*.bmp');
cd  'F:\PhD\Software\Matlab\sc_minutia\sc_minutia';
IMPRESSIONS_PER_FINGER=2016;

file_names = {files.name};
index1 = 1;
while index1 <=1
% finger_features=struct('TXT',[],'M',[]); 
 finger_features=struct('TXT',[],'M', [], 'O', [], 'R', [], 'RO',[], 'OIMG', [], 'OREL', []); 
  for i=0:IMPRESSIONS_PER_FINGER-1
      im=(char(file_names(index1 +i)));
       img = imread(char(im));
       [m,n]=size(img(:,:,1));
   
      finger_features = extract_finger_PUF_contact(char(file_names(index1 + i)));

       file_a = file_names(index1 + i);
       
       name=strrep(char(file_a),' ','_');
      filename = name;
      pattern = '.bmp';
      replacement = '';
      res=regexprep(filename,pattern,replacement);
 
      
    fOut = sprintf('%s.txt', char(file_a));
    csvwrite(fOut, finger_features.TXT);
     
      
       name=strrep(char(file_a),' ','_');
      filename = name;
      pattern = '.bmp';
      replacement = '';
      res=regexprep(filename,pattern,replacement);
     FileName=[name '.txt']; 
      pattern = '.bmp';
      replacement = '';
    grayImage = uint8(importdata(FileName));
     % imwrite(grayImage, [res, 'tif']);
     imwrite(grayImage,sprintf('%s.jpg',res)); 

  end
index1 = index1 + IMPRESSIONS_PER_FINGER;
end
  


