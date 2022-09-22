function VxMTool_resetFlag(file)
    fid_flag=fopen(file,'w');
    fwrite(fid_flag,'0','char');
    fclose(fid_flag); 
end

