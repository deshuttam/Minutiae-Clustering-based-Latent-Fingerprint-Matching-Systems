%    Author: Joshua Abraham
%    Email: algorithm007@hotmail.com
%    Description: Extracts and stores the features of a fingerprint database.
%                 Currently, the extraction is tuned for the FVC2002 DB1 database.  
%                 All features are stored in csv files in the database directory.
%
%
%
%
%files = dir('H:\PhD\Software\Matlab\sc_minutia\sc_minutia\DB1_B\*.tif');
%cd  'H:\PhD\Software\Matlab\sc_minutia\sc_minutia\DB1_B\';


%files = dir('H:\PhD\Software\Matlab\sc_minutia\sc_minutia\IIITD_LDB_500ppi\*.bmp');
%cd  'H:\PhD\Software\Matlab\sc_minutia\sc_minutia\IIITD_LDB_500ppi\Minutiae';

files = dir('H:\PhD\Software\Matlab\sc_minutia\sc_minutia\DB1_B\*.tif');
cd  'H:\PhD\Software\Matlab\sc_minutia\sc_minutia\DB_IITD_1000ppi_Minutiae\';


%files = dir('H:\PhD\Software\Matlab\sc_minutia\IIITD_LDB\*.jpg');
%cd  'H:\PhD\Software\Matlab\sc_minutia\sc_minutia\IIITD_LDB\Minutiae\';


IMPRESSIONS_PER_FINGER=2;
file_names = {files.name};

index1 = 1;
while index1 <=3
  finger_features=struct('X', [], 'TXT',[],'M', [], 'O', [], 'R', [], 'N', [], 'RO',[], 'OIMG', [], 'OREL', []); 
 %finger_features=struct('TXT',[],'M', [], 'O', [], 'R', [], 'RO',[], 'OIMG', [], 'OREL', []); 
  for i=0:IMPRESSIONS_PER_FINGER-1
      fname=file_names(index1+i);
       img = imread(char(fname));
       img=imresize(img, [388,374] );
       [m,n]=size(img(:,:,1));
      %finger_features = extract_finger(files(index1).name);
     finger_features = extract_finger(char(file_names(index1 + i)));
       file_a = file_names(index1 + i);
      
   %  file_a=files(index1).name;
     fOut = sprintf('%s.X', char(file_a));
    csvwrite(fOut, finger_features.X);
      
      fOut = sprintf('%s.txt', char(file_a));
      csvwrite(fOut, finger_features.TXT);
      fOut = sprintf('%s.m', char(file_a));
      csvwrite(fOut, finger_features.M);
      fOut = sprintf('%s.o', char(file_a));
      csvwrite(fOut, finger_features.O);
      fOut = sprintf('%s.r', char(file_a));
      csvwrite(fOut, finger_features.R);
      fOut = sprintf('%s.n', char(file_a));    
     csvwrite(fOut, finger_features.N); 
      fOut = sprintf('%s.ro', char(file_a));                                           
      csvwrite(fOut, finger_features.RO);   
      fOut = sprintf('%s.oi', char(file_a));                                           
      csvwrite(fOut, finger_features.OIMG);   
      fOut = sprintf('%s.or', char(file_a));                                           
      csvwrite(fOut, finger_features.OREL); 
      
      name=strrep(char(file_a),' ','_');
      filename = name;
      pattern = '.tif';
      replacement = '';
      res=regexprep(filename,pattern,replacement);
     FileName=[name '.txt']; 
    grayImage = uint8(importdata(FileName));
    img=imresize(grayImage, [388,374] );
     % imwrite(grayImage, [res, 'tif']);
     imwrite(img,sprintf('%s.jpg',res));
     
   %  immg = imread(filename);
   % print(immg,'-dpdf',sprintf('%s.pdf', res));
   

   end

  file_a = file_names(index1);
 %file_a = substring(char(file_a), 0, strfind(char(file_a), '_')-2);
 str=strfind(char(file_a), '_')-2;
 %str1=str(1:1);
  %str=str-2;
 %str=(extractBefo(char(file_a),0))-2;
 file_a = strrep(char(file_a),'0','2');
  index1 = index1 + IMPRESSIONS_PER_FINGER;
end



