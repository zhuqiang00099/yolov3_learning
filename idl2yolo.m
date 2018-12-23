file_path = 'brainwash_train.idl';
out_path = 'yolo_train_file/';
width = 640;
height = 480;
%% 按行分割
file = fopen(file_path);
tline = fgetl(file);
jpgfp = fopen('t_brainwash_train.txt','a');
while ischar(tline)
 fullname= regexp(tline,'[^"]+\.[{png}{jpg}]+','match');
 fullname = fullname{1};
 [path,name,ext] = fileparts(fullname); 
%  ext = regexp(name,'\..+',match);
 filename = [name,'.txt'];
 fp = fopen([[path,'/'],filename],'a');
 
 fprintf(jpgfp,'brainwash/%s\n',fullname);
 numbers = regexp(tline,'\d+\.\d+', 'match');
 for i = 1:4:length(numbers)
     bbox.x = str2double(numbers(i))/ width;
     bbox.y =str2double(numbers(i+1)) / height;
     bbox.x2 =str2double(numbers(i+2)) / width;
     bbox.y2 = str2double(numbers(i+3))/ height;
     bbox.w = bbox.x2-bbox.x;
     bbox.h  = bbox.y2-bbox.y;
     
     if (bbox.x >1 || bbox.y > 1 || bbox.x2 > 1 || bbox.y2 >1 || bbox.w<0 || bbox.h<0)
%          fclose(fp);
%          fclose(file);
%          fclose(jpgfp);
        sprintf('bbox数值异常%s',name)        
     end
     bbox.x = (bbox.x + bbox.x2)/2;
     bbox.y = (bbox.y + bbox.y2)/2;
     fprintf(fp,'0 %f %f %f %f\n',bbox.x,bbox.y,bbox.w,bbox.h);
 end
 fclose(fp);
 tline = fgetl(file);
end
fclose(file);
fclose(jpgfp);