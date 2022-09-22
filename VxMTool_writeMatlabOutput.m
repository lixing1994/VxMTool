function VxMTool_writeMatlabOutput(file,var)
    fid = fopen(file,'w');
    for i=1:length(var)
        fprintf(fid,strcat(num2str(var(i)),'\r\n'));
    end
    fclose(fid);
end

