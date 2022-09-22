function VxMTool_initFilesByMatlab(file1,file2,var)
% 1.create flag file or cover old flag file in "C:/VxMToolCache/"
% 2.create vrep_output.txt file and write init data for matlab
cache_path = 'C:/VxMToolCache/';
if ~isfolder(cache_path)
    mkdir(cache_path);
end

fid = fopen(file1,'w+');
fprintf(fid,strcat(num2str(1),'\r\n'));
fclose(fid);

fid = fopen(file2,'w+');
for i=1:length(var)
    fprintf(fid,strcat(num2str(var(i)),'\r\n'));
end
fclose(fid);

end