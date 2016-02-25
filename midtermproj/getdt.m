 function [retval] = getdt (wallLoc, ballRad, position, velocity)
 
retval = (wallLoc - ballRad - position)/velocity;
end 