clc,clear,close all

format long g

for d = 0.420:-0.000001:0.410     %  0.430337  % 0.4171375975 
    res = fun3(d);
    if res == 1
        break
    end
end


