action_inherited();

if(instance_exists(my_projector) && my_spawner == noone )
{
    my_spawner = my_projector;    
}

if(instance_exists(my_spawner) && my_guy == noone )
{
    my_guy = my_spawner.my_guy;    
}

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

