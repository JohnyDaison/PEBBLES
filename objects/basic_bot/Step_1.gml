///@description GUY DETECTION AND NPC ACTIVATION

event_inherited();

if (dead)
{
    phase = 0;
    if (my_player.my_guy != id)
    {
        npc_active = false;
    }
}
else
{
    if (lost_control)
    {
        phase = 0;
        
        if (bot_type == "tut_guide")
        {
            has_spoken = false;
            has_autospoken = false;
        }
    }
    else
    {
        var near_guy = noone;
        var nearest_distance = 0;
        var obj_index = guy_obj;
        
        // HACK
        if (bot_type == "arena_bot")
        {
            obj_index = phys_body_obj;
        }
        
        // PHYS BODIES
        with(obj_index)
        {
            if (iff_check("not_allied", other, id))
            {
                var nearest = false;
                if (near_guy == noone || point_distance(x,y, other.x, other.y) < nearest_distance)
                {
                    nearest = true;
                }
                
                if (nearest && !invisible && (!protected || (is_npc && bot_type == "arena_bot")) && (other.bot_type == "tut_guide" || holographic == other.holographic))
                {
                    near_guy = id;
                    nearest_distance = point_distance(x,y, other.x, other.y);
                }
            }
        }
        
        // HACK
        if (bot_type == "arena_bot")
        {
            // SHIELDS
            with(shield_obj)
            {
                if (my_guy != id && iff_check("attack_target_valid", other, id))
                {
                    var nearest = false;
                    if (near_guy == noone || point_distance(x,y, other.x, other.y) <= nearest_distance)
                    {
                        nearest = true;
                    }
                
                    if (nearest)
                    {
                        near_guy = id;
                        nearest_distance = point_distance(x,y, other.x, other.y);
                    }
                }
            }
        }

        // NPC ACTIVATE/DEACTIVATE
        if (instance_exists(near_guy))
        {
            if (!npc_active)
            {
                if (point_distance(x,y, near_guy.x, near_guy.y) < bot_activation_distance)
                {
                    npc_active = true;
                    observer_add(chunkgrid_obj, id);
                }
            }
            else
            {
                if (!stay_activated && point_distance(x,y, near_guy.x, near_guy.y) > bot_deactivation_distance)
                {
                    npc_active = false;
                }
            }
        }
    
        script_execute(npc_script, near_guy);
        
        if (npc_active)
        {
            if (spawn_batteries)
            {
                // SELF SUSTAIN
                var sust_coef = 1;
                if (difficulty < 1)
                {
                    sust_coef = difficulty;
                }
                else if (difficulty > 1)
                {
                    sust_coef = sqr(difficulty);
                }
    
                var allow_battery = false;
                var total_power_level = 0, average_power_level;
    
                for (var col=g_red; col<=g_blue; col++)
                {
                    if (col != g_yellow)
                    {
                        total_power_level += get_orb_list_power_level(orbs_in_use[? col]);
                    }
                }
    
                average_power_level = total_power_level/3;
                allow_battery = average_power_level < 0.4;
    
                if (allow_battery && (step_count mod sustain_tick_time) == 0 && random(20/sust_coef) < 1)
                {
                    var batt = instance_create(x,y, orb_battery_obj);
                    batt.my_guy = id;
                    with(batt)
                    {
                        event_perform(ev_other, ev_user1);
                        instance_destroy();
                    }
                }
            }
        }
    }
}

// STOP OBSERVING
if (!npc_active && (speed == 0 || dead) && my_chunkgrid != noone)
{
    observer_remove(my_chunkgrid, id);
}
