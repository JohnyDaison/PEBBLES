//TEMP FIX for crystal not slowly drifting away after receving hits
//speed = 0;

if(self.enabled)
{
    crystal_number = ds_list_size(crystals);
    
    // GUY INTERACTIONS
    var my_player_count = ds_list_size(my_players), p_i, player, guy;
    
    for(p_i = 0; p_i < my_player_count; p_i++)
    {
        player = my_players[| p_i];
        
        if(instance_exists(player.my_guy))
        {
            guy = player.my_guy;
            
            // ACCEPT CRYSTALS
            if(place_meeting(x,y, guy)) {
                var crystal;
        
                if(crystal_number < max_crystals)
                {
                    // CRYSTALS TO ORBIT
                    with(guy)
                    {
                        crystal = find_in_inventory(crystal_obj);
                        if(crystal != noone)
                        {
                            crystal = take_from_inventory(crystal, 1);
                        }
                    }
            
                    if(instance_exists(crystal))
                    {
                        crystal.my_guy = id;
                        crystal.draw_label = false;
                        ds_list_add(crystals, crystal);
                        crystal_number += 1;
                        /*
                        with(crystal)
                        {
                            i = instance_create(x,y,shield_obj);
                            i.my_guy = id;
                            i.my_player = other.my_player;
                            i.charge = 1;
                            i.my_color = my_color;
                            i.tint_updated = false;
                            my_shield = i;
                        }
                        */
                        increase_stat(player,"shards_collected", 1, true);
                        my_sound_play(crystal_sound);
                    }   
                }
                else
                {
                    // CRYSTALS TO SCORE
                    with(guy)
                    {
                        crystal = find_in_inventory(crystal_obj);
                        while(crystal != noone)
                        {
                            crystal = take_from_inventory(crystal, crystal.stack_size);
                    
                            var score_gain = crystal.stack_size * gamemode_obj.score_values[? "extra_shard"];
                    
                            increase_stat(player,"extra_shards", crystal.stack_size, false);
                            increase_stat(player,"score", score_gain, false);
                    
                            battlefeed_post_pickup(player, crystal.object_index, score_gain);
                    
                            with(crystal)
                            {
                                instance_destroy();
                            }
                    
                            crystal = find_in_inventory(crystal_obj);
                        }
                    }
                }
            }
            
            // HP AND ENERGY REGEN
            if(instance_exists(self.my_shield))
            {
                if(point_distance(x,y,guy.x,guy.y) < my_shield.radius)
                {
                    var orig_damage = guy.damage;
                    guy.damage = max(guy.min_damage, guy.damage - crystal_number*crystal_guy_regen);
                    guy.my_player.healed_dmg_total += orig_damage - guy.damage;
            
                    var list, orb;
                    for(i=g_red; i<=g_blue; i++)
                    {
                        if(i == g_yellow) continue;
                
                        list = guy.orb_belts[? i];
                        if(!is_undefined(list) && ds_exists(list, ds_type_list))
                        {
                            ii = ds_list_size(list)-1;
                            for(;ii>=0;ii--)
                            {
                                orb = list[|ii];
                                if(instance_exists(orb) && orb.energy < orb.base_energy)
                                {
                                    orb.energy = min(orb.base_energy, orb.energy + (crystal_number/max_crystals+1)*DB.orb_regen_speeds[? spd_slow]);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // CONSUME CRYSTALS FOR BASE HEALTH
    if (shard_to_consume == noone && crystal_number > 0 
    && crystal_number > floor((1-damage/hp)*max_crystals) && damage >= crystal_heal)
    {
        shard_to_consume = crystals[| crystal_number-1];
    }
    
    if (shard_to_consume != noone) {
        shard_to_consume.fade_counter -= consume_anim_speed;
        
        if (shard_to_consume.fade_counter <= 0) {
            consume_shard(shard_to_consume);
            shard_to_consume = noone;
        }
    }
    
    // SHIELD REGEN BONUS
    
    shield_chargerate = base_shield_chargerate
                        + crystal_boost*crystal_number;
                        
    // FLAG ICON
    var first_player = my_players[| 0];
    
    if(!is_undefined(first_player))
    {
        flag_icon = first_player.icon;
    }
    else
    {
        flag_icon = noone;   
    }
    
    // DESTRUCTION
    if((damage >= hp || done_for) && !self.destroyed)
    {
        if(instance_exists(my_shield))
        {
            my_shield.done_for = true;
        }
        i = instance_create(x,y,slot_explosion_obj);
        i.my_player = my_player;
        i.my_color = irandom_range(1,7);
        i.my_source = object_index;
        self.visible = false;
        self.invisible = true;
        self.enabled = false;
        self.destroyed = true;
        
        var p_i;
        for(p_i = 1; p_i < gamemode_obj.player_count; p_i++)
        {
            var spawn_point = spawn_points[? p_i];
        
            if(!is_undefined(spawn_point))
            {
                with(spawn_point)
                {
                    if(self.activated && my_guy.dead)
                    {
                        my_player.loser = true;
                        ds_list_add(gamemode_obj.losers, my_player.id);
                    }
                    else
                    {
                        my_guy.protected = true; 
                        with(my_guy)
                        {
                            alarm[2] = my_spawner.protection_time;
                        }
                    }
                }
            }
        }
        
        alarm[1] = -1;
        self.activated = false;
        
        var stat_str = "";
        var la_player = last_attacker_map[? "player"];
        
        if(instance_exists(la_player))
        {
            if(la_player.team_number != my_player.team_number)
            {
                var score_value = gamemode_obj.score_values[? "base_crystal_killed"];
            
                increase_stat(la_player, "score", score_value, false);
                stat_str = stat_label("score", score_value, "+");
            }
        }
        
        battlefeed_post_destruction(id, id.last_attacker_map, stat_str);
        
        var i;
        for(i=0; i<crystal_number; i++)
        {
            with(crystals[|i])
            {
                instance_destroy();
            }
        }
        ds_list_clear(crystals);
    }

    // START SPAWNING
    if(player_start_point && !players_created && !self.activated)
    {
        self.activated = true;
        alarm[0] = round(first_spawn_time);
    }
   
    // SHIELD RECHARGE
    if(!instance_exists(my_shield) && !self.holographic && self.shield_ready && shield_power > 0)
    {
        self.my_shield = instance_create(x,y,shield_obj);
        my_shield.my_guy = id;
        my_shield.max_charge = shield_power - shield_overcharge;
        my_shield.charge = shield_power;
        my_shield.size_coef = 0.75;
        my_shield.low_charge_ratio = 0.5;
        my_shield.field_power = 2;
        my_shield.my_color = g_white;
        my_shield.my_player = my_player;
        my_sound_play(shield_ready_sound);
    }
}

if(!self.activated)
{
    self.my_color = g_white;
}
else
{
    self.my_color = g_octarine;
    tint_updated = false;
}


// debug
/*
draw_label = true;

var pl_name = "N/A";
if(instance_exists(my_player))
{
    pl_name = my_player.name;   
}

var pl_names = "N/A";
var my_player_count = ds_list_size(my_players), p_i, player;
    
for(p_i = 0; p_i < my_player_count; p_i++)
{
    player = my_players[| p_i];
    
    if(p_i == 0)
    {
        pl_names = player.name;
    }
    else
    {
        pl_names += ", " + player.name
    }
}

name = pl_name + " | " + pl_names;
*/