if(visible)
{
    if(place_meeting(x,y, terrain_obj))
    {
        alarm[0] = gamemode_obj.regenerate_terrain_delay;
        visible = false;
        exit;
    }
    
    image_alpha = 1 - 0.5*(image_index/image_number);
    
    if((image_index + image_speed) <= 0)
    {
        regen_ter = instance_create(x, y, wall_obj);
        regen_ter.energy = energy;
        regen_ter.my_next_color = my_color;
        regen_ter.damage = damage;
        regen_ter.color_locked = color_locked;   
        
        instance_destroy();
    }
}