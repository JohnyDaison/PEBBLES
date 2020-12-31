if(step_count mod 60 == 0)
{
    garbage_collector();
}

if(room != match_summary && (!paused || has_unpaused))
{
    step_count += 1;
}

// OCTARINE VALUE
octarine_tint = make_colour_hsv(singleton_obj.step_count*4 mod 256, 196, 255);

// SOUND VOLUME BALANCING
if(step_count mod 20 == 0)
{
    var diff;
    
    // SHOTS AND IMPACTS
    var ideal_shot_volume = 1 - min(1,shots_buffer/14) * balance_range;
    diff = ideal_shot_volume - shot_volume;
    if(abs(diff) >= balance_step)
        shot_volume += sign(diff)*balance_step;
    shots_buffer = 0;
    
    audio_sound_gain(shot1_sound, 0.6*shot_volume, 0);
    audio_sound_gain(shot_bounce_sound, 0.2*shot_volume, 0);
    audio_sound_gain(shot_wallhit_sound, 0.3*shot_volume, 0);
    audio_sound_gain(impact_sound, 0.7*shot_volume, 0);
    

    // GUY WALL HITS
    var ideal_wallhit_volume = 1 - min(1,wallhit_buffer/4) * balance_range;
    
    /*
    diff = ideal_shot_volume - wallhit_volume;
    if(abs(diff) >= balance_step)
        wallhit_volume += sign(diff)*balance_step;
        */
    wallhit_volume = ideal_wallhit_volume;  
    wallhit_buffer = 0;
    
    audio_sound_gain(hit_ground_sound, 0.5*wallhit_volume, 0);
    audio_sound_gain(guy_bounce_sound, 0.9*wallhit_volume, 0);
    
    // WALL/FIELD HUM
    var ideal_wallhum_volume = 1 - min(1, wallhum_buffer/18) * balance_range;
    diff = ideal_wallhum_volume - wallhum_volume;
    if(abs(diff) >= balance_step)
        wallhum_volume += sign(diff)*balance_step;
    wallhum_buffer = 0;
    
    audio_sound_gain(wall_hum_sound, 0.7*wallhum_volume, 0);
    
    
    // SHIELD HITS
    var ideal_shieldhit_volume = 1 - min(1, shieldhit_buffer/12) * balance_range;
    diff = ideal_shieldhit_volume - shieldhit_volume;
    
    if(abs(diff) >= balance_step)
    {
        shieldhit_volume += sign(diff)*balance_step;
    }
    else
    {
        shieldhit_volume = ideal_shieldhit_volume;
    }    
    
    if(step_count mod 5 == 0)
    {
        shieldhit_buffer = max(0, shieldhit_buffer-1);
    }
    
    audio_sound_gain(shield_hit_sound, 0.75*shieldhit_volume, 0);
}

// TERRAIN PLACEMENT ERROR - DISABLE IN RELEASE
if(DB.console_mode == "debug" && step_count mod 120 == 0)
{
    with(terrain_obj)
    {
        if(error_placement)
        {
            i = instance_create(x+15,y+15,text_popup_obj);
            i.str = "OVERLAP!";
            i.my_color = g_red;
            i.tint = c_orange;
            i.tint_updated = true;
        }
        
        if(aligned_x != x || aligned_y != y)
        {
            i = instance_create(x+15,y+15,text_popup_obj);
            i.str = "ALIGN!";
            i.my_color = g_red;
            i.tint = c_orange;
            i.tint_updated = true;
        }
    }
}

// BACKGROUND TINT
if(self.bgcolor_updated == false)
{
    __background_set_colour( merge_color(__background_get_colour( ),self.new_background_color,1/6 ));

    if(__background_get_colour( ) == self.new_background_color)
    {
        self.bgcolor_updated = true;
    }
}
 
// CHECK FOR CONTROL SEQUENCES

// OVERLAYS

// ~
if(keyboard_check_pressed(192))
{
    switch(show_console)
    {
        case "hide":
            show_console = "peek";
            break;
        case "peek":
            show_console = "normal";
            break;
        case "normal":
            show_console = "full";
            break;
        case "full":
            show_console = "hide";
            break;
    }
}

