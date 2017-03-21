 
clc;
clear;

M = rand(16,16)*100;

M_2 = zeros(15,15);
for i = 1: 15;
    for j = 1: 15;
        temp = 0;
        for k = 0:1;
            for l = 0:1;
                temp = temp/2 + M(i+k, j+l)/3;
            end
            
        end        
        M_2(i,j) = temp;
    end
end

M_3 = zeros(13,13);
for i = 1: 13;
    for j = 1: 13;
        temp = 0;
        for k = 0:3;
            for l = 0:3;
                temp = temp/2 + M(i+k, j+l)/3;
            end
            
        end        
        M_3(i,j) = temp;
    end
end

M_4 = zeros(9, 9);
for i = 1: 9;
    for j = 1: 9;
        temp = 0;
        for k = 0:7;
            for l = 0:7;
                temp = temp/2 + M(i+k, j+l)/3;
            end
            
        end        
        M_4(i,j) = temp;
    end
end

M_5 = zeros(1, 1);
for i = 1: 1;
    for j = 1: 1;
        temp = 0;
        for k = 0:15;
            for l = 0:15;
                temp = temp/2 + M(i+k, j+l)/3;
            end
            
        end        
        M_5(i,j) = temp;
    end
end

