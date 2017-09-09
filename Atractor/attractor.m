classdef attractor <handle
    properties
        position
        speed
        posHistory
        lines; % kann man irgendwie nicht in er init method als leer initialisiere
    end
    
    methods
        function initAttractor(obj)
            obj.position    = rand(1,2)*.5+.25;
            obj.speed       = (rand(1,2)-.5)*2;
            obj.speed       = obj. speed/norm(obj. speed)*.05;
            obj.posHistory  = obj.position;
            
        end
        
        function move(obj)
            
            obj.position    = obj.position + obj.speed;
            
            track(obj)
            
            trace(obj)
            
            
              
        end
        
        function track(obj)
            
            obj.posHistory  = [obj.posHistory; obj.position];
            gravity(obj, [.5 .5], .000005, 1)
            
            gravity(obj, [.3 .1], .00002, 1)
            
            gravity(obj, [.6 .3], .00001, 1)
            
            gravity(obj, [.8 .7], .00001, 1)
            
            gravity(obj, [.1 .4], .00006, 1)
            
            gravity(obj, [.45 .9], .00004, 1)
            
            gravity(obj, [.9 .3], .0001, 1)
            
            
            obj.lines = cat(3, obj.lines, cat(1,obj.posHistory(end-1,:), obj.posHistory(end,:))); 
            
            walls(obj)
            

        end
        
        function walls(obj)
            
            forwardShift = obj.position<=0;
            backShift = -(obj.position>=1);
            shift = forwardShift+backShift;

            if sum(abs(shift))
                obj.position = obj.position+shift;
                
                obj.posHistory  = [obj.posHistory; obj.posHistory(end-1,:)];
                obj.posHistory(end,:) = obj.posHistory(end,:)+shift;
                
                obj.posHistory  = [obj.posHistory; obj.position];
                obj.lines = cat(3, obj.lines, cat(1,obj.posHistory(end-1,:), obj.posHistory(end,:)));
            end
        end
        
        function trace(obj)
            
            
            
            plot(obj.lines(:,1,end), obj.lines(:,2,end), 'Color', [.7 .7 .7])
            
            xlim([0, 1])
            ylim([0, 1])
            axis square
            
        end
        
        function gravity(obj, point, gravConst, mode)
            
            dist  = pdist([obj.position; point]);
            acc = gravConst/(dist^2);
            dir = [obj.position(1)- point(1) obj.position(2)- point(2)];
            dir = dir/norm(dir);

            obj.speed(1) = obj.speed(1) + mode * dir(1) * acc;
            obj.speed(2) = obj.speed(2) + mode * dir(2) * acc;
            
            % hier muss noch was geändert werden
            obj.speed       = obj. speed/norm(obj. speed)*.05;
   
        end
    end
    
end