if(DB.console_mode == "debug" || DB.console_mode == "test")
{

    // CTRL + F
    if(keyboard_check(vk_control) && keyboard_check_pressed(ord("F")))
    {
        self.show_fps = !self.show_fps; 
    }


    // CTRL + K
    if(keyboard_check(vk_control) && keyboard_check_pressed(ord("K")))
    {
        //self.show_keyboard_state = !self.show_keyboard_state; 
        var xx = (cursor_obj.room_x div 32)*32;
        var yy = (cursor_obj.room_y div 32)*32;
        var ter = instance_position(xx,yy, wall_obj);
        if(instance_exists(ter))
        {
            with(ter)
            {
                color_locked = !color_locked;
            }
        }
    }


    // CTRL + J
    if(keyboard_check(vk_control) && keyboard_check_pressed(ord("J")))
    {
        self.show_joystick_state = !self.show_joystick_state; 
    }

    // CTRL + M
    if(keyboard_check(vk_control) && keyboard_check_pressed(ord("M")))
    {
        self.show_colorimatrix = !self.show_colorimatrix; 
    }

    // CTRL + T
    if(keyboard_check(vk_control) && keyboard_check_pressed(ord("T")))
    {
        //self.show_terrain = !self.show_terrain;
        if(instance_exists(gamemode_obj))
        {
            var player = gamemode_obj.players[? cursor_obj.my_color];
            
            if(!is_undefined(player))
            {
                var guy = player.my_guy;
                if(instance_exists(guy))
                {
                    guy.pre_tp_x = guy.x;
                    guy.pre_tp_y = guy.y;
                    guy.x = cursor_obj.room_x;
                    guy.y = cursor_obj.room_y;
                    guy.has_tped = true;
                }
            }
        }
    }

    // ALT + M
    if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("M")))
    {
        self.show_minimap = !self.show_minimap;
    }

    // CTRL + C
    if(keyboard_check(vk_control) && keyboard_check_pressed(ord("C")))
    {
        self.show_chunkgrid = !self.show_chunkgrid;
    }


    // ALT + L
    if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("L")))
    {
        draw_object_labels = !draw_object_labels;
    }

    // CTRL + L
    if(keyboard_check(vk_control) && keyboard_check_pressed(ord("L")))
    {
        draw_lights = !draw_lights;
    }

    if(instance_exists(gamemode_obj))
    {
        // KILL NPCs
        // CTRL + N
        if(keyboard_check(vk_control) && keyboard_check_pressed(ord("N")))
        {
            with(guy_obj)
            {
                 if(my_player.number < 1 && point_distance(x,y,cursor_obj.room_x,cursor_obj.room_y) < 30)
                 {
                     instance_destroy();
                 }
            }
        }
        
        // LOSE CONTROL
        // ALT + C
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("C")))
        {
            with(guy_obj)
            {
                 if(point_distance(x,y,cursor_obj.room_x,cursor_obj.room_y) < 30)
                 {
                     front_hit = true;
                     lost_control = true;
                 }
            }
        }
    
        // DROP WALLS
        // ALT + D
        if(keyboard_check(vk_alt) && keyboard_check(ord("D")))
        {
            with(terrain_obj)
            {
                 if(point_distance(x+16,y+16,cursor_obj.room_x,cursor_obj.room_y) < 32)
                 {
                     falling = true;
                 }
            }
        }
    
        // DESTROY WALLS
        // ALT + W    
        if(keyboard_check(vk_alt) && keyboard_check(ord("W")))
        {
            with(wall_obj)
            {
                 if(point_distance(x+16,y+16,cursor_obj.room_x,cursor_obj.room_y) < 64 && damage < hp)
                 {
                     damage += 0.1;
                 }
            }
        }
    
        // ERASE WALLS AND PLATFORMS
        // CTRL + E
        if(keyboard_check(vk_control) && keyboard_check(ord("E")))
        {
            var xx = (cursor_obj.room_x div 32)*32;
            var yy = (cursor_obj.room_y div 32)*32;
            var ter = instance_position(xx,yy, terrain_obj);
            if(instance_exists(ter))
            {
                with(ter)
                {
                    done_for = true;
                    cancelled = true;
                    event_perform(ev_step, ev_step_end);
                    instance_destroy();
                }
            }
            
            /*
            var xx = (cursor_obj.room_x div 32)*32;
            var yy = (cursor_obj.room_y div 32)*32;
            var structure = instance_position(xx,yy, perma_wall_structure_obj);
            if(instance_exists(structure))
            {
                with(structure)
                {
                    done_for = true;
                    cancelled = true;
                    event_perform(ev_step, ev_step_end);
                    instance_destroy();
                }
            }
            */
        
            var xx = (cursor_obj.room_x div 16)*16;
            var yy = (cursor_obj.room_y div 16)*16;
            var plat = instance_position(xx,yy, platform_obj);
            if(instance_exists(plat))
            {
                with(plat)
                {
                    instance_destroy();
                }
            }
        }
    
        // CREATE SLOT EXPLOSION
        // ALT + E
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("E")))
        {
            if(cursor_obj.my_color == g_black)
            {
                i = instance_create(cursor_obj.room_x, cursor_obj.room_y, black_aoe_obj);
                i.force = 1;
                i.my_guy = i.id;
            }
            else
            {
                i = instance_create(cursor_obj.room_x, cursor_obj.room_y, slot_explosion_obj);
                i.my_color = cursor_obj.my_color;
                i.my_guy = i.id;
            }
        }
        
        // CREATE LIGHTNING STRIKE
        // ALT + N
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("N")))
        {
            i = instance_create(cursor_obj.room_x, cursor_obj.room_y, lightning_strike_obj);
            i.my_color = max(g_red, cursor_obj.my_color);
            i.my_guy = i.id;
            i.image_yscale = (cursor_obj.room_y+256)/16;
        }
        
        // CREATE SMOKE
        // ALT + G
        if(keyboard_check(vk_alt) && keyboard_check(ord("G")) && step_count mod 5 == 0)
        {
            i = instance_create(cursor_obj.room_x, cursor_obj.room_y, energy_smoke_obj);
            i.my_guy = i.id;
            i.force = 0.05;
            i.max_force = i.force;

            i.direction = random(360);
            i.speed = 3;
    
            i.my_color = g_octarine;
            i.tint_updated = false;
        }
    
        // RESTART
        // CTRL + R
        if(keyboard_check(vk_control) && keyboard_check_pressed(ord("R")))
        {
            gamemode_obj.restart_match = true;
        }
    
        // MAKE OCTARINE
        // ALT + O
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("O")))
        {
            i = instance_nearest(cursor_obj.room_x, cursor_obj.room_y, game_obj);
            if(i.multicolor)
            {
                i.my_color = g_octarine;
                i.tint_updated = false;
            }
        }
    
        // SWITCH INVISIBLE
        // ALT + I
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("I")))
        {
            i = instance_nearest(cursor_obj.room_x, cursor_obj.room_y, game_obj);
            i.invisible = !i.invisible;
            i.tint_updated = false;
        }
    
        // SWITCH HOLOGRAPHIC
        // ALT + H
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("H")))
        {
            i = instance_nearest(cursor_obj.room_x, cursor_obj.room_y, game_obj);
            if(i.holo_alpha != -1)
            {
                i.holographic = !i.holographic;
                if(!i.holographic)
                {
                    i.holo_alpha = 1;
                }
            }
        }
    
        // CREATE ORB
        // CTRL + O
        if(keyboard_check(vk_control) && keyboard_check_pressed(ord("O")))
        {
            i = instance_create(cursor_obj.room_x,cursor_obj.room_y, color_orb_obj);
            i.my_guy = i.id;
            i.airborne = true;
            i.color_added = true;
            i.my_color = cursor_obj.my_color;
            i.tint_updated = false;
        }
    
        // CREATE SPRINKLER
        // ALT + K
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("K")))
        {
            instance_create(cursor_obj.room_x,cursor_obj.room_y, sprinkler_body_obj);
        }
        
        // CREATE SPITTER
        // ALT + P
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("P")))
        {
            instance_create(cursor_obj.room_x,cursor_obj.room_y, spitter_body_obj);
        }
    
        // CREATE SPRINKLER SHIELD
        // CTRL + D
        if(keyboard_check(vk_control) && keyboard_check_pressed(ord("D")))
        {
            instance_create(cursor_obj.room_x,cursor_obj.room_y, sprinkler_shield_obj);
        }
    
        // CREATE BOT GUY
        // CTRL + B
        if(keyboard_check(vk_control) && keyboard_check_pressed(ord("B")))
        {
            i = instance_create(cursor_obj.room_x, cursor_obj.room_y, basic_bot); 
            with(i)
            {
                //sparring_bot1_init();
                //npc_script = sparring_bot1;
            
                if(instance_exists(place_controller_obj) && place_controller_obj.nav_graph_exists)
                {
                    arena_bot3_init();
                    npc_script = arena_bot3;
                    npc_destroy_script = arena_bot3_destroy;
                }
                else
                {
                    arena_bot1_init();
                    npc_script = arena_bot1;
                }
            
                // difficulty = 1;
            
                var player = gamemode_obj.players[? cursor_obj.my_color];
            
                if(!is_undefined(player))
                {
                    my_player = player;
                }
            }
        }
    
        // CREATE SLIME MOB
        // ALT + B
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("B")))
        {
            i = instance_create(cursor_obj.room_x, cursor_obj.room_y, slime_mob_obj);
            i.my_color = irandom_range(g_red, g_white);
            i.tint_updated = false;
            if(cursor_obj.my_color == g_black)
            {
                i.energy = 0.0001;   
            }
            else if(cursor_obj.my_color == g_octarine)
            {
                i.energy = i.max_energy - i.touch_damage;   
            }
        }
    
        // CREATE SNAKE
        // CTRL + S
        if(keyboard_check(vk_control) && keyboard_check_pressed(ord("S")))
        {
            var xx = (cursor_obj.room_x div 32)*32;
            var yy = (cursor_obj.room_y div 32)*32;
            var ter = instance_position(xx,yy, terrain_obj);
            var snake = instance_position(xx,yy, snake_mob_obj);
            if(!instance_exists(snake))
            {
                if(instance_exists(ter) && ter.object_index == wall_obj && ter.cover != cover_indestr)
                {
                    instance_create(xx,yy, snake_mob_obj);
                }
            }
        }
    
        // CREATE STAR
        // ALT + S
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("S")))
        {
            i = instance_create(cursor_obj.room_x,cursor_obj.room_y,star_core_obj);
            i.my_guy = i.id;
            if(cursor_obj.my_color > g_black)
            {
                i.my_color = cursor_obj.my_color;
            }
        }
    
        // CREATE WALL
        // CTRL + W
        if(keyboard_check(vk_control) && keyboard_check(ord("W")))
        {
            var xx = (cursor_obj.room_x div 32)*32;
            var yy = (cursor_obj.room_y div 32)*32;
            var ter = instance_position(xx,yy, terrain_obj);
            if(!instance_exists(ter))
            {
                instance_create(xx,yy, wall_obj);
            }
        }
    
        // CREATE ARMORED WALL
        // CTRL + A
        if(keyboard_check(vk_control) && keyboard_check(ord("A")))
        {
            var xx = (cursor_obj.room_x div 32)*32;
            var yy = (cursor_obj.room_y div 32)*32;
            var ter = instance_position(xx,yy, terrain_obj);
            if(!instance_exists(ter))
            {
                var i = instance_create(xx,yy, wall_obj);
                i.cover = cover_indestr;
            }
        }
    
        // CREATE INDESTRUCTIBLE WALL
        // CTRL + I
        if(keyboard_check(vk_control) && keyboard_check(ord("I")))
        {
            var xx = (cursor_obj.room_x div 32)*32;
            var yy = (cursor_obj.room_y div 32)*32;
            var ter = instance_position(xx,yy, terrain_obj);
            if(!instance_exists(ter))
            {
                instance_create(xx,yy, perma_wall_obj);
            }
        }
    
        // CREATE GRATE
        // CTRL + G
        if(keyboard_check(vk_control) && keyboard_check(ord("G")))
        {
            var xx = (cursor_obj.room_x div 32)*32;
            var yy = (cursor_obj.room_y div 32)*32;
            var ter = instance_position(xx,yy, terrain_obj);
            if(!instance_exists(ter))
            {
                instance_create(xx,yy, grate_block_obj);
            }
        }
    
        // CREATE PLATFORM
        // CTRL + P
        if(keyboard_check(vk_control) && keyboard_check(ord("P")))
        {
            var xx = (cursor_obj.room_x div 16)*16;
            var yy = (cursor_obj.room_y div 16)*16;
            var ter = instance_position(xx,yy, platform_obj);
            if(!instance_exists(ter))
            {
                instance_create(xx,yy, platform_obj);
            }
        }
    
        // CREATE ITEM AT CURSOR
        // ALT + T
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("T")))
        {
            var item = noone; 
            switch(cursor_obj.my_color)
            {
                case 0: 
                    item = choose(health_obj, emp_grenade_obj, spraycan_item_obj,
                                crystal_obj, orb_battery_obj, tp_rush_obj);
                    break;
                case 1:
                    item = health_obj;
                    break;
                case 2:
                    item = emp_grenade_obj;
                    break;
                case 3:
                    item = orb_battery_obj;
                    break;
                case 4:
                    item = crystal_obj;
                    break;
                case 5:
                    item = tp_rush_obj;
                    break;
                case 6:
                    item = spraycan_item_obj;
                    break;
                
            }
            if(item != noone)
            {
                instance_create(cursor_obj.room_x, cursor_obj.room_y, item);
            }
        }
        
        // CREATE ABILITY UPGRADE AT CURSOR
        // ALT + Y
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("Y")))
        {
            var item = instance_create(cursor_obj.room_x, cursor_obj.room_y, ability_pickup_obj);
            item.my_color = cursor_obj.my_color;
        }
        
        // CREATE WAYPOINT AT CURSOR
        // ALT + A
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("A")))
        {
            var xx = (cursor_obj.room_x div 16) * 16;
            var yy = (cursor_obj.room_y div 32) * 32;
            instance_create(xx, yy, npc_waypoint_obj);
        }
    
        // CHOOSE PAINT COLOR
        // NUMPAD
        var col;
        for(col = g_black; col<= g_octarine; col++)
        {
            if(keyboard_check_pressed(vk_numpad0+col))
            {
                cursor_obj.my_color = col;
                cursor_obj.tint_updated = false;
            }
        }
    
        // COLORIZE AND (DE-)ENERGIZE
        // MOUSE BUTTONS
        if(mouse_check_button(mb_left) || mouse_check_button(mb_right))
        {
            var energy_incr = 0.01;
            if(keyboard_check(vk_control))
            {
                energy_incr *= 10;
            }
            if(mouse_check_button(mb_right))
            {
                energy_incr *= -1;
            }
    
            // TERRAIN
            var xx = (cursor_obj.room_x div 32)*32;
            var yy = (cursor_obj.room_y div 32)*32;
            var ter = instance_position(xx,yy, wall_obj);
            if(instance_exists(ter))
            {
                if(cursor_obj.my_color != g_black)
                {
                    ter.my_next_color = cursor_obj.my_color;
                }
                if(energy_incr < 0)
                {
                    energy_incr = - min(-energy_incr, ter.energy);
                }
            
                ter.energy += energy_incr;
            
                if(ter.energy == 0)
                {
                    ter.my_next_color = g_black;
                }
            
                create_damage_popup(energy_incr, cursor_obj.my_color, ter.id, "paint_tool");
            }
        
            // NON TERRAIN
        
            var inst = collision_point(cursor_obj.room_x, cursor_obj.room_y, non_terrain_obj, false, false);
            var change_color = false;
            var energy_added = false;
        
            if(instance_exists(inst))
            {
                // CHARGEBALL
                if(inst.object_index == charge_ball_obj)
                {
                    change_color = true;
                
                    inst.charge += energy_incr;
                
                    energy_added = true;
                
                }
                // SHIELD
                else if(inst.object_index == shield_obj)
                {
                    change_color = true;
                
                    inst.charge += energy_incr;
                
                    energy_added = true;
                
                }
                // ORB
                else if(inst.object_index == color_orb_obj)
                {
                    if(inst.my_guy == inst.id)
                    {
                        change_color = true;
                    }
                
                    inst.direct_input_buffer += energy_incr;
                
                    energy_added = true;
                }
                // ITEM
                else if(object_is_ancestor(inst.object_index, item_obj))
                {
                    if(!inst.collected && !inst.invisible)
                    {
                        change_color = true;
                    }
                }
                // SLIME MOB
                else if(inst.object_index == slime_mob_obj)
                {
                    if(cursor_obj.my_color != g_black)
                    {
                        change_color = true;
                    }
                
                    inst.energy += energy_incr;
                
                    energy_added = true;
                }
                // UNI PAD
                else if(inst.object_index == universal_pad_obj)
                {
                    inst.pad_color = cursor_obj.my_color;
                }
            
                if(change_color)
                {
                    inst.my_color = cursor_obj.my_color;
                    inst.tint_updated = false;
                }
            
                if(energy_added)
                {
                    create_damage_popup(energy_incr, cursor_obj.my_color, inst.id, "paint_tool");
                }   
            }
        
        
        
        }

        // SWITCH VIEWS
        // CTRL + V
        if(keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
        {
            if(instance_exists(main_camera_obj)) {
                main_camera_obj.on = !main_camera_obj.on;
            }
        }
    
        // RESTART WITH MATCH LOADOUT
        // ALT + U
        if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("U")))
        {
            if(instance_exists(gamemode_obj)) {
                
                // LOAD MATCH LEVEL CONFIG
                with(gamemode_obj)
                {
                    levels_load_config("match");
                }
                var player = gamemode_obj.players[? 1];
                with(player)
                {
                    init_levels_player();
                }

                gamemode_obj.restart_match = true;
            }
        }
    
        // HIGHLIGHT DATA HOLDERS
        // CTRL + H
        if(keyboard_check(vk_control) && keyboard_check_pressed(ord("H")))
        {
            with(data_holder_obj)
            {
                var camera = instance_nearest(x,y, camera_obj);
                if(instance_exists(camera) && point_distance(x,y, camera.x, camera.y) < 1024)
                {
                    i = instance_create(x,y, text_popup_obj);
                    i.str = object_get_name(transform_memory[? "object_index"]);
                    i.my_color = g_red;
                    i.tint = c_orange;
                    i.tint_updated = true;
                }
            }
        }
    }
}

