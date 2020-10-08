if(!cancelled)
{
    // BATTLEFEED AND SCORE    
    var score_str = "", i;
    var la_player = my_block.last_attacker_map[? "player"];
    var who = my_block.last_attacker_map[? "source_id"];
    var what = last_attacker_map[? "source"];

    if(instance_exists(la_player))
    {
        if(la_player != gamemode_obj.environment) 
        {
            var score_value = 0;
   
            if(my_block.last_attacker_map[? "source"] == guy_obj)
            {
                score_value = gamemode_obj.score_values[? "guy_kills_turret"];
            }
            else
            {
                score_value = gamemode_obj.score_values[? "npc_kills_turret"]; 
            }
            
            if(la_player != turret.my_player)
            {
                increase_stat(la_player, "score", score_value, false);
                score_str = stat_label("score", score_value, "+");
            }
        }
        
        if(la_player != turret.my_player)
        {
            increase_stat(la_player, "turrets_destroyed", 1, false);
            if(what == guy_obj)
            {
                increase_stat(la_player, "turrets_destroyed_by_guy", 1, false);
            }
        }
        else if(who == my_player.my_guy)
        {
            increase_stat(la_player, "turrets_denied", 1, false);
        }

        increase_stat(turret.my_player, "turrets_lost", 1, false);
        
        var params = create_params_map();
        params[? "who"] = my_block.last_attacker_map[? "source_id"];
            
        broadcast_event("object_destroy", id, params);
    }
    
    battlefeed_post_destruction(id, my_block.last_attacker_map, score_str);
    
    if(object_index == small_turret_mount_obj)
    {
        // DROP SPARKS
        var sparks = 10;
        for(var a=0; a<sparks; a+=1)
        {
            i = instance_create(turret.x, turret.y, spark_obj);
            i.direction = random(360);
            i.speed = 4;
            i.my_color = turret.my_color;
        }
    }
    else if(object_index == turret_mount_obj)
    {
        // DROP ORB
        i = instance_create(turret.x, turret.y, color_orb_obj);
        i.my_color = turret.my_color;
        i.tint_updated = false;
        i.my_guy = i.id;
        i.color_added = true;
        i.direction = direction;
        i.speed = 3;
    }
    else if(object_index == beam_turret_mount_obj)
    {
        // DROP ORBS
        dir = 90;
        ammo_drop_count = 3;
        col = g_red;
        repeat(ammo_drop_count)
        {
            i = instance_create(turret.x, turret.y, color_orb_obj);
            i.direction = dir;
            i.speed = 2;
            if(col == g_yellow)
                col = g_blue;
            i.my_color = col;
            i.my_guy = i.id;
            i.airborne = true;
            i.color_added = true;
            
            dir += 360/ammo_drop_count;
            col++;
        }
    }
        
    // SHOCKWAVE
    i = instance_create(x,y,shield_obj);
    i.sprite_index = old_shield_sprite;
    i.my_player = my_player;
    i.overcharge = 5;
    i.chargerate = 250;
    i.charge = 0.5;
    i.my_color = self.my_color; 
    i.my_guy = i.id;
    i.my_source = object_index;
}

// CLEAN TURRET
with(turret)
{
    instance_destroy();
}

with(my_beam)
{
    instance_destroy();
}

event_inherited();
