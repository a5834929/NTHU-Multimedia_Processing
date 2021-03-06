function grep(filename1, filename2)
%filename1 represents the test input
%filename2 represents our test output 
pattern = '[A-Z][:][a-z]{3}|[N]'; 

fid1 = fopen(filename1, 'r');
fid2 = fopen(filename2, 'r');
fid3 = fopen('Result.txt', 'a'); 

line_number = 0;   %total number 
currect_number = 0; %toal currect number

while feof(fid1) == 0
	line1 = fgetl(fid1);
    line2 = fgetl(fid2);
    [startAns, finishAns] = regexp(line1, pattern);
    [startOut, finishOut] = regexp(line2, pattern);
    Ans=line1(startAns:finishAns);
    Out=line2(startOut:finishOut);

    if(strcmp(Ans, Out))
        currect_number = currect_number+1;
        %fprintf('ya~\n');
    else
        %fprintf('QQ\n');
    end
    
	line_number = line_number + 1;
end
currect_rate = (currect_number/line_number)*100;
fprintf(fid3,'The %s currect rate:%f %%\n', filename1, currect_rate);

fclose(fid1);  
fclose(fid2); 
%fclose(fid3); 