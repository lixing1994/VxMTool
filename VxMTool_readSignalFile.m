function RnW = VxMTool_readSignalFile(file_path)
  while 1 
      fid_flag=fopen(file_path,'r');
      if str2double(fread(fid_flag,1,'*char'))==1
          RnW=true;
          fclose(fid_flag);
          break
      end
      fclose(fid_flag);
  end
end

