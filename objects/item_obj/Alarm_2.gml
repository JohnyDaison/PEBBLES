/// @description DUPLICATION FOR GUIDE AND OTHER PLAYERS
if(duplicate_me && !is_duplicate)
{
    for_player = 1;
    
    show_debug_message("DUPLICATE");
    
    var i = 0, total = gamemode_obj.player_count;
    
    if(not_for_guide)
    {
        i = 1;    
    }
    
    for(; i <= total; i++) 
    {
        if(i != for_player)
        {
            var inst = instance_create(x,y, object_index);
            inst.for_player = i;
            inst.my_color = my_color;
            inst.immovable = immovable;
            inst.keep_on_death = keep_on_death;
            inst.level_upto = level_upto;
            inst.stack_size = stack_size;
            if(i == 0)
            {
                inst.holographic = true;
            }
            
            if(object_index == color_orb_obj)
            {
                inst.color_added = true;
                inst.airborne = true;
            }
            
            if(object_index == ability_pickup_obj)
            {
                inst.target_level = target_level;
            }
            
            inst.is_duplicate = true;
            //inst.invisible = true;
        }
    }
}

register_item(id);