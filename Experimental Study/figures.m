function [ret] = figures(f1, f2)
% Bibliography
% Thai, Raymond. Fingerprint Image Enhancement and Minutiae Extraction. 
% read image into memory
%
%
filename=f1;

blk_sz_c = 24;
blk_sz_o = 24;
img = imread(filename);

% convert to gray scale
if ndims(img) == 3         % colour image
    img = rgb2gray(img);
end

yt=1;
yb=size(img,2);
xr=size(img,1);
xl=1;

YA=0;
YB=0;
XA=0;
XB=0;

delta_test=0;

for x=1:55
    if numel(find(img(x,:)<200)) < 8
       img(1:x,:) = 255;
       yt=x;
    end
end

for x=225:size(img,1)
    if numel(find(img(x,:)<200)) < 3
       img(x-17:size(img,1),:) = 255;
       yb=x;
       break
    end
end

for y=200:size(img,2)
    if numel(find(img(:,y)<200)) < 1
       img(:,y:size(img,2)) = 255;
       xr=y;
       break
    end
end

for y=1:75
    if numel(find(img(:,y)<200)) < 1
       img(:,1:y) = 255;
       xl=y;
    end	
end

enhimg = img;

[cimg1, o1,fimg,bwimg,eimg,enhimg] =  fft_enhance_cubs(enhimg,blk_sz_o/4);
[cimg, oimg2,fimg,bwimg,eimg,enhimg] =  fft_enhance_cubs(enhimg, blk_sz_o/2);
[cimg2, oimg,fimg,bwimg,eimg,enhimg] =  fft_enhance_cubs(enhimg, blk_sz_o);

[newim, binim, mask, o_rel, orient_img] =  testfin(enhimg);  % testfin is from Dr. Peter Kovesi's code
[cimg, oimg2,fimg,bwimg,eimg,enhimg] =  fft_enhance_cubs(img, -1);
[newim, binim, mask, o_rel, orient_img_m] =  testfin(enhimg);  % testfin is from Dr. Peter Kovesi's code

return
%subplot(1,1,1), subimage(binim), title('a')
%drawnow
%pause
%binim1=(enhimg>120);
%subplot(1,1,1), subimage(binim1), title('a')
%drawnow
%pause

%enhimg=im;

%[c1, ox,f1,bwimg,eimga,img3] = fft_enhance_cubs(img,18);
%[c1, ox,f1,bwimg,eimgb,img6] = fft_enhance_cubs(img,12);
%[nm, bm, mk, o_rel, orient_img_m] =  testfin((histeq(img3) +histeq(img6))/2); 

theta1 = 0.5;

mask_t=mask;

for y=19:size(mask,1)-blk_sz_c*2
    for x=blk_sz_c:size(mask,2)-blk_sz_c*2
      n_mask = 0;
      for yy=-1:1
          for xx=-1:1
              y_t = y + yy *blk_sz_c; 
              x_t = x + xx *blk_sz_c; 
              if y_t > 0 && x_t > 0 && (y_t ~= y || x_t ~= x) && mask(y_t,x_t) == 0
                 n_mask = n_mask + 1;
              end
          end
      end 

      if n_mask == 0
         continue 
      end

      if mask(y,x) == 0 || y > size(mask,1) - 20  ||  y < yt || y > yb || x < xl || x > xr
           cimg2(ceil(y/(blk_sz_c)), ceil(x/(blk_sz_c))) = 255;
           mask_t(y,x) = 0;
           continue;
      end

      for i = y:y+1
        for j = x-9:x+9
          if i > 0 && j > 0 && i < size(mask,1) && j < size(mask,2) && mask(i,j) > 0
          else
             cimg2(ceil(y/(blk_sz_c)), ceil(x/(blk_sz_c))) = 255;
             mask_t(y,x)=0;
             break
          end
        end
      end
    end
end

mask=mask_t;

cimg1(find(cimg1 > 0.9))=255;
cimg(find(cimg > 0.9))=255;
cimg2(find(cimg2 > 0.875))=255;


