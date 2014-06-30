function [eval_data, data] = load_training_data_sw(setdir,NUM_LETTERS,TRAINING_SAMPLES,EVAL_SAMPLES)
    
    data = cell(NUM_LETTERS,TRAINING_SAMPLES);
    eval_data = cell(NUM_LETTERS,EVAL_SAMPLES);
    cd(setdir);
    for i = 1 : NUM_LETTERS
        cd(num2str(i)); %open dir 
        
        %evaluation data
        cd('eval');
        
        eval_files = dir('*.png');
        
        for j = 1 : EVAL_SAMPLES
            eval(['eval_data{i,j} = Sliding2(''' eval_files(j).name ''');']);   % for each letter i load all samples j , j +1 .. 
        end
        cd ..
        
        %training data
        files = dir('*.png'); % load all files in a dir 
        for j=1:TRAINING_SAMPLES % for each file in the dir
            eval(['data{i,j} = Sliding2(''' files(j).name ''');']); % for each letter i load all samples j , j +1 ..
            
        end
        cd ..
    end
    cd ..
end

