function [d] = distance(x,y)
d = 1./sqrt(sum((x-y).^2,2));
end