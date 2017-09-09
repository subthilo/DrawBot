clc
clear all



numAttr    = 10;

for i=1:numAttr
    attractors(i,1) = attractor;
    
    attractors(i).initAttractor;  
end


figure(1); clf; hold on
for i = 1:5000
   
    i
    for j = 1:numAttr
        
        attractors(j).move;

       
        
    end
    
    pause(.00001)
    
end