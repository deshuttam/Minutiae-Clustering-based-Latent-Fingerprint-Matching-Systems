%    Author: Joshua Abraham
%    Email: algorithm007@hotmail.com
%    Description: Extracts and stores the features of a fingerprint database.
%                 Currently, the extraction is tuned for the FVC2002 DB1 database.  
%                 All features are stored in csv files in the database directory.
%
%
%
%
%files = dir('F:\PhD\Software\Matlab\sc_minutia\sc_minutia\FVC_2002_DB1_B\NIST\res\*.tiff');
files = dir('E:\PhD\Matlab backup-20220704T035721Z-001\Matlab backup\Experimental Study\sc_minu_Backup_16-12-2020\FVC2002\DB1_B\*.tif');
cd  'E:\PhD\Matlab backup-20220704T035721Z-001\Matlab backup\Experimental Study\sc_minu_Backup_16-12-2020\';

IMPRESSIONS_PER_FINGER=8;
file_names = {files.name};
START=1; FINISH=10;
index1 = START;
while index1 <= FINISH
  finger_features=struct('X', [], 'M', [], 'O', [], 'R', [], 'N', [], 'RO',[], 'OIMG', [], 'OREL', []); 

  for i=0:IMPRESSIONS_PER_FINGER-1
      finger_features = extract_finger_LLAH(char(file_names(index1 + i)));
      file_a = file_names(index1 + i);
      fOut = sprintf('%s.X', char(file_a));
      csvwrite(fOut, finger_features.X);
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
  end

  file_a = file_names(index1);
  file_a = substring(char(file_a), 0, findstr(char(file_a), '_')-2);
  index1 = index1 + IMPRESSIONS_PER_FINGER;
end