// TOGGLE OVERLAYS

toggle_frame(fps_overlay, self.show_fps);
//toggle_frame(key_overlay, self.show_keyboard_state);
toggle_frame(joy_overlay, self.show_joystick_state);
toggle_frame(cmatrix_overlay, self.show_colorimatrix);
toggle_frame(terrain_overlay, self.show_terrain);
toggle_frame(chunkgrid_overlay, self.show_chunkgrid);
//toggle_frame(minimap_overlay, self.show_minimap);
if(self.show_console != "hide")
{
    toggle_frame(console_window, true);
}


//show_debug_message("JOY 2 time: "+ string(round((date_current_datetime()-measure_start)*24*360000000)));

// GUI CONTROLS
// TODO: MAKE THIS WORK AND WORK WITH GAMEPADS

if(last_gui_device == keyboard) //  || last_gui_device == joystick
{
    last_gui_device = -1;
}

// DIRECTIONS
gui_dirs[up]    = false;
gui_dirs[down]  = false;
gui_dirs[left]  = false;
gui_dirs[right] = false;

// UP
if(keyboard_check(vk_up) || keyboard_check(ord("W")))
{
    gui_dirs[up] = true;
    last_gui_device = keyboard; 
}
/*
if(joystick1_obj.states[# joy_up,held] || joystick2_obj.states[# joy_up,held])
{
    gui_dirs[up] = true;
    last_gui_device = joystick;    
}
*/

