function readData = VxMTool_readFromVrep(file)
    fid = fopen(file,'r');
    temp=textscan(fid,'%s');
    readData=str2double(temp{1});
    fclose(fid);
end