for y=1:size(mask,1)-blk_sz_c*2
    for x=blk_sz_c:size(mask,2)-blk_sz_c*2
      for i = y-25:y+25
        for j = x-25:x+25
          if i > 0 && j > 0 && i < size(mask,1) && j < size(mask,2) && mask(i,j) > 0
          else
             cimg2(ceil(y/(blk_sz_c)), ceil(x/(blk_sz_c))) = 255;
             break
          end
        end
      end
    end
end


for y=1:size(mask,1)-(blk_sz_c)*2
    for x=1:size(mask,2)-(blk_sz_c)
       if cimg(ceil(y/(blk_sz_c/2)), ceil(x/(blk_sz_c/2))) == 255
          cimg1(ceil(y/(blk_sz_c/4)), ceil(x/(blk_sz_c/4))) = 255;
          cimg1(ceil(y/(blk_sz_c/4))+1, ceil(x/(blk_sz_c/4))) = 255;
          cimg1(ceil(y/(blk_sz_c/4)), ceil(x/(blk_sz_c/4))+1) = 255;
          cimg1(ceil(y/(blk_sz_c/4))+1, ceil(x/(blk_sz_c/4))+1) = 255;
       end
    end
end

for y=1:size(mask,1)-(blk_sz_c)
    for x=1:size(mask,2)-(blk_sz_c)
       if cimg2(ceil(y/(blk_sz_c)), ceil(x/(blk_sz_c))) == 255
          cimg(ceil(y/(blk_sz_c/2)), ceil(x/(blk_sz_c/2))) = 255;
          cimg(ceil(y/(blk_sz_c/2))+1, ceil(x/(blk_sz_c/2))) = 255;
          cimg(ceil(y/(blk_sz_c/2)), ceil(x/(blk_sz_c/2))+1) = 255;
          cimg(ceil(y/(blk_sz_c/2))+1, ceil(x/(blk_sz_c/2))+1) = 255;
       end
    end
end



cimg1(find(cimg1 < 0.51))=255;
cimg(find(cimg < 0.51))=255;
cimg2(find(cimg2 < 0.51))=255;


inv_binim = (binim == 0);
thinned =  bwmorph(inv_binim, 'thin',Inf);

mask_t=mask;
if numel(find(mask(125:150,150:250)>0)) > 0 && numel(find(mask(250:275,150:250)>0)) > 0
  mask(150:250,150:250)=1;
end


method=-1;
core_path = 255;
core_y = 0;
core_x = 0;
core_val=0;
lc=0;
o_img=sin(orient_img);
o_img(find(mask == 0)) = 1;

lower_t=0.1;


[v,y]=min(cimg);
[dt1,x]=min(v);
delta1_y=y(x)*blk_sz_c/2
delta1_x=x*blk_sz_c/2

v(x)=255;
v(x+1)=255;
[dt2,x]=min(v);
delta2_y=y(x)*blk_sz_c/2
delta2_x=x*blk_sz_c/2

v(x)=255;
v(x+1)=255;
[dt3,x]=min(v);
delta3_y=y(x)*blk_sz_c/2
delta3_x=x*blk_sz_c/2



db=60;
if dt1 < 1 && delta1_y+db < core_y && delta1_y > 15 || dt2 < 1 && delta2_y+db < core_y && delta2_y > 15 || dt3 < 1 && delta3_y+db < core_y && delta3_y > 15 
    core_val=255
end

