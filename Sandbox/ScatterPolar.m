function Handle = ScatterPolar(rho,theta,S,C)
    
    x = rho.*cos(theta);
    y = rho.*sin(theta);
    
    if nargout < 1
        scatter(x,y,S,C,'filled');
    else
        Handle = scatter(x,y,S,C,'filled');
    end
    
end