// DOWN
if(keyboard_check(vk_down)  || keyboard_check(ord("S")))
{
    gui_dirs[down] = true;
    last_gui_device = keyboard; 
}
/*
if(joystick1_obj.states[# joy_down,held] || joystick2_obj.states[# joy_down,held])
{
    gui_dirs[down] = true;
    last_gui_device = joystick;    
}
*/

// LEFT 
if( keyboard_check(vk_left) || keyboard_check(ord("A")))
{
    gui_dirs[left] = true;
    last_gui_device = keyboard; 
}
/*
if( joystick1_obj.states[# joy_left,held] || joystick2_obj.states[# joy_left,held])
{
    gui_dirs[left] = true;
    last_gui_device = joystick;    
}
*/

// RIGHT                        
if( keyboard_check(vk_right) || keyboard_check(ord("D")))
{
    gui_dirs[right] = true;
    last_gui_device = keyboard; 
}
/*
if( joystick1_obj.states[# joy_right,held] || joystick2_obj.states[# joy_right,held])
{
    gui_dirs[right] = true;
    last_gui_device = joystick;    
} 
*/

for(i=right; i<=down; i+=1)
{                
    DB.gui_controls[# i,pressed] = false;
    DB.gui_controls[# i,released] = false;
    
    if(gui_dirs[i])
    {
        DB.gui_controls[# i,held] = true;
        if(DB.gui_controls[# i,free])
        {                                    
            DB.gui_controls[# i,pressed] = true;
        }
        DB.gui_controls[# i,free] = false;
    }
    else
    {
        DB.gui_controls[# i,free] = true;
        if(DB.gui_controls[# i,held])
        {                                    
            DB.gui_controls[# i,released] = true;
        }
        DB.gui_controls[# i,held] = false;
    }    
}

/// COMMANDS
gui_commands[confirm]  = false;
gui_commands[cancel]   = false;                       
gui_commands[stepmode] = false;

if(keyboard_check(vk_enter))
{
    gui_commands[confirm] = true;
    last_gui_device = keyboard;
}
/*
if(joystick1_obj.states[# 1,held] || joystick2_obj.states[# 1,held])
{
    gui_commands[confirm] = true;
    last_gui_device = joystick;
}
*/
if(keyboard_check(vk_escape))
{
    gui_commands[cancel] = true;
    last_gui_device = keyboard;
}
/*
if(joystick1_obj.states[# 2,held] || joystick2_obj.states[# 2,held])
{
    gui_commands[cancel] = true;
    last_gui_device = joystick;
}
*/
if(keyboard_check(vk_alt))
{
    gui_commands[stepmode] = true;
    last_gui_device = keyboard;
}
/*
if(joystick1_obj.states[# joy_look,held] || joystick2_obj.states[# joy_look,held])
{
    gui_commands[stepmode] = true;
    last_gui_device = joystick;
}
*/

for(i=confirm; i<=stepmode; i+=1)
{                
    DB.gui_controls[# i,pressed] = false;
    DB.gui_controls[# i,released] = false;
    
    if(gui_commands[i])
    {
        DB.gui_controls[# i,held] = true;
        if(DB.gui_controls[# i,free])
        {                                    
            DB.gui_controls[# i,pressed] = true;
        }
        DB.gui_controls[# i,free] = false;
    }
    else
    {
        DB.gui_controls[# i,free] = true;
        if(DB.gui_controls[# i,held])
        {                                    
            DB.gui_controls[# i,released] = true;
        }
        DB.gui_controls[# i,held] = false;
    }    
}