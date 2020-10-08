event_inherited();

// TERRAIN LIST
var ii, ter_block, dashwave = id;

if(!terrain_col_done && !self.holographic && instance_exists(my_guy))
{
    for(ii=0; ii<my_guy.ter_list_length; ii+=1)
    {
        ter_block = my_guy.ter_list[| ii];
        if(instance_exists(ter_block))
        {    
            with(ter_block)
            {
                var shield = instance_place(x,y, shield_obj);
                if(object_index == wall_obj && place_meeting(x,y, dashwave) && (shield == noone || shield.my_player == dashwave.my_player) )
                {
                    if((my_color != dashwave.my_color || my_color == g_octarine) || (xstart == x && ystart == y))
                    {
                        if(!dashwave.wallhit_played)
                        {
                            my_sound_play(shot_wallhit_sound);
                            //my_sound_play_colored(shot_wallhit_sound, dashwave.my_color);
                            dashwave.wallhit_played = true;
                        }
                        
                        var power_ratio = get_power_ratio(my_color, dashwave.my_color);
                        if(power_ratio != 0)
                        {
                            var body_dmg = dashwave.force*power_ratio;
                            
                            my_next_color = dashwave.my_color;
                            damage += body_dmg;
                            scale_buffer += body_dmg;
                            energy += abs(body_dmg);
                            
                            last_dmg = body_dmg;    
                            
                            if((body_dmg > 1.5 || (unstable && body_dmg > 0.5)) && cover != cover_indestr)
                            {
                                falling = true;
                            }
                        
                            if(body_dmg != 0)
                            {
                                last_attacker_update(dashwave, "body", "damage");
                                create_damage_popup(body_dmg, dashwave.my_color, id);
                            }
                        }
                    }
                }
            }
        }
    }
}

terrain_col_done = true;

