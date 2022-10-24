%    Author: Joshua Abraham
%    Email: algorithm007@hotmail.com
%    Description: Extracts and stores the features of a fingerprint database.
%                 Currently, the extraction is tuned for the FVC2002 DB1 database.  
%                 All features are stored in csv files in the database directory.
%
%
%
%
files = dir('E:\PhD\Matlab backup-20220704T035721Z-001\Matlab backup\Experimental Study\sc_minu_Backup_16-12-2020\FVC2002\DB1_B\*.tif');
cd  'E:\PhD\Matlab backup-20220704T035721Z-001\Matlab backup\Experimental Study\sc_minu_Backup_16-12-2020\';

IMPRESSIONS_PER_FINGER=5;
file_names = {files.name};

index1 = 1;
while index1 <=1
% finger_features=struct('TXT',[],'M',[]); 
 finger_features=struct('TXT',[],'M', [], 'O', [], 'R', [], 'RO',[], 'OIMG', [], 'OREL', []); 
  for i=0:IMPRESSIONS_PER_FINGER-1
      im=(char(file_names(index1 +i)));
       img = imread(char(im));
       %img=imresize(img, [300,300] );
      %img=imresize(img, [800,768] );
       [m,n]=size(img(:,:,1));
   
      %finger_features = extract_finger(files(index1).name);
     finger_features = extract_finger_FVC(char(file_names(index1 + i)));
    % finger_features = extract_finger_try_final(char(file_names(index1 + i)));
       file_a = file_names(index1 + i);
       
       name=strrep(char(file_a),' ','_');
      filename = name;
      pattern = '.jpg';
      replacement = '';
      res=regexprep(filename,pattern,replacement);
   %  file_a=files(index1).name;
  %   fOut = sprintf('%s.X', char(file_a));
   % csvwrite(fOut, finger_features.X);
      
    fOut = sprintf('%s.txt', char(file_a));
    csvwrite(fOut, finger_features.TXT);
      fOut = sprintf('%s.m', char(res));
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
      pattern = '.jpg';
      replacement = '';
      res=regexprep(filename,pattern,replacement);
     FileName=[name '.txt']; 
      pattern = '.jpg';
      replacement = '';
    grayImage = uint8(importdata(FileName));
     % imwrite(grayImage, [res, 'tif']);
     imwrite(grayImage,sprintf('%s.jpg',res));
     
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



