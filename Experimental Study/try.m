
files = dir('F:\PhD\Software\Matlab\sc_minutia\sc_minutia\NIST_TEST_Excel\1.xlsx');
cd  'F:\PhD\Software\Matlab\sc_minutia\sc_minutia\NIST_TEST_Excel';

tbl = readtable(1.xlsx);
imshow('inputimage.png')
hold on
scatter(tbl.X, tbl.Y) % Names depend on the names in your spreadsheet.
im = getframe(gca);
imwrite(im.cdata, 'outputimage.png');