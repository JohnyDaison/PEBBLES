/// @description CORES AND COVERS, FALLING

event_inherited();

/// CORES AND COVERS
if(self.core_updated == false)
{
    switch(core)
    {
        case core_none:
        {
            sprite_index = empty_wall_spr;
            my_color = g_dark;
            break;  
        }
        case core_insulator:
        {
            sprite_index = insulator_wall_spr;
            tint = c_gray;
            tint_updated = true;
            custom_sprite = true; 
            
            name = "Insulator";
            break;
        }
        case core_gate_pass:
        {
            sprite_index = gate_pass2_spr;
            tint = c_gray;
            tint_updated = true;
            custom_sprite = true;
            
            name = "Gate Pass";
            break;
        }
        case core_energy:
        {
            if(cover == cover_indestr)
            {
                //sprite_index = new_wall2_spr;
                sprite_index = semitransp_wall_spr;
                name = "Indestructible";
            }
            else {
                sprite_index = semitransp_wall_spr;
                name = "Normal";
            }
            break;  
        }
        default:
        {
            instance_destroy();
        }
    }
    
    core_updated = true;
    tint_updated = false;
}

if(self.cover_updated == false)
{
    switch(cover)
    {
        case cover_indestr:
        {
            cover_spr = indestr_cover2_spr;
            cover_color = g_dark;
            cover_multicolor = false; 
            break;  
        }
        case cover_armor:
        {
            cover_spr = armor_cover_spr;
            cover_multicolor = true;  
            break;
        }
        case cover_grate:
        {
            cover_spr = grate_cover_spr;
            cover_multicolor = false;
            break;
        }
        default:
        {
            cover_spr = noone;
            cover_tint = -1;
            cover_updated = true;
            break;
        }
    }
    
    if(cover_spr != noone && cover_color > -1)
    {
        if(cover_multicolor)
        {
            var cover_new_tint = ds_map_find_value(DB.colormap,cover_color);
        
            cover_tint = merge_color(cover_tint, cover_new_tint, 1/6);
        
            if(cover_tint == cover_new_tint)
            {
                cover_updated = true;
            }
        }
        else
        {
            cover_tint = c_white;
            cover_updated = true;
        }
    }
}

/// FALLING

if(falling && singleton_obj.step_count mod 5 == 0)
{
    // COLLISION DETECTION
    blocked = false;
    ter = instance_place(x,y+32, terrain_obj);
    if(instance_exists(ter))
    {
        if(ter.falling)
        {
            blocked = true;
            falling_force -= 1;
        }
        else if(ter.image_speed == 0)
        {
            falling = false;
        }
    }   
    
    str = instance_place(x,y+32, structure_obj);
    if(instance_exists(str) && (str.walkable || str.terrain_holder) && !str.holographic)
    {
        falling = false;
    }   
    
    // FALL STEP
    if(falling && !blocked)
    {
        terrain_deregister(my_grid ,id);
        terrain_move(id, x, y +32);
        registered = terrain_register(my_grid ,id);
        
        falling_force += 1;
    }
    
    // FALL END
    if(!falling)
    {
        // SOFT LANDING
        if(falling_force > 0 && falling_force < impact_threshold)
        {
            my_sound_play(wall_crumble_sound, true);
        }
        
        // HARD LANDING
        if(falling_force >= impact_threshold)
        {
            // IMPACT
            i = instance_create(x+15,y+34,impact_obj);
            i.impact_force = min(max_impact_force, falling_force*impact_ratio);
            i.my_guy = id;
            i.my_source = object_index;
            i.holographic = holographic;
            my_sound_play(impact_sound);
            my_sound_play(wall_crumble_sound, true);
            
            // VIEWSHAKE
            with(guy_obj)
            {
                var cam = my_player.my_camera;
                if(cam != noone)
                {
                    var dist = point_distance(x,y,other.x,other.y);
                    if(dist < other.shake_range)
                    {
                        viewshake(cam, 270,
                            min(20, 10 * sqrt(1-dist/other.shake_range) ) );
                    }
                }
            }
        }
        
        falling_force = 0;
    }
}
