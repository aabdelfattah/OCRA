clear all
NUM_RUNS = 10
error = 0;
time = 0;
for i = 1: NUM_RUNS
    fprintf('RUN # %d : \n',i);
    [t,e]= OCRA2(1);
    error = error + e;
    time = time + t;
end
error = error/NUM_RUNS;
time = time/NUM_RUNS;
fprintf('Average error = %.3f, Average time %.3f \n',error*100,time);