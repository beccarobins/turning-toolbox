function NormalizedData = timenorm(Data,Min,Max)

list = who('v_*');
for iVar = 1:length(list)
  S.(list{iVar}) = eval(list{iVar});
end
    
%     normalises the data according to the first onset latency of the axial segments until the last...
%         end time of the axial segments
%     creates difference plots between the segments to determine how far 'ahead' or 'behind' the segments...
%         are from each other
    
    Indata = Data(Min:Max);
    
    n1 = 1;
    n2 = 285000;
    nstart = 1;
    nend = length(Indata);
    
    fratio = (nend-nstart)/(n2-n1);
    
    for N = n1:n2-1;
        frame = 1+(N-1)*fratio;
        s = floor(frame);
        residual = frame-s;
        NormalizedData(N,1) = (1-residual)*Indata(s,1)+residual*Indata(s+1,1); %#ok<*AGROW,*SAGROW>
    end
    
    NormalizedData(n2,1) = Indata(nend-nstart+1,1);