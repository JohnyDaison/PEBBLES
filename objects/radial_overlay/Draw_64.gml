if(ready)
{ 
    with(energyball_obj)
    {
        if(tracked)
        {
            if(object_out_of_view(id, other.my_camera))
            {
                draw_sprite_ext(curved_arrow_spr, 0, radial_gui_x, radial_gui_y, 1.5, 1.5, radial_gui_dir, self.tint, 0.7);
            }
        }
    }
    
    with(structure_obj)
    {
        if(hp > 0 && my_player == other.my_player && last_attacker_map[? "target"] == "body")
        {
            if(object_out_of_view(id, other.my_camera))
            {
                if((singleton_obj.step_count - last_attacker_map[? "step"]) < other.blink_length && round(singleton_obj.step_count/other.blink_rate) mod 2 == 0)
                    draw_sprite_ext(sprite_index, 0, radial_gui_x, radial_gui_y, 1.25, 1.25, 0, other.damage_tint, 0.9);
            }
        }
        else if(object_index == guy_spawner_obj && my_player == other.my_player)
        {
            if(object_out_of_view(id, other.my_camera))
            {   
                draw_sprite_ext(sprite_index, 0, radial_gui_x, radial_gui_y, 0.5, 0.5, 0, tint, 0.4);  
                draw_sprite_ext(curved_arrow_spr, 0, radial_gui_x, radial_gui_y, 1.5, 1, radial_gui_dir, tint, 0.4);
            }
        }
    }
    
    with(guy_obj)
    {
        if(my_player != gamemode_obj.environment && !invisible && !dead)
        {
            if(object_out_of_view(id, other.my_camera))
            {
                draw_sprite_ext(sword_pointer_spr, 0, radial_gui_x, radial_gui_y, 1, 1, radial_gui_dir, c_white, 0.6); //merge_colour(tint,c_white, 0.25)
                //draw_sprite_ext(sword_pointer_spr, 0, radial_gui_x, radial_gui_y, 0.9, 0.9, radial_gui_dir, c_white, 0.3);
            }
        }
    }
}