for y=10:size(o_img,1)-10
    for x=10:size(o_img,2)-10

        s1=0;
        t=10;


        %few of bad cores here 
        if y < 50 && x > 250
           t=11; 
        end

        if y > 38
           yt=20;
        else
           yt=5;
        end

        if lc > 0.41 && (core_y + 60 < y)
           break;
        end

        if mask(y,x)==0 || mask(max(y-t,1),x)==0 || mask(y,min(x+t, size(o_img,2)))==0 || mask(y,max(x-t,1))==0 || mask(max(y-t,1),min(x+t,size(o_img,2)))==0 || mask(max(y-t,1),max(x-t,1))==0 || o_img(y,x) < lc || o_img(y,x) < 0.1 
           continue
        end  

        if dt1 < 1 && delta1_y+db < y && delta1_y > 15 || dt2 < 1 && delta2_y+db < y &&    delta2_y > 15 || dt3 < 1 && delta3_y+db < y && delta3_y > 15 
           continue
        end
        test_m=min(o_img(1:y-yt,max((x-10),1):min(x+10,size(o_img,2)) ));
        if numel(test_m)>0 && min(test_m) >= 0.17
           continue
        end 

        for a=y:y+2 
            for b=x:x+1
                s1=s1+o_img(a,b);    
            end
        end
        s1=s1/6;

        s2=[];
        i=1;
        for a=y-3:y-1
            for b=x:x+1
                s2(i)=o_img(a,b);    
                i=i+1;
            end
        end
        if min(s2) < lower_t
           s2=sum(s2)/6;       
        else 
           s2=s1;
        end

        s3=[];
        i=1;
        for a=y:y+2 
            for b=x+2:x+3
                s3(i)=o_img(a,b);    
                i=i+1;
            end
        end
        if min(s3) < lower_t
           s3=sum(s3)/6;       
        else 
           s3=s1;
        end


        s4=[];
        i=1;
        for a=y:y+2 
            for b=x-2:x-1
                s4(i)=o_img(a,b);    
                i=i+1;
            end
        end
        if min(s4) < lower_t
           s4=sum(s4)/6;       
        else 
           s4=s1;
        end


        s5=[];
        i=1;
        for a=y-3:y-1 
            for b=x-2:x-1
                s5(i)=o_img(a,b);    
                i=i+1;
            end
        end
        if min(s5) < lower_t
           s5=sum(s5)/6;       
        else 
          s5=s1;
        end

        s6=[];
        i=1;
        for a=y-3:y-1 
            for b=x+2:x+3
                s6(i)=o_img(a,b);    
                i=i+1;
            end
        end
        if min(s6) < lower_t
          s6=sum(s6)/6;       
        else 
          s6=s1;
        end

        if s1-s2 > core_val
           core_val=s1-s2;
           core_x=x;
           core_y=y;
           lc=o_img(y,x);
           method=1;
        end 

        if s1-s3 > core_val
           core_val=s1-s3;
           core_x=x;
           core_y=y;
           lc=o_img(y,x);
           method=2;
        end 

        if x < 300 && s1-s4 > core_val
           core_val=s1-s4;
           core_x=x;
           core_y=y;
           lc=o_img(y,x);
           method=3;
        end 

        if x < 300 && s1-s5 > core_val
           core_val=s1-s5;
           core_x=x;
           core_y=y;
           lc=o_img(y,x);
           method=4;
        end 

        if s1-s6 > core_val
           core_val=s1-s6;
           core_x=x;
           core_y=y;
           lc=o_img(y,x);
           method=5;
        end 
    end
end


yt=0;

if core_y > 37
   yt=20;
else
   yt=5;
end
lc
core_y
core_x
method
test_smooth = 100;

if core_y > 0
   test_smooth= sum(sum(o_img(core_y-yt-5:core_y-yt+5,core_x-5:core_x+5)))
end

if lc > 0.41 && (test_smooth < 109.5 && method~=2 || test_smooth < 100) %&& min(min(o_img(1:core_y-yt,core_x-10:core_x+10))) < 0.17 
   start_t=0;
   core_val=1/(core_val+1);
   core_x
   core_y
   min(min(o_img(1:core_y-yt,core_x-10:core_x+10)))
else
   core_x=0;
   core_y=0;
   core_val = 255;
end

mask=mask_t;
display_flag = 1;

ocodes = [];
orientations = [];
radii = [];

sample_intv = 5;
path_len = 45;
min_o_change(1, :) = zeros(1, floor(path_len / sample_intv)); 

% minutiae counter
minu_count = 1;
minutiae(minu_count, :) = [0,0,0,0,0,1];
min_path_index = [];

% loop through image and find minutiae, ignore certain pixels for border
for y=20:size(img,1)-14
    for x=21:size(img,2)-21
        if (thinned(y, x) == 1) % only continue if pixel is white
            % calculate CN from Raymond Thai
            CN = 0; sx=0; sy=0;
            for i = 1:8
              [t1, x1, y1] = p(thinned, x, y, i);
              [t2, x2, y2] = p(thinned, x, y, i+1);
              CN = CN + abs (t1-t2);
            end   
            CN = CN / 2;

            if ((CN == 1) || (CN == 3)) && mask(y,x) > 0
               skip=0;
               for i = y-5:y+5
                    for j = x-5:x+5
                      if i>0 && j>0 && mask(i,j) == 0   
                         skip=1;
                      end
                    end
               end
                
               if skip == 1
                  continue;
               end
  
               t_a=[];
               c = 0;
               for e=y-1:y+1
                   for f=x-1:x+1
                       c = c + 1;
                       t_a(c) = orient_img_m(e,f);
                   end
               end 

               m_o = median(t_a); %orient_img_m(y,x); %oimg(ceil(y/blk_sz_o),ceil(x/blk_sz_o));
               m_f = 0; %fimg(ceil(y/blk_sz_o),ceil(x/blk_sz_o));
               angle=m_o;
               if CN == 3
                  [CN, prog, sx, sy,ang]=test_bifurcation(thinned, x,y, m_o, core_x, core_y);
                  if prog < 7
                     continue
                  end

%                  m_o
%                  ang
%min(abs(m_o - ang),2*pi - abs(m_o - ang))
%abs(pi-abs(m_o - ang))
%pause
                  if ang > pi && min(abs(m_o - ang),2*pi - abs(m_o - ang)) > abs(pi-abs(m_o - ang))
                     m_o = m_o + pi
                  end

               else
                  progress=0;
                  xx=x; yy=y; pao=-1; pos=0;
                  while progress < 15 && xx > 1 && yy > 1 && yy<size(img,1) && xx<size(img,2) && pos > -1
                        pos=-1;
                        for g = 1:8
                            [ta, xa, ya] = p(thinned, xx, yy, g);
                            [tb, xb, yb] = p(thinned, xx, yy, g+1);

                            if (ta > tb)  && pos==-1 && g ~= pao
                               pos=ta; 
                               if g < 5
                                  pao = 4 + g;
                               else
                                  pao = mod(4 + g, 9) + 1;
                               end
                               xx=xa;
                               yy=ya;
                            end 
                        end
                        progress=progress+1;
                  end

                  if progress < 13
                     continue
                  end

                  if mod(atan2(y-yy,xx-x), 2*pi) > pi
                     m_o=m_o+pi;
                  end
               end               
               minutiae(minu_count, :) = [ x, y, CN, m_o, m_f, 1];
               min_path_index(minu_count, :) = [sx sy];
               minu_count = minu_count + 1;
            end
        end % if pixel white
    end % for y
end % for x

% Identify the ellipse enclosed by the largest rectangle spanned by the 
% set of initially detected minutiaes (4/8/2006 - Paul Kwan)
min_x = min(minutiae(:,1)); max_x = max(minutiae(:,1));
min_y = min(minutiae(:,2))/1.1; max_y = max(minutiae(:,2))*1.1;
mid_x = (min_x + max_x) / 2; mid_y = (min_y + max_y) / 2;

if (max_x - min_x) > (max_y - min_y) % major axis is on the x-axis
    major_axis_len = max_x - min_x;  % Refer to figure
    M_Y1 = (max_y - min_y) / 2;
    F1_Y1 = major_axis_len / 2;
    M_F1 = sqrt(F1_Y1^2 - M_Y1^2);   % Use Pythagoras' theorem
    F1_x = mid_x - M_F1; F1_y = mid_y;
    F2_x = mid_x + M_F1; F2_y = mid_y;
else
    major_axis_len = max_y - min_y;  % Refer to figure
    M_X1 = (max_x - min_x) / 2;
    F1_X1 = major_axis_len / 2;
    M_F1 = sqrt(F1_X1^2 - M_X1^2);   % Use Pythagoras' theorem
    F1_x = mid_x; F1_y = mid_y + M_F1;
    F2_x = mid_x; F2_y = mid_y - M_F1;
end

clean_list = [];
c_index = 1;
thinned_old = thinned;
minu_count = minu_count -1;

% Filter potential false endings by excluding those outside of the 
% elliptical region

t_minutiae = [];
t_minu_count = 1;
t_mpi = [];
pre_minu_count1 = minu_count


