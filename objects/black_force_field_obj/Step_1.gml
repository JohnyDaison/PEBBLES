event_inherited();

switch(shape)
{
    case shape_circle:
    
    height = 2*radius;
    width = 2*radius;
    
    break;
    
    case shape_rect:
    
    radius = min(width,height);
    
    break;
}

