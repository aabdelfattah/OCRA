function data = load_training_data(dir,NUM_LETTERS,TRAINING_SAMPLES)
    
    data = cell(NUM_LETTERS,TRAINING_SAMPLES);
    cd(dir);
    for i = 1 : NUM_LETTERS
        cd(num2str(i)) %open dir 
        files = dir('*.txt'); % load all files in a dir
        
        for j=1:TRAINING_SAMPLES % for each file in the dir
            eval(['pic = load (''' files(j).name ''');']);
            [l w] = size(pic);
            xprev = pic(1,1);
            yprev = pic(1,2);
            o = ones(1,l-1);
            for k = 2 : l % load features and quantize it
                x = pic(k,1);
                y = pic(k,2);
                o(k-1) = quantize(atan2d(y-yprev,x-xprev));
                xprev = x;
                yprev = y;

            end
            data{i,j} = o; % for each letter i load all samples j , j +1 .. 
        end
        cd ..
    end
end

function o=quantize(theta)
    
    if (theta < 0)
        theta = theta + 360;
    end
    
    if (theta >=0 &&theta <22.5)
        o = 1;
    elseif (theta >=22.5 &&theta <45)
        o = 2; 
    elseif (theta >=45 &&theta <67.5)
        o = 3;
    elseif (theta >=67.5 &&theta <90)
        o = 4;
    elseif (theta >=90 &&theta <112.5)
        o = 5;
    elseif (theta >=112.5 &&theta <135)
        o = 6 ;
    elseif (theta >=135 &&theta <157.5)
        o = 7;
    elseif (theta >=157.5 &&theta <180)
        o = 8;
    elseif (theta >=180 &&theta <202.5)
        o = 9;
    elseif (theta >=202.5 &&theta <225)
        o = 10;
    elseif (theta >=225 &&theta <247.5)
        o = 11;
    elseif (theta >=247.5 &&theta <270)
        o = 12;
    elseif (theta >=270 &&theta <292.5)
        o = 13;
    elseif (theta >=292.5 &&theta <315)
        o = 14;
    elseif (theta >=315 &&theta <337.5)
        o = 15;
    else
        o = 16;
    end

end