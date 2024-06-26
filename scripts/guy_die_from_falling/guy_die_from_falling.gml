function guy_die_from_falling() {
    var stat_str = "";
    var score_value = 0;
    var la_player = last_attacker_map[? "player"];
    var who = last_attacker_map[? "source_id"];
    var is_suicide = false;
    var is_player_guy = my_player.my_guy == id;

    // KILL STATS
    if(instance_exists(la_player))
    {
        var is_la_player_guy = false;
        if (instance_exists(who)) {
            is_la_player_guy = who == la_player.my_guy;
        }
        // KILLED BY ANOTHER
        if(la_player.team_number != my_player.team_number && gamemode_obj.is_deathmatch)
        {
            if(la_player != gamemode_obj.environment)
            {
                score_value = gamemode_obj.score_values[? "npc_kills_guy"];
                        
                if(is_la_player_guy) {
                    score_value = gamemode_obj.score_values[? "guy_kills_guy"];
                    increase_stat(la_player, "personal_kills", 1, false);
                    
                    if (is_player_guy) {
                        if(my_player != gamemode_obj.environment)
                        {
                            who.min_damage += gamemode_obj.soul_tear * (who.hp - who.min_damage);
                        }
                
                        if(gamemode_obj.player_count > 1
                        && my_player != gamemode_obj.environment
                        && isPlayerStat(la_player, "score", "lowest", true))
                        {
                            score_value += gamemode_obj.score_values[? "underdog_kill_bonus"];
                            increase_stat(la_player, "underdog_kills", 1, false);
                            battlefeed_post_string(la_player, "Underdog Kill");
                        }
                    }
                    
                    increase_stat(la_player, "kills", 1, false);
                    increase_stat(la_player, "killstreak", 1, false);
                }
                
                score_value = round(score_value * self.score_multiplier);
                increase_stat(la_player, "score", score_value, false);
                stat_str = stat_label("score", score_value, "+");
            }
            
            set_stat(la_player,"deathstreak",0,false);
        }
        else
        {
            // KILLED BY OWN ATTACK
            if(who == id)
            {
                is_suicide = true;
            }
        }
    }
    // KILLED BY FALLING OUT
    else
    {
        is_suicide = true;
            
        last_attacker_update(id, "body", "fall");
    }
    
    // REPORT
    var params = create_params_map();
    params[? "who"] = who;
    params[? "who_player"] = la_player;
    
    battlefeed_post_destruction(id, id.last_attacker_map, stat_str);
    broadcast_event("object_destroy", id, params);
    
    // DEATH STATS
    if (is_player_guy) {
        if (is_suicide) {
            score_value = gamemode_obj.score_values[? "guy_suicide"];
        
            increase_stat(my_player,"suicides", 1, false);
            if(!gamemode_obj.is_campaign && gamemode_obj.is_deathmatch)
            {
                increase_stat(my_player, "score", score_value, false);
                stat_str = stat_label("score", score_value, "+");
            }
        }
        
        increase_stat(my_player,"deaths",1,false);
        increase_stat(my_player,"deathstreak",1,false);
    
        set_stat(my_player,"killstreak",0,false);
        set_stat(my_player,"spellstreak",0,false);
        set_stat(my_player,"abilitystreak",0,false);

        broadcast_event("player_death", id, params);
    }
    
    // GUY STATE
    lost_control = true;
    front_hit = true;
    dead = true;
    invisible = true;
    
    // SHOW DEATH COVER
    if(instance_exists(my_player.my_camera) && is_player_guy)
    {
        my_player.my_camera.death_cover_show = true;
    }
    
    // DESTROY SHIELD
    if(instance_exists(my_shield))
    {
        with(my_shield)
        {
            //instance_destroy();
            done_for = true;
        }
        shield_ready = true;
        alarm[4] = -1;
    }
    
    // DROP ITEMS
    drop_all_items();
    
    // DROP ALL EQUIPMENT
    body_unequip_all(id);
    
    // PLAYER GUY
    if(is_player_guy)
    {
        if(!respawn_allowed())
        {
            // LOSE THE GAME
            my_player.loser = true;
            ds_list_add(gamemode_obj.losers, my_player.id);
        }
        else
        {
            // UPDATE my_spawner TO NEAREST
            var last_standing_position = instance_create(last_standing_x, last_standing_y, place_holder_obj);
            var results = find_nearest_instances(last_standing_position, guy_spawn_point_obj, -1, "player", my_player);
            var result_count = ds_list_size(results);
            var p_i, result, point, my_spawn_point = noone;
            
            for(p_i = 0; p_i < result_count; p_i++)
            {
                result = results[| p_i];
                //my_console_log("Point"+string(p_i)+": " + string(result[? "distance"]));
                point = result[? "id"];
                
                if(point.my_spawner.enabled)
                {
                    my_spawner = point.my_spawner;
                    my_spawn_point = point;
                    if(instance_exists(my_player.my_camera))
                    {
                        my_player.my_camera.my_spawner = my_spawner;
                    }
                    break;
                }
            }
            
            instance_destroy(last_standing_position);
            
            if(instance_exists(my_spawner))
            {
                // START RESPAWN
                if(my_spawner.object_index == guy_spawner_obj)
                {
                    // BASE CRYSTAL
                    if(my_spawner.enabled)
                    {
                        // ACTIVATE MY SPAWNER
                        respawn_skiptime = 0;
                        if(isPlayerStat(my_player, "score", "lowest", false))
                        {
                            respawn_skiptime = getStatValue("kills", "highest") * 42;
                        }
                        /*
                        my_spawner.alarm[1] = round(max(60,my_spawner.respawn_time - respawn_skiptime));
                        alarm[6] = min(my_spawner.alarm[1]-10, 3 * singleton_obj.game_speed);
                        */
                        current_respawn_time = round(max(60,my_spawner.respawn_time - respawn_skiptime));
                        alarm[5] = current_respawn_time;
                        alarm[6] = min(alarm[5]-10, 3 * singleton_obj.game_speed);
                        
                        my_spawner.activated = true;
                        
                        my_spawn_point.activated = true;
                    }
                    else
                    {
                        // LOSE THE GAME
                        my_player.loser = true;
                        ds_list_add(gamemode_obj.losers, my_player.id);
                    }
                }
                else
                {
                    // LEVEL START
                    if(my_spawner.enabled)
                    {
                        // ACTIVATE SPAWNER
                        current_respawn_time = 60;
                        alarm[5] = current_respawn_time;
                        alarm[6] = singleton_obj.game_speed/2;
                        my_spawner.activated = true;
                        
                        my_spawn_point.activated = true;
                    }
                }
            }
        }
        
        if(!instance_exists(my_player))
        {
            my_console_log("WTF 01");
        }
        
        // CAMERA
        if(instance_exists(my_player.my_camera))
        {
            // FOLLOW SPAWNER
            my_player.my_camera.follow_guy = false;
            my_player.my_camera.follow_spawner = true;

            // CREATE PLACE HOLDER
            if(!instance_exists(place_holder))
            {
                place_holder = instance_create(x,y,place_holder_obj);
                place_holder.my_player = my_player;
                my_player.my_camera.my_guy = place_holder;
            }
        }
    }
    
    my_sound_play(fall_sound);
    
    chunk_deregister(chunkgrid_obj, id);
    
    schedule_chunk_optimizer();
}