for i=1:minu_count
    X = minutiae(i,1); Y = minutiae(i,2);
    rc=0; 
    for y=max(Y-2,1):min(Y+2, size(binim,1)) 
        if rc > 0
           break
        end
        for x=max(X-2,1):min(X+2, size(binim,2))  
            if mask(y,x) == 0
               rc = rc + 1;   
               break
            end
        end
    end

    if rc > 0 
         continue;
    else
        t_minutiae(t_minu_count, :) = minutiae(i, :);
        t_mpi(t_minu_count, :) = min_path_index(i, :);
        t_minu_count = t_minu_count + 1;
    end

end

%if minu_count > 5
%  for i=1:minu_count 
%    P_x = minutiae(i,1); P_y = minutiae(i,2);
%    P_F1_dist = sqrt((P_x - F1_x)^2 + (P_y - F1_y)^2);
%    P_F2_dist = sqrt((P_x - F2_x)^2 + (P_y - F2_y)^2);
%    if (P_F1_dist + P_F2_dist) < major_axis_len
%      if find(clean_list(:) == i) > 0
%         continue;
%      else
%        t_minutiae(t_minu_count, :) = minutiae(i, :);
%        t_mpi(t_minu_count, :) = min_path_index(i, :);
%        t_minu_count = t_minu_count + 1;
%      end
%    end
%  end

  minutiae = t_minutiae;
  min_path_index = t_mpi;
%  index = clean_minutia(minutiae(:,1:2), minutiae(:,3), thinned, 15);
%  min_path_index = min_path_index(index, :);
%  minutiae = minutiae(index, :);    
%end

minu_count = size(minutiae,1);

t_minu_count = 1;
t_minutiae = [];

pre_minu_count2 = minu_count

dist_m = dist2(minutiae(:,1:2), minutiae(:,1:2));
%dist_m(find(dist_m == 0)) == 1000;

dist_test=49;
if minu_count > 50
   dist_test=81;
end

for i=1:minu_count
  reject_flag = 0;
  t_a = minutiae(i,4);
  P_x = minutiae(i,1); P_y = minutiae(i,2);

  for j = i + 1 : minu_count
    if dist_m(i,j) <= dist_test
%       dist_m(j,i)=100;
       reject_flag = 1;
    end
  end

  if reject_flag == 0 && mask(P_y, P_x) > 0
     reverse_p = 0;  
     if min_path_index(i,1) == 0
       x = P_x;
       y = P_y; 
     else
       x =  min_path_index(i,1);
       y =  min_path_index(i,2); 
     end

     iter = 0;
     p1x=P_x; p1y=P_y; p2x=P_x; p2y=P_y;
     minutiae_o_change = [];

     x1=x;y1=y;
     xs=x; ys=y;
     p_uv = [ (x/sqrt(x^2 + y^2)) (y/sqrt(x^2 + y^2)) ];
     iter = 0;

     for m=1:path_len
           iter = iter + 1;
           cn = 0;

           for ii = 1:8
               [t1, x_A, y_A] = p(thinned, x1, y1, ii);
               [t2, x_B, y_B] = p(thinned, x1, y1, ii+1);
               cn = cn + abs (t1-t2);
           end
           cn = cn / 2;

           if cn ~= 3 && cn ~= 4 || m == 1%&& mask(x1,y1) > 0
              for n=1:8
                  if reverse_p == 0 || iter > 1 
                     [ta, xa, ya] = p(thinned, x1, y1, n);
                  else
                     [ta, xa, ya] = p(thinned, x1, y1, 9-n);    
                  end
                  if ta == 1 && (xa ~= p1x || ya ~= p1y) && (xa ~= x || ya ~= y)
                     p1x = x1;
                     p1y = y1;
                     x1 = xa;
                     y1 = ya;
                     break;
                  end
              end
           end

           if mod(iter, sample_intv) == 0
              if xs == x1 && ys == y1
                 minutiae_o_change(iter/sample_intv)=-1;
              else
                 norm_s = sqrt((x1-xs)^2 + (y1-ys)^2);
                 xv = (x1-xs)/norm_s;
                 yv = (y1-ys)/norm_s;
                 ptx = x - xs;
                 pty = y - ys;
                 norm_p = sqrt((ptx)^2 + (pty)^2);
                 ptx = ptx/norm_p;
                 pty = pty/norm_p;

                 %inner product
                 i_prod = (xv*ptx + yv*pty); 
                 minutiae_o_change(iter/sample_intv)=real(acos(i_prod)); 
                 xs = x1;
                 ys = y1;
              end
           end
     end

     minutiae_o_change(1)=1;

