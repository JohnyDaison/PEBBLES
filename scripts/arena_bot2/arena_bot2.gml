function arena_bot2(argument0) {
    if(npc_active || next_phase != 0)
    {
        // NEAR PLAYER
        var near_player = argument0;
        var pl_dist = 0;
        var last_phase = 5;
        var opponent_color = g_white;
    
        var npc_wanna_shield = false;
        var use_abi = false;
        var abi_color = g_nothing;
    
        if(instance_exists(near_player))
        {
            pl_dist = point_distance(x,y, near_player.x, near_player.y);
            opponent_color = near_player.my_color;
            if(instance_exists(near_player.my_shield))
            {
                opponent_color = near_player.my_shield.my_color;
            }
        }
        else
        {
            if(phase >= last_phase)
            {
                next_phase = last_phase;
            }
        }
    
        phase = next_phase;
    
        if(dead)
        {
            phase = 0;
            next_phase = 0;
        }
    
        var near_room_edge = abs(x) < (flashback_margin / 2) || abs(x - room_width) < (flashback_margin / 2) || abs(y - room_height) < flashback_margin;
    
        // MATCH BURST COLOR
        var burst = instance_place(x,y, energy_burst_obj), col;
            
        if(instance_exists(burst))
        {
            if(!slots_triggered && my_color != burst.my_color)
            {
                if(current_slot == 0)
                {
                    for(col = g_red; col <= g_blue; col++)
                    {
                        if(col == g_yellow)
                            continue;

                        if(col & burst.my_color)
                        {
                            ds_list_add(new_colors, col);
                        }
                    }
                    
                    self.auto_chosen_orbs = true;
                }
            
                wanna_cast = true;
                wanna_channel = false;
                wanna_abi = false;
            }
                
            color_chosen = true;
            phase = 1;
            next_phase = 1;
        }
    
        // PHASES
    
        // choose color and charge phase
        if(phase == 0)
        {
            wanna_cast = false;
            wanna_channel = false;
            wanna_abi = false;
            npc_wanna_shoot_dark_decided = false;
            var npc_wanna_cast = false;
        
            if(prev_phase != phase || potential_color == g_dark || channeling || auto_chosen_orbs)
            {
                color_chosen = false;
            }
        
            if(!auto_chosen_orbs)
            {
                // GENERAL PROBLEM SOLVING
            
                // STATUS EFFECTS
                if(!color_chosen)
                {
                    if((status_left[? "frozen"] > 0 || sliding || wall_sliding) && my_color != g_blue)
                    {
                        if(current_slot == 0 && !slots_triggered)
                        {
                            ds_list_add(new_colors, g_blue);
                            self.auto_chosen_orbs = true;
                            wanna_cast = true;
                        }
                    }
                    else if(status_left[? "slow"] > 0 && my_color != g_green)
                    {
                        if(current_slot == 0 && !slots_triggered)
                        {
                            ds_list_add(new_colors, g_green);
                            self.auto_chosen_orbs = true;
                            wanna_cast = true;
                        }
                        wanna_jump = !wanna_jump;
                    }
                    else if(status_left[? "burn"] > 0 && my_color != g_red)
                    {
                        if(current_slot == 0 && !slots_triggered)
                        {
                            ds_list_add(new_colors, g_red);
                            self.auto_chosen_orbs = true;
                            wanna_cast = true;
                        }
                    }
                    else if(status_left[? "suppressed"] > 0 && my_color != g_magenta)
                    {
                        if(current_slot == 0 && !slots_triggered)
                        {
                            ds_list_add(new_colors, g_red, g_blue);
                            self.auto_chosen_orbs = true;
                            wanna_cast = true;
                        }
                    }
                }
        
                if(self.wanna_cast)
                {
                    color_chosen = true;   
                }
        
                // choose colors
                if(!color_chosen)
                {
                    // trigger
                    if(current_slot > 0)
                    {
                        // dark attack
                        if(potential_color == g_dark && !npc_wanna_shoot_dark_decided) // irandom(10) <= 1
                        {
                            npc_wanna_shoot_dark = random(1) < difficulty/10;
                            npc_wanna_shoot_dark_decided = true;
                            if(npc_wanna_shoot_dark)
                            {
                                color_chosen = true;
                            }
                        }
                
                        // color attacks
                        if(potential_color > g_dark && (irandom(3) <= 1
                            || (current_slot == 2 && pl_dist >= third_attack_range)
                            || (current_slot == 3 && pl_dist < third_attack_range)))
                        {
                            color_chosen = true;
                        }
                    }   
                }
        
                // new color
                if(!color_chosen)
                {
                    var new_color = 3;
            
                    while(new_color == 3)
                    {
                        new_color = irandom(3)+1;
                    }
            
                    if(random(6 * (current_slot + 1)) < 1)
                    {
                        ds_list_add(new_colors, new_color);
                        self.auto_chosen_orbs = true;
                    }
                    else if(!(opponent_color & new_color) && random(4 * (current_slot + 1)) < 1)
                    {
                        ds_list_add(new_colors, new_color);
                        self.auto_chosen_orbs = true;
                    }
                }
        
                if(color_chosen)
                {
                    if(potential_color != g_dark && has_level(id, "shield", 1) && ((!instance_exists(my_shield) && shield_ready) || status_left[? "suppressed"] > 0))
                    {
                        // SHIELD
                        npc_wanna_cast = true;
                        npc_wanna_shield = true;
                        attack_mode = false;
                    }
                    else
                    {
                        /*
                        if(!instance_exists(self.attack_target))
                        {
                            self.attack_target = near_player;
                        }
                        */
                        // ATTACK
                        /* if(status_left[? "suppressed"] == 0 && instance_exists(near_player) && !near_player.invisible && !near_player.dead && holographic == near_player.holographic
                        && npc_line_of_sight(near_player.x, near_player.y, "attack")) */
                        if(status_left[? "suppressed"] == 0 && instance_exists(self.attack_target) && !self.attack_target.invisible && holographic == self.attack_target.holographic
                        && !(object_is_child(self.attack_target, phys_body_obj) && self.attack_target.dead)
                        && npc_line_of_sight_instance(self.attack_target, "attack"))
                        {
                            //self.hor_dir_held = true;
                            npc_wanna_cast = true;
                            attack_mode = true;
                    
                            if(DB.console_mode == "debug") // DB.console_mode == "test" ||
                            {
                                if(potential_color == g_dark)
                                {
                                    speech_instant("DARK ATTACK");
                                }
                            }
                    
                        }
                    }
                }
        
        
                if(npc_wanna_cast)
                {
                    self.wanna_cast = true;
                    next_phase = 1;
                }
            }
        }
    
        // chargeball trigger phase
        else if(phase == 1)
        {
            /*
            if(my_color == g_dark && !npc_wanna_shoot_dark_decided)
            {
                npc_wanna_shoot_dark = random(1) < difficulty/5;
                npc_wanna_shoot_dark_decided = true;
            }
            */
        
            if(!wanna_cast || (my_color == g_dark && !(npc_wanna_shoot_dark && npc_wanna_shoot_dark_decided && attack_mode)))
            {
                next_phase = 0;    
            }
        
            if(self.charging && charge_ball != noone)
            {
                if(potential_color != g_dark && has_level(id, "shield", 1) && ((!instance_exists(my_shield) && shield_ready) || status_left[? "suppressed"] > 0))
                {
                    // SHIELD
                    npc_wanna_shield = true;
                    attack_mode = false;
                }
            
                // fire
                if(charge_ball.charge >= ( 0.75 * min(1, bot_aggressiveness) * charge_ball.threshold) && random(10/bot_speed)<1)
                {
                    //if(!attack_mode || !instance_exists(near_player) || (status_left[? "suppressed"] == 0 && !near_player.protected && !near_player.invisible && holographic == near_player.holographic))
                    if(!attack_mode || !instance_exists(self.attack_target) || (status_left[? "suppressed"] == 0 && !self.attack_target.protected && !self.attack_target.invisible && holographic == self.attack_target.holographic))
                    {
                        self.wanna_cast = false;
                        next_phase = 3;
                    }
                }
            }
            else if(!self.slots_triggered && current_slot == 0)
            {
                // got interrupted
                self.wanna_cast = false;
                next_phase = 3;
            }
        }
    
        // flashback execution phase
        else if(phase == 2)
        {   
            wanna_channel = false;
            wanna_abi = false;
            wanna_cast = false;
        
            var possible = false;
        
            if(near_room_edge && mod_get_state("abilities"))
            {
                if(mod_get_state("dark_color") && has_level(id, "rewind", 1) && abi_cooldown[? g_dark] == 0)
                {
                    possible = true;
                    abi_color = g_dark;
                }
                else if(!lost_control && has_level(id, "base_teleport", 1) && abi_cooldown[? g_white] == 0)
                {
                    possible = true;
                    abi_color = g_white;
                }
            }
        
            if(possible)
            {
                use_abi = true;
            }
            else
            {
                next_phase = 0;
                facing_right = !facing_right;
            }
        
            npc_destination_reached = false;
            npc_waypoint = "";
            npc_last_waypoint = "";
        }
    
        // support abi execution phase
        else if(phase == 3)
        {
            wanna_channel = false;
            wanna_abi = false;
            //wanna_cast = false;
        
            var support_abi_mode = false;
            abi_color = g_dark;
        
            if(mod_get_state("abilities"))
            {
                if((damage - min_damage) > 1.5 && (has_level(id, "heal", 1) && abi_cooldown[? g_green] == 0))
                {
                    support_abi_mode = true;
                    abi_color = g_green;
                }
            
                if(damage > (hp - min_damage)*0.6 && (has_level(id, "base_teleport", 1) && abi_cooldown[? g_white] == 0)
                && base_has_crystals())
                {
                    support_abi_mode = true;
                    abi_color = g_white;
                }
            }
        
            //show_debug_message("Arena bot 2, Phase 3: sup_abi_mode=" + string(support_abi_mode) + " abi_color=" + string(abi_color));
        
            if(support_abi_mode)
            {
                use_abi = true;
            }
            else
            {
                next_phase = last_phase;
            }
        }
    
        // channelling phase
        else if(phase >= last_phase)
        {   
            wanna_cast = false;
            wanna_channel = false;
            wanna_abi = false;
        
            var belt, orb, i, chbi;
        
            if(!holding_wall && !mod_get_state("color_orbs_energy_lock"))
            {
                wanna_channel = true;
            }
        
            if(channeling)
            {
                // choose colors
                var new_color = 3;
            
                if(random(5) < 1)
                {
                    while(new_color == 3)
                    {
                        new_color = irandom(3) + 1;
                    }
            
                    // Look at which orb will be picked for that color
                    // this copies heavily from HANDLE SLOT FILLING
                    belt = orb_belts[? new_color];
                    if(!is_undefined(belt) && ds_exists(belt, ds_type_list))
                    {
                        orb = belt[|0];
                        if(!is_undefined(orb) && instance_exists(orb))
                        {
                            if(orb.energy < (orb.max_energy - 3*channel_maxboost))
                            {
                                ds_list_add(new_colors, new_color);
                                self.auto_chosen_orbs = true;
                                //my_console_log("Bot "+ string(my_player.number) + " added color from belt c:" + string(new_color) + " e:" + string(orb.energy) + " max:" + string(orb.max_energy));
                            }
                            else
                            {
                                //my_console_log("Bot "+ string(my_player.number) + " avoided color c:" + string(new_color));
                            }
                        }
                        else
                        {
                            orb = noone;
                            if(instance_exists(charge_ball))
                            {
                                for(chbi = charge_ball.orb_count-1; chbi >= 0; chbi--)
                                {
                                    orb = charge_ball.orbs[| chbi];
                                    if(instance_exists(orb) && orb.my_color == new_color)
                                    {
                                        if(orb.energy < (orb.max_energy - 3*channel_maxboost))
                                        {
                                            ds_list_add(new_colors, new_color);
                                            self.auto_chosen_orbs = true;
                                            //my_console_log("Bot "+ string(my_player.number) + " added color from chargeball c:" + string(new_color) + " e:" + string(orb.energy) + " max:" + string(orb.max_energy));
                                        }
                                        else
                                        {
                                            //my_console_log("Bot "+ string(my_player.number) + " avoided color c:" + string(new_color));
                                            continue;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            next_phase = phase + 1;
        
            if(total_orb_extra_energy >= (self.max_channeled_energy - 3*channel_maxboost))
            {
                //my_console_log("Bot "+ string(my_player.number) + " interrupted channeling - extra total");
                wanna_channel = false;
                next_phase = 0;
            }
        
            if(wanna_channel)
            {
                for(i = 0; i < slot_number; i++)
                {
                    var orb = color_slots[| i];
                    if(orb.energy >= (orb.max_energy - 3*channel_maxboost))
                    {
                        //my_console_log("Bot "+ string(my_player.number) + " interrupted channeling c:" + string(orb.my_color));
                        wanna_channel = false;
                        next_phase = 0;
                    }
                }
            }
        
            if(phase >= (round(10/bot_speed) + last_phase))
            {
                next_phase = 0;
            }
        }

    
        // TRY TO PREVENT FALLING OUT OF ARENA - USE FLASHBACK OR BASE TP WHEN FALLING
        if(near_room_edge && mod_get_state("abilities")
        && ( (has_level(id, "rewind", 1) && abi_cooldown[? g_dark] == 0)
            || (!lost_control && has_level(id, "base_teleport", 1) && abi_cooldown[? g_white] == 0) ))
        {
            next_phase = 2;
        }
    
        if(use_abi)
        {
            //show_debug_message("AB 2, P 3: slots_triggered=" + string(slots_triggered) + " casting=" + string(casting));
            if(!self.slots_triggered && !self.casting)
            {
                //show_debug_message("AB 2, P 3: potential_color=" + string(potential_color) + " current_slot=" + string(current_slot));
                //show_debug_message("AB 2, P 3: channeling=" + string(channeling) + " wanna_cast=" + string(wanna_cast));
                
                if((my_color == abi_color && current_slot == 0) || (potential_color == abi_color && current_slot > 0))
                {
                    wanna_abi = true;
                }
                else if(current_slot > 0 && !channeling)
                {
                    if(!holding_wall && !wanna_cast)
                    {
                        wanna_channel = true;
                    }
                }
                else
                {
                    var col;
                
                    for(col = g_red; col <= g_blue; col++)
                    {
                        if(col == g_yellow)
                            continue;
                    
                        if(abi_color & col)
                        {
                            if(ds_list_find_index(new_colors, col) == -1)
                            {
                                ds_list_add(new_colors, col);
                                self.auto_chosen_orbs = true;
                            }
                        }
                    }
                }
                
                //show_debug_message("AB 2, P 3: wanna_abi=" + string(wanna_abi) + " wanna_channel=" + string(wanna_channel));
            }   
        }
    
            
        // SELF SUSTAIN
        /*
        var sust_coef = 1;
        if(difficulty < 1)
        {
            sust_coef = difficulty;
        }
        else if(difficulty > 1)
        {
            sust_coef = sqr(difficulty);
        }
    
        if(step_count mod sustain_tick_time == 0 && random(20/sust_coef) < 1)
        {
            var batt = instance_create(x,y, orb_battery_obj);
            batt.my_guy = id;
            with(batt)
            {
                event_perform(ev_other, ev_user1);
                instance_destroy();
            }
        }
        */
    
        // MOVEMENT
        /*
        if((step_count - last_direction_change) > direction_change_min_time
        && step_count mod direction_change_min_time == 0)
        {
            looking_up = false;
            looking_down = false;
            desired_aim_dir = 0;
            desired_aim_dist = 0;
        
            // TRY TO AIM AT PLAYER     
            if(instance_exists(near_player))
            {
                facing_right = !!(sign(near_player.x - x));
                if(random(2/difficulty) < 1) { looking_up = (y - near_player.y) > 48; }
                if(random(2/difficulty) < 1) { looking_down = (near_player.y - y) > 48; }
                last_direction_change = step_count;
            
                if(pl_dist < attack_min_range)
                {
                    self.wanna_run = false;
                    self.wanna_look = true;
                }
            
                desired_aim_dir = point_direction(x,y, near_player.x, near_player.y);
                desired_aim_dist = 1;
            }
        
            // RANDOM AIM VS RUN
            if(random(3) < 1)
            {
               self.wanna_run = false;
               self.wanna_look = true;
            }
        
            if(random(3) < 1)
            {
               self.wanna_run = true;
               self.wanna_look = false;
            }
        
            // RANDOM JUMPING
            if(!self.wanna_cast && random(2/difficulty) < 1)
            {
               self.wanna_jump = !self.wanna_jump;
            }
        
        
        
        }
        */
    
        // WALL HOLD FIX
        if(holding_wall || climbing_up)
        {
            wanna_channel = false;
        }
    

        // FIND TARGET    
        var waypoint = noone, waypoints;
        var attack_target = noone;
        var move_target = noone;
        ds_list_clear(attack_targets);
    
        if(instance_exists(near_player))
        {
            if(near_player.dead)
            {
                waypoint = find_nearest_visible_waypoint("move");
                attack_mode = false;
            }   
        
            if(!near_player.dead && !near_player.invisible)
            {
                if(!npc_wanna_shield && instance_exists(charge_ball))
                {
                    attack_mode = true;
                    desired_aim_dir = point_direction(x,y, near_player.x, near_player.y);
                    desired_aim_dist = 1;

                    if(status_left[? "confusion"] > 0 && !npc_counter_confusion)
                    {
                        //desired_aim_dir += random(360);
                        desired_aim_dir = point_direction(0,0, -lengthdir_x(desired_aim_dir, 1), lengthdir_y(desired_aim_dir, 1))
                    }
                
                    // THROW GRENADE
                    if(self.attack_target == near_player && (pl_dist < 100 || (held_item[? 2] != noone && pl_dist < 200)))
                    {
                        if(held_item[? 2] != noone)
                        {
                            if(npc_line_of_sight(near_player.x, near_player.y, "move")
                            && abs(angle_difference(point_direction(0, 0, charge_ball.rel_x, charge_ball.rel_y), desired_aim_dir)) < 1)
                            {
                                stop_holding[? 2] = true;
                            }
                        }
                        else
                        {
                            use_inv_item(2);   
                        }
                    }
                
                    attack_target = near_player;
                    ds_list_add(attack_targets, attack_target);
                }
            
                with(near_player)
                {
                    waypoint = find_nearest_visible_waypoint("attack");
                }
            
                if(!instance_exists(npc_waypoint_obj))
                {
                    npc_destination_reached = false;
                    npc_destination_x = near_player.x;
                    npc_destination_y = near_player.y;
                    npc_waypoint_x = near_player.x;
                    npc_waypoint_y = near_player.y;
                    npc_destination = near_player;
                }
            }
        }
        else
        {
            waypoint = find_nearest_visible_waypoint("move");
            attack_mode = false;   
        }
    
        if(!attack_mode || npc_wanna_shield)
        {
            //hor_dir_held = false;
            desired_aim_dir = 0;
            desired_aim_dist = 0;   
        }
    
        if(!npc_wanna_shield)
        {
            // DESTROY SPAWNER
            var enemy_spawner = noone;
            var nearest_distance = 0, dist;
            with(guy_spawner_obj)
            {
                dist = point_distance(x,y, other.x, other.y);
                if(my_player != other.my_player && !invisible && holographic == other.holographic)
                {
                    var nearest = false;
                    if(enemy_spawner == noone || dist < nearest_distance)
                    {
                        nearest = true;
                    }
                
                    if(nearest)
                    {
                        enemy_spawner = id;
                        nearest_distance = dist;
                    }
                }
            }
        
            if(instance_exists(enemy_spawner) && nearest_distance < pl_dist && nearest_distance < 240)
            {
                with(enemy_spawner)
                {
                    waypoint = find_nearest_visible_waypoint("attack");
                }
                desired_aim_dir = point_direction(x,y, enemy_spawner.x, enemy_spawner.y);

                if(status_left[? "confusion"] > 0 && !npc_counter_confusion)
                {
                    desired_aim_dir = random(360);
                }

                desired_aim_dist = 1;  
        
                attack_target = enemy_spawner;
                ds_list_add(attack_targets, attack_target);
        
                attack_mode = true;
            }
    
            // DESTROY TURRETS
            var enemy_turret = noone;
            var nearest_distance = 0, dist;
            with(turret_obj)
            {
                dist = point_distance(x,y, other.x, other.y);
                if(my_player != other.my_player && !invisible && holographic == other.holographic)
                {
                    var nearest = false;
                    if(enemy_turret == noone || dist < nearest_distance)
                    {
                        nearest = true;
                    }
                
                    if(nearest)
                    {
                        enemy_turret = id;
                        nearest_distance = dist;
                    }
                }
            }
        
            if(instance_exists(enemy_turret) && (nearest_distance < (pl_dist-64) || attack_target == noone) && nearest_distance < 280)
            {
                var block = noone;
        
                if(instance_exists(enemy_turret.my_block))
                {
                    block = enemy_turret.my_block;
                }

                if(instance_exists(block))
                {
                    with(block)
                    {
                        waypoint = find_nearest_visible_waypoint("attack");
                    }
                    desired_aim_dir = point_direction(x,y, block.x + 15, block.y + 15);

                    if(status_left[? "confusion"] > 0 && !npc_counter_confusion)
                    {
                        desired_aim_dir = random(360);
                    }

                    desired_aim_dist = 1;  
        
                    attack_target = enemy_turret;
                    ds_list_add(attack_targets, attack_target);
        
                    attack_mode = true;
                }
            }
        
        
            // SHOOT CLOSED GATES (only VERTICAL)
            // TODO: why it's not working?? wrong priority? problem with sight still not fixed?
            var target_gate = noone, nearest_distance = 0, gate_fields = find_nearest_instances(id, gate_field_obj);
            var i, result, field, gate1, gate2, gate1_valid, gate2_valid, dist1, dist2, count = ds_list_size(gate_fields);
        
            for(i=0; i < count; i++)
            {
                result = gate_fields[| i];
                field = result[? "id"];
            
                if(field.vertical)
                {
                    gate1_valid = false;
                    gate2_valid = false;
                    gate1 = field.my_gates[? 1];
                    gate2 = field.my_gates[? 3];
                
                    dist1 = point_distance(x,y, gate1.x, gate1.y);
                    dist2 = point_distance(x,y, gate2.x, gate2.y);
                
                    if(instance_exists(gate1.my_block))
                    {
                        if(gate1.my_block.object_index == wall_obj)
                        {
                            gate1_valid = true;   
                        }
                    }
                
                    if(instance_exists(gate2.my_block))
                    {
                        if(gate2.my_block.object_index == wall_obj)
                        {
                            gate2_valid = true;   
                        }
                    }
                
                    if(dist1 < dist2 && gate1_valid)
                    {
                        if(target_gate == noone || dist1 < nearest_distance)
                        {
                            target_gate = gate1;
                            nearest_distance = dist1;
                        }
                    }
                    else if(gate2_valid)
                    {
                        if(target_gate == noone || dist2 < nearest_distance)
                        {
                            target_gate = gate2;
                            nearest_distance = dist2;                        
                        }
                    }
                }
            }
        
            if(instance_exists(target_gate)
            && (nearest_distance < (pl_dist + 64) || attack_target == noone) && nearest_distance < 280)
            {
                var block = noone;
        
                if(instance_exists(target_gate.my_block))
                {
                    block = target_gate.my_block;
                
                    desired_aim_dir = point_direction(x,y, block.x + 15, block.y + 15);

                    if(status_left[? "confusion"] > 0 && !npc_counter_confusion)
                    {
                        desired_aim_dir = random(360);
                    }

                    desired_aim_dist = 1;  
        
                    attack_target = block;
                    ds_list_add(attack_targets, attack_target);
        
                    attack_mode = true;
                }
            }
    
    
            // SHOOT ITEM SPAWNER
            var item_spawner = noone;
            var nearest_distance = 0, dist;
            with(item_spawner_obj)
            {
                dist = point_distance(x,y, other.x, other.y);
        
                var nearest = false;
                if((item_spawner == noone || dist < nearest_distance) && !invisible && holographic == other.holographic)
                {
                    nearest = true;
                }
                
                if(nearest)
                {
                    item_spawner = id;
                    nearest_distance = dist;
                }
            }
    
            //if(instance_exists(item_spawner) && nearest_distance < ((pl_dist-(160 * clamp(2*charge_ball.orb_exhaustion_ratio -1, -1, 1)) || attack_target == noone)) && nearest_distance < 96 * clamp(1/charge_ball.orb_exhaustion_ratio, 1, 3))
            if(instance_exists(item_spawner) && instance_exists(charge_ball)
            && (nearest_distance < (pl_dist - 160) || attack_target == noone)
            && nearest_distance < clamp(96/charge_ball.orb_exhaustion_ratio, 96, 240))
            {
                var block = noone;
        
                if(instance_exists(item_spawner.my_block))
                {
                    block = item_spawner.my_block;
                }

                if(instance_exists(block))
                {
                    desired_aim_dir = point_direction(x,y, block.x + 15, block.y + 15);

                    if(status_left[? "confusion"] > 0 && !npc_counter_confusion)
                    {
                        desired_aim_dir = random(360);
                    }

                    desired_aim_dist = 1;  
        
                    attack_target = item_spawner;
                    ds_list_add(attack_targets, attack_target);
        
                    attack_mode = true;
                }
            }
        }
    
    
        // MOVE TARGET RESETS
        if(npc_stuck)
        {
            self.move_target = noone;
        }
    
        var move_dist;
        if(instance_exists(self.move_target))
        {
            move_dist = point_distance(x,y, self.move_target.x, self.move_target.y);
        }
    
        // MOVE TARGET
        if((!instance_exists(self.move_target) || move_dist > 960 || move_dist > pl_dist)) //  && self.move_target != my_spawner
        {
            // COLLECT HEALTH KITS
            if(move_target == noone && (damage - min_damage) > 1)
            {
                var near_health = noone;
                var nearest_distance = 0, dist;
                with(health_obj)
                {
                    dist = point_distance(x,y, other.x, other.y);
                    if(my_player != other.my_player && (for_player == -1 || for_player == other.my_player.number))
                    {
                        var nearest = false;
                        if(near_health == noone || dist < nearest_distance)
                        {
                            nearest = true;
                        }
                
                        if(nearest && !invisible && holographic == other.holographic)
                        {
                            near_health = id;
                            nearest_distance = point_distance(x,y, other.x, other.y);
                        }
                    }
                }
        
                if(instance_exists(near_health) && nearest_distance < pl_dist && nearest_distance < 640)
                {
                    with(near_health)
                    {
                        waypoint = find_nearest_visible_waypoint("move");
                        if(waypoint != noone)
                        {
                            move_target = id;
                        }
                    }
                }
            }
    
    
            // COLLECT BATTERIES
            if(move_target == noone && instance_exists(charge_ball))
            {
                var near_battery = noone;
                var nearest_distance = 0, dist;
                with(orb_battery_obj)
                {
                    if(my_player != other.my_player && (for_player == -1 || for_player == other.my_player.number) && !invisible && holographic == other.holographic)
                    {
                        dist = point_distance(x,y, other.x, other.y);
                    
                        var nearest = false;
                        if(near_battery == noone || dist < nearest_distance)
                        {
                            nearest = true;
                        }
                
                        if(nearest)
                        {
                            near_battery = id;
                            nearest_distance = point_distance(x,y, other.x, other.y);
                        }
                    }
                }
        
                if(instance_exists(near_battery) && (nearest_distance < pl_dist/charge_ball.orb_exhaustion_ratio)
                && nearest_distance < 640 * clamp(1/charge_ball.orb_exhaustion_ratio, 1, 2))
                {
                    with(near_battery)
                    {
                        waypoint = find_nearest_visible_waypoint("move");
                        if(waypoint != noone)
                        {
                            move_target = id;
                        }
                    }
                }
            }
        
        
            // COLLECT GRENADES
            var grenades = find_in_inventory(emp_grenade_obj);
            if(instance_exists(grenades))
            {
                var grenade_space = grenades.max_stack_size - grenades.stack_size;
        
                if(move_target == noone && grenade_space > 0)
                {
                    var near_grenade = noone;
                    var nearest_distance = 0, dist;
                    with(emp_grenade_obj)
                    {
                        if(my_player != other.my_player && (for_player == -1 || for_player == other.my_player.number)
                        && !collected && !used && !invisible && holographic == other.holographic)
                        {
                            dist = point_distance(x,y, other.x, other.y);
                        
                            var nearest = false;
                            if(near_grenade == noone || dist < nearest_distance)
                            {
                                nearest = true;
                            }
                
                            if(nearest)
                            {
                                near_grenade = id;
                                nearest_distance = point_distance(x,y, other.x, other.y);
                            }
                        }
                    }
        
                    if(instance_exists(near_grenade) && nearest_distance < pl_dist && nearest_distance < 640)
                    {
                        with(near_grenade)
                        {
                            waypoint = find_nearest_visible_waypoint("move");
                            if(waypoint != noone)
                            {
                                move_target = id;
                            }
                        }
                    }
                }
            }


            // COLLECT CRYSTALS
            /*
            var inventory_space = free_inv_slot_count();
        
            if(move_target == noone && (inventory_space > 0 || crystal_will_be_consumed()))
            {
                var near_crystal = noone;
                var nearest_distance = 0, dist;
                with(crystal_obj)
                {
                    if(my_player != other.my_player && (for_player == -1 || for_player == other.my_player.number)
                    && !collected && !used && !invisible && holographic == other.holographic && !is_shielded(id))
                    {
                        dist = point_distance(x,y, other.x, other.y);
                    
                        var nearest = false;
                        if(near_crystal == noone || dist < nearest_distance)
                        {
                            nearest = true;
                        }
                
                        if(nearest)
                        {
                            near_crystal = id;
                            nearest_distance = point_distance(x,y, other.x, other.y);
                        }
                    }
                }
        
                if(instance_exists(near_crystal) && nearest_distance < pl_dist && nearest_distance < 640)
                {
                    with(near_crystal)
                    {
                        waypoint = find_nearest_visible_waypoint("move");
                        if(waypoint != noone)
                        {
                            move_target = id;
                        }
                    }
                }
            }
            */
        
            self.move_target = move_target;
        }
    
        // GO TO BASE
        // if (you have crystals in inventory OR (your health is low AND there are already crystals at base)) - see condition in support abi phase (3)
        /*
        var crystal = find_in_inventory(crystal_obj);
        if(!npc_stuck && 
            (instance_exists(crystal)
            || (base_has_crystals() && (damage > (hp - min_damage)/2 || (hp - min_damage) < 5))))
        {
            self.move_target = my_spawner;
        }
        */
    
    
        if(instance_exists(self.move_target))
        {
            // GO TO MOVE TARGET
            if(npc_destination != self.move_target)
            {
                npc_destination = self.move_target;
                npc_final_waypoint = waypoint.waypoint_id;
            }
        
            //npc_waypoint_reached = false;
            npc_destination_reached = false;
            npc_destination_x = self.move_target.x;
            npc_destination_y = self.move_target.y;
        }
        else if(instance_exists(waypoint))
        {
            // KEEP DISTANCE FROM ATTACK TARGET
            if(move_target == noone && instance_exists(attack_target) && attack_target.object_index != item_spawner_obj)
            {
                waypoints = find_nearest_instances(attack_target, npc_waypoint_obj, 480, "visible", "attack");
                var count = ds_list_size(waypoints), i, result, wp;
                var att_dist = point_distance(x,y, attack_target.x, attack_target.y);

                for(i=count-1; i>=0; i--)
                {
                    result = waypoints[| i];
                    wp = result[? "id"];
                    
                    if(instance_exists(wp) && !(wp.airborne || wp.wallclimb_point || wp.walljump_point || wp.dive_point)
                    && result[? "distance"] < (att_dist + 160)
                    && npc_line_of_sight(wp.x, wp.y, "move"))
                    {
                        waypoint = wp;
                        break;
                    }
                }

                // debug
                with(guy_obj)
                {
                    ds_list_clear(attack_waypoints);
                }
            
                if(object_is_child(near_player, guy_obj))
                {
                    for(i=0; i < count; i++)
                    {
                        wp = waypoints[| i];
                        near_player.attack_waypoints[| i] = wp[? "id"];
                    }
                }
            }
        
            // GO TO WAYPOINT
            if(npc_final_waypoint != waypoint.waypoint_id)
            {
                npc_final_waypoint = waypoint.waypoint_id;

                npc_destination_reached = false;
                npc_destination_x = waypoint.x;
                npc_destination_y = waypoint.y;
                npc_destination = waypoint;
            }
        }
        
        npc_guy2_step();
    
        prev_phase = phase;
    
        if(!npc_active)
        {
            //self.hor_dir_held = false;
            self.wanna_cast = false;
            self.wanna_run = false;
            self.wanna_look = false;
            self.wanna_jump = false;
            self.wanna_abi = false;
            self.looking_up = false;
            self.looking_down = false;
            
            next_phase = 0;
            phase = -1;
        }
    
        prev_phase = phase;
    
        self.attack_target = attack_target;
    
        if(DB.console_mode == "debug")
        {
            var att_name = "", move_name = "";
            if(instance_exists(self.attack_target))
            {
                att_name = self.attack_target.name;
            }
            if(instance_exists(self.move_target))
            {
                move_name = self.move_target.name;
            }
        
            name = "P: " + string(phase) + " " + string(next_phase) + "AT:" + att_name + " WP:" + npc_final_waypoint + " MO:" + move_name;
            //name = string(phase) + " " + string(next_phase) + " A:" + string(airborne) + " S:" + string(npc_stuck) + " NJ:" + string(npc_wanna_jump) + " J:" + string(wanna_jump) + " DJ:" + string(is_doublejumping) + " CA:" + string(wanna_cast);
            //name = string(phase) + " " + string(next_phase) + " C:" + string(status_left[? "confusion"] > 0) + " CC:" + string(npc_counter_confusion);
        }
        else
        {
            name = my_player.name;
        }
    }
}
