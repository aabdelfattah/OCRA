function [t, error]= OCRA2(sw)
    
    TRAINING_SAMPLES = 20 ;  % number of pictures used for training per symbol(letter)
	EVAL_SAMPLES = 2;  % number of pictures used for evaluation per symbol(letter)
	NUM_LETTERS = 28; % number of symbols (letters)
    NUM_STATES = 5;	  % number of states in a HMM symbol model
    
    if (sw == 1)
        QUANTIZATION_LEVELS = 160 * 2;
    else
        QUANTIZATION_LEVELS = 16;
    end
    
    %---------------------------------data prep-------------------------------%
    
    if (sw == 1)
        setdir='SW\';
        [eval_data, data] = load_training_data_sw(setdir,NUM_LETTERS,TRAINING_SAMPLES,EVAL_SAMPLES);
    else
        setdir='set 3 saad\';
        [eval_data, data] = load_training_data(setdir,NUM_LETTERS,TRAINING_SAMPLES,EVAL_SAMPLES);
    end

    %------------------------------Init models----------------------------%
    hmm = cell(NUM_LETTERS,1);
    %------------------------------3-state mode---------------------------%
    
%     for i = 1 : NUM_LETTERS
%         hmm0.priorg = [1 0 0];
%         hmm0.transmatg = rand(3,3); % 3 by 3 transition matrix
%         hmm0.transmatg(2,1) =0; hmm0.transmatg(3,1) = 0; hmm0.transmatg(3,2) = 0;
%         hmm0.transmatg = mk_stochastic(hmm0.transmatg);
%         hmm0.obsmatg = rand(3, 16); % # of states * # of observation
%         hmm0.obsmatg = mk_stochastic(hmm0.obsmatg);
%         hmm{i} = hmm0;
%     end
    
    % %------------------------------5-state mode---------------------------%
%     for i = 1 : NUM_LETTERS
%         hmm0.priorg = [1 0 0 0 0];
%         hmm0.transmatg = rand(5,5); % 5 by 5 transition matrix
%         hmm0.transmatg(2,1) =0;
%         hmm0.transmatg(3,1) = 0;hmm0.transmatg(3,2) = 0;
%         hmm0.transmatg(4,1) = 0;hmm0.transmatg(4,2) = 0;hmm0.transmatg(4,3) = 0;
%         hmm0.transmatg(5,1) = 0;hmm0.transmatg(5,2) = 0;hmm0.transmatg(5,3) = 0;hmm0.transmatg(5,4) = 0;
%         hmm0.transmatg = mk_stochastic(hmm0.transmatg);
%         hmm0.obsmatg = rand(5, 16); % # of states * # of observation
%         hmm0.obsmatg = mk_stochastic(hmm0.obsmatg);
%         hmm{i} = hmm0;
%     end
    % %------------------------------10-state mode---------------------------%
%     for i = 1 : NUM_LETTERS
%         hmm0.priorg = [1 0 0 0 0 0 0 0 0 0];
%         hmm0.transmatg = rand(10,10); % 5 by 5 transition matrix
%         hmm0.transmatg(2,1) =0;
%         hmm0.transmatg(3,1) = 0;hmm0.transmatg(3,2) = 0;
%         hmm0.transmatg(4,1) = 0;hmm0.transmatg(4,2) = 0;hmm0.transmatg(4,3) = 0;
%         hmm0.transmatg(5,1) = 0;hmm0.transmatg(5,2) = 0;hmm0.transmatg(5,3) = 0;hmm0.transmatg(5,4) = 0;
%         hmm0.transmatg(6,1) = 0;hmm0.transmatg(6,2) = 0;hmm0.transmatg(6,3) = 0;hmm0.transmatg(6,4) = 0;hmm0.transmatg(6,5) = 0;
%         hmm0.transmatg(7,1) = 0;hmm0.transmatg(7,2) = 0;hmm0.transmatg(7,3) = 0;hmm0.transmatg(7,4) = 0;hmm0.transmatg(7,5) = 0;
%         hmm0.transmatg(7,6) = 0;
%         hmm0.transmatg(8,1) = 0;hmm0.transmatg(8,2) = 0;hmm0.transmatg(8,3) = 0;hmm0.transmatg(8,4) = 0;hmm0.transmatg(8,5) = 0;
%         hmm0.transmatg(8,6) = 0;hmm0.transmatg(8,7) = 0;
%         hmm0.transmatg(9,1) = 0;hmm0.transmatg(9,2) = 0;hmm0.transmatg(9,3) = 0;hmm0.transmatg(9,4) = 0;hmm0.transmatg(9,5) = 0;
%         hmm0.transmatg(9,6) = 0;hmm0.transmatg(9,7) = 0;hmm0.transmatg(9,8) = 0;
%         hmm0.transmatg(10,1) = 0;hmm0.transmatg(10,2) = 0;hmm0.transmatg(10,3) = 0;hmm0.transmatg(10,4) = 0;hmm0.transmatg(10,5) = 0;
%         hmm0.transmatg(10,6) = 0;hmm0.transmatg(10,7) = 0;hmm0.transmatg(10,8) = 0;hmm0.transmatg(10,9) = 0;
%         hmm0.transmatg = mk_stochastic(hmm0.transmatg);
%         hmm0.obsmatg = rand(10, 16); % # of states * # of observation
%         hmm0.obsmatg = mk_stochastic(hmm0.obsmatg);
%         hmm{i} = hmm0;
%     end
    %------------------------------n-states mode--------------------------%
    for i = 1 : NUM_LETTERS
        hmm0.priorg = zeros(1,NUM_STATES);
        hmm0.priorg(1)= 1;
        hmm0.transmatg = rand(NUM_STATES,NUM_STATES); % NUM_STATES by NUM_STATES  transition matrix
        for j = 1: NUM_STATES
            for k = 1 : j-1
                hmm0.transmatg(j,k) =0;
            end
        end
        hmm0.obsmatg = rand(NUM_STATES, QUANTIZATION_LEVELS); % # of states * # of observation
        hmm0.obsmatg = mk_stochastic(hmm0.obsmatg);
        hmm{i} = hmm0;
    end
    

    
    %-------------------------training----------------------------------------%

    for i = 1 : NUM_LETTERS
        datacell = cell(TRAINING_SAMPLES,1);
        for j = 1 : TRAINING_SAMPLES
            datacell{j} = data{i,j} ;
        end
        [hmm{i}.transmat, hmm{i}.obsmat] = hmmtrain(datacell, hmm{i}.transmatg, hmm{i}.obsmatg);
    end

    %------------------------eval---------------------------------------------%

    error = [0 0];
    t = [0 0];
    loglike = ones(NUM_LETTERS,NUM_LETTERS);
    timeval = zeros(1,NUM_LETTERS);
    for n = 1 : EVAL_SAMPLES
        sample_error = 0;
        for j =1: NUM_LETTERS 
            tic;
            for i = 1 : NUM_LETTERS
                 [states,loglike(j,i)] = hmmdecode(eval_data{j,n}, hmm{i}.transmat, hmm{i}.obsmat);     
            end
            max = argmax(loglike(j,:));
            timeval(1,j) = toc;
            fprintf('[letter %s: model %s] :likelihood %.3f , time taken %.3f \n',char(letters(j)),char(letters(max)), loglike(j,max),timeval(1,j));
            if (letters(j)~= letters(max))
                sample_error = sample_error +1 ;
            end        
        end
        error(n) = sample_error/NUM_LETTERS;    
        fprintf('error rate = %.3f %',error(n)*100);
        t(n) = mean(timeval);
    end
    
    error = mean(error);
    t = mean(t);

end