%     [temp_o1, temp_r1, mx1, my1] = tico(binim, P_x, P_y, oimg, orient_img_m, o_rel, [12 24 36 48 60 72 84] , [14 18 24 28 30 34 28]   , 1, minutiae(i,4), blk_sz_o);
     [temp_o1, temp_r1, mx1, my1] = tico(binim, P_x, P_y, oimg, orient_img_m, o_rel, [12 24 36 48 60 72 84] , [14 18 24 28 30 34 28]   , 0, -1, blk_sz_o);
     t_minutiae(t_minu_count, :) = minutiae(i, :);
     min_o_change(t_minu_count, :) = minutiae_o_change;
     orientations(t_minu_count,:) = [ temp_o1 ];
     radii(t_minu_count, :) = [temp_r1 ];
     t_minu_count = t_minu_count + 1;
  end
end

minutiae = t_minutiae;
minu_count = t_minu_count-1;


tmpvec1 = size(img,1).*ones(minu_count,1);    
tmpvec2 = ones(minu_count,1);                 
minutiae_for_sc = [minutiae(:,1)/size(img,2) (tmpvec1 - minutiae(:,2) + tmpvec2)/size(img,1)];  
dist_m = sqrt(dist2(minutiae_for_sc(:,1:2), minutiae_for_sc(:,1:2)));

neighbours=[0, 0, 0, 0, 0, 0, 0, 0, 0];
n_i = 1;

for i=1:minu_count
  t_a = minutiae(i,4);
  P_x = minutiae(i,1); P_y = minutiae(i,2);

  [d,ind] = sort(dist_m(i,:));
  for j = 1 : minu_count
    if  dist_m(i,ind(j)) == 0
       continue
    end

    diff_x = minutiae(i,1) - minutiae(ind(j), 1);
    diff_y = minutiae(i,2) - minutiae(ind(j), 2);
    angle = mod(atan2(diff_y, diff_x) + 2*pi, 2*pi);
    theta = mod(minutiae(i,4) - angle + 2*pi, 2*pi);

    theta_t = mod(atan2(minutiae(i,2) - minutiae(ind(j),2), minutiae(i,1) - minutiae(ind(j),1)), 2*pi);

    ridge_count = 0;
    p_y = minutiae(i,2); 
    p_x = minutiae(i,1); 
    t_x = 0;
    t_y = 0;
    current=1;
    radius = 1;
   
    while p_y ~= minutiae(ind(j),2)
        if thinned(p_y, p_x) > 0  && current == 0 && (t_x ~= p_x || t_y ~= p_y)
           current = 1;
           ridge_count = ridge_count + 1;
        else
             if thinned(p_y, p_x) == 0
                current = 0;
             end
        end    
        t_x = p_x;
        t_y = p_y;
        p_x = round(minutiae(i,1) - radius*cos(theta_t)); 
        p_y = round(minutiae(i,2) - radius*sin(theta_t));
        radius = radius + 1;
    end
    co = calc_orient(orientations(i,:), radii(i,:), orientations(ind(j),:), radii(ind(j),:), []);

    neighbours(n_i, :) = [i, ind(j),  dist_m(i,ind(j)), ridge_count, theta_t, minutiae(ind(j),3), minutiae(ind(j), 5), co, abs(mod(minutiae(i, 4),pi) - mod(minutiae(ind(j), 4),pi)) ];
    n_i = n_i + 1;
  end
end

pre_singular_min = minutiae;

if core_val < 1
  minutiae(minu_count+1, :) = [core_x, core_y, 5, start_t, 0,1]; 
  minu_count = minu_count + 1
end

if dt1 < 1
   minutiae(minu_count+1, :) = [delta1_x, delta1_y, 7, 0, 1,1];
   minu_count = minu_count + 1;
end

if dt2 < 1       
   minutiae(minu_count+1, :) = [delta2_x, delta2_y, 7, 0, 1,1];
   minu_count = minu_count + 1;
end

if dt3 < 1       
   minutiae(minu_count+1, :) = [delta3_x, delta3_y, 7, 0, 1,1];
   minu_count = minu_count + 1;
end

