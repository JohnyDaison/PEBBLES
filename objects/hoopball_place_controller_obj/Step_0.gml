with(guy_obj)
{
    if(my_player != gamemode_obj.environment)
    {
        if(tint != forced_tint)
        {
            multicolor = false;
            var color = other.player_colors[? my_player.number];
            forced_tint = DB.colormap[? color];
            tint_updated = false;
        }
        
        if(!dead && !instance_exists(my_shield))
        {
            var inst = instance_create(x, y, shield_obj);
            inst.my_guy = id;
            inst.my_source = object_index;
            inst.my_player = self.my_player;
            inst.charge = inst.max_charge;
            inst.draw_bar = false;
            inst.my_color = place_controller_obj.current_color;
            inst.holographic = false;
            my_shield = inst.id;
            
            var equipment = instance_create(0,0, hoopball_shield_weapon_obj);
            body_equip(id, equipment);
        }
        
        damage = 0;
        
        status_left[? "haste"] = 60;
    }
}

if(!instance_exists(da_ball))
{
    da_ball = noone;
    
    if(alarm[4] == -1 && !gamemode_obj.limit_reached && instance_exists(guy_obj))
    {
        alarm[4] = ball_respawn_wait;
    }
}

with(wall_obj)
{
    if(rule_get_state("indestr_terrain"))
    {
        color_locked = true;   
    }
    if(cover != cover_indestr)
    {
        if(energy > 0)
        {
            energy = max(0, energy - 0.01);
            if(energy == 0)
            {
                my_next_color = g_dark;   
            }
        }
    }
}