tmpvec1 = size(img,1).*ones(minu_count,1);   %JI: m array of 1's multiplied by image vertical size 
tmpvec2 = ones(minu_count,1);                %JI: m array of 1's 

minutiae_for_sc = [minutiae(:,1)/size(img,2) (tmpvec1 - minutiae(:,2) + tmpvec2)/size(img,1)];  %convert to x-y cartesian co-ordinates in [0,1]

img_sc = trace_path(thinned, pre_singular_min, 20);

% make minutiae image
if display_flag == 1
  minutiae_img = uint8(zeros(size(img, 1),size(img, 2), 3));
  for i=1:minu_count 
    x1 = minutiae(i, 1);
    y1 = minutiae(i, 2);
    if minutiae(i, 3) == 1 
       if minutiae(i, 4) > pi
        for k = y1-2: y1 + 2
          for l = x1-2: x1 + 2
            minutiae_img(k, l,:) = [255, 0, 0]; 
          end
        end
       else
        for k = y1-2: y1 + 2
          for l = x1-2: x1 + 2
            minutiae_img(k, l,:) = [205, 100, 100]; 
          end
        end
       end
    elseif minutiae(i, 3) == 2
        for k = y1-2: y1 + 2
          for l = x1-2: x1 + 2
            minutiae_img(k, l,:) = [255, 0, 255];
          end
        end
    elseif minutiae(i, 3) == 3
      if minutiae(i, 4) > pi
        for k = y1-2: y1 + 2
          for l = x1-2: x1 + 2
            minutiae_img(k, l,:) = [0, 0, 255]; 
          end
        end
      else 
        for k = y1-2: y1 + 2
          for l = x1-2: x1 + 2
            minutiae_img(k, l,:) = [255, 0, 255];
          end
        end
      end
    elseif minutiae(i, 3) == 5
        for k = y1-4: y1 + 4
          for l = x1-4: x1 + 4
            minutiae_img(k, l,:) = [0, 255, 0]; 
          end
        end

    elseif minutiae(i, 3) > 5
        for k = y1-2: y1 + 2
          for l = x1-2: x1 + 2
              minutiae_img(k, l,:) = [128, 128, 0]; % gold for delta
          end
        end
    end   
  end


  % merge thinned image and minutia_img together
  combined = uint8(minutiae_img);
  for x=1:size(binim,2)
    for y=1:size(binim,1)
        if mask(y,x) == 0
            combined(y,x,:) = [0,0,0];
            continue
        end
        if (binim(y,x))
            combined(y,x,:) = [255,255,255];
        else
            combined(y,x,:) = [0,0,0];
        end % end if
        if ((minutiae_img(y,x,3) ~= 0) || (minutiae_img(y,x,1) ~= 0) ) || (minutiae_img(y,x,2) ~= 0)
            combined(y,x,:) = minutiae_img(y,x,:);
        end
    end % end for y
  end % end for x

  if core_val < 1 && YA > 0
        for k = YA-2: YA + 2
          for l = XA-2: XA + 2
             combined(k,l,:) = [20, 255, 250];
          end
        end

        for k = YB-2: YB + 2
          for l = XB-2: XB + 2
             combined(k,l,:) = [20, 255, 250];
          end
        end

  end

  figure(1)

  %subplot(2,2,1), subimage(img), title(filename)
  %subplot(2,3,2), subimage(cimg), title('orientation image 0')
  %subplot(2,3,3), subimage(cimg1), title('orientation image 1')
  %subplot(2,2,1), subimage(minutiae_img), title('minutiae points')
  subplot(1,1,1), subimage(combined), title(filename)
%  subplot(2,3,3), subimage(thinned), title('thinned image')
 % subplot(2,2,3), subimage(o_img), title('orientation image (sine)')
%  subplot(2,3,5), subimage(eimg), title('f image ')
 % subplot(2,2,4), subimage(img_sc), title('orientation image ')
  drawnow
  %plotridgeorient(orient_img, 20, img, 2)
end

size(minutiae)
size(minutiae_for_sc)

ret=struct('X', minutiae_for_sc, 'M', minutiae, 'O', orientations, 'R', radii, 'N', neighbours, 'RO', min_o_change); %, 'SIKP', sikp_sc); 
end
