x = random(room_width - 2*singleton_obj.grid_margin) + singleton_obj.grid_margin;
y = random(room_height - 2*singleton_obj.grid_margin) + singleton_obj.grid_margin;

alarm[0] = 1;

var have_spawned = false;
var cannot_spawn = 
    !mod_get_state("snakes_on_a_plane") && !mod_get_state("artifacts") && !gamemode_obj.star_fall
    && !mod_get_state("bolt_rain") && !mod_get_state("slime_mob_rain") && !mod_get_state("lightning_strikes");
var num = ds_list_size(spawnables);
var total_value = 0;

for(i = 0; i < num; i++)
{
    key = spawnables[| i];
    if(spawn_active[? key])
    {
        total_value += spawn_ratio[? key];
    }
}
    
var offset = 0;
var rand_value = random(total_value);
var inst = noone;
var do_effect = false;

var i, ii, key, value, wall, other_key, rand_color;
   
for(i = 0; i < num && !have_spawned; i+=1)
{
    key = spawnables[| i];
    
    if(!spawn_active[? key])
    {
        continue;
    }
    
    value = spawn_ratio[? key];
    if(rand_value < value + offset)
    {
        // SNAKE
        if(key == "snake" && mod_get_state("snakes_on_a_plane") && singleton_obj.step_count > snake_grace_period)
        {
            wall = instance_nearest(x,y, wall_obj);
            if(wall != noone && wall.cover != cover_indestr && !wall.moving && !wall.falling 
                && !position_meeting(wall.x, wall.y, snake_mob_obj))
            {
                inst = instance_create(wall.x, wall.y, snake_mob_obj); 
                gamemode_obj.stats[? "snakes_spawned"] += 1;
                have_spawned = true;  
                do_effect = true;      
            }
        } 
           
        // ARTIFACT
        if(key == "artifact" && mod_get_state("artifacts"))
        {
            inst = instance_create(x,y,artifact_obj); 
            gamemode_obj.stats[? "artifacts_spawned_total"] += 1;
            have_spawned = true;  
            do_effect = true;      
        }
            
        // STAR FALL
        if(key == "star_core" && gamemode_obj.star_fall && singleton_obj.step_count > starfall_grace_period) 
        {
            var xx = lerp(x, room_width/2, 3/4);
            var yy = lerp(y, room_height/2, 3/4);
            inst = instance_create(xx,yy,star_core_obj);
            inst.my_guy = inst.id;
            inst.direction = 270;
            inst.speed = 12;
            inst.y -= (inst.delay+72) * inst.speed;
                
            gamemode_obj.stats[? "star_cores_spawned"] += 1;
            have_spawned = true;
        }
                
        // BOLT RAIN
        if(key == "small_bolt" && mod_get_state("bolt_rain") && singleton_obj.step_count > bolt_rain_grace_period)
        {
            if(bolt_rain_started)
            {
                inst = create_energy_ball(id, "small_bolt_rain", irandom_range(g_red,g_cyan), 0.3);
                inst.y += -room_height-32;
                
                //inst = instance_create(x,y-room_height-32,small_projectile_obj); //
                //inst.my_guy = inst.id;
                inst.my_source = noone;
                //inst.force = 0.3;
                inst.vspeed = 2;
                inst.was_stopped = true;
                //inst.my_color = irandom_range(g_red,g_cyan);
                //inst.tint_updated = false;
                have_spawned = true;
            }
        }
            
        // SLIME MOB RAIN
        if(key == "slime_mob" && mod_get_state("slime_mob_rain"))
        {
            repeat(slime_mob_count)
            {
                inst = instance_create(room_width/2 + irandom(1024)-512, -1136 + irandom(1024), slime_mob_obj);
                inst.my_color = irandom_range(g_red, g_white);
                inst.tint_updated = false;
            }
            
            have_spawned = true;
        }
        
        // LIGHTNING STRIKES
        if(key == "lightning_strike" && mod_get_state("lightning_strikes") && singleton_obj.step_count > lightning_strikes_grace_period)
        {
            if(lightning_strikes_started)
            {
                if(random(1) < lightning_strikes_prob_ratio)
                {
                    var target = instance_nearest(x - 16, 0, wall_obj);
                    
                    if(instance_exists(target)) {
                        inst = instance_create(target.x + 15, target.y, lightning_strike_obj);
                        inst.my_color = irandom_range(g_red, g_white);
                        inst.image_yscale = (target.y + 256) / 16;
                    }
                }
                
                have_spawned = true;
            }
        }
    }
    else
    {
        offset += value;
    }
}
    
if(slots_enabled && !have_spawned)
{
    /*
    new_color = 3;
    while(new_color == 3 || (!mod_get_state("dark_color") && new_color == 0))
    {
        new_color = irandom(4);
    }
    */
    inst = instance_create(x,y, color_orb_obj);
    inst.my_guy = inst.id;
    inst.airborne = true;
    inst.my_color = choose(g_red, g_green, g_blue);
    if(random(1) < 0.15)
        inst.my_color = g_octarine;
    inst.color_added = true;
}
    
if(inst != noone)
{
    if(inst.object_index == artifact_obj || inst.object_index == slime_mob_obj)
    {
        inst.hspeed = random_range(-6,6);
        inst.vspeed = random_range(-6,6);
    }

    if(do_effect)
        instance_create(inst.x,inst.y,spawn_effect_obj);
        
    rand_color = ds_map_find_value(DB.colormap, irandom_range(g_dark, g_white));
    singleton_obj.new_background_color = merge_color(c_black, rand_color, 0.02);
    singleton_obj.bgcolor_updated = false;
}


spawn_delay = ceil(base_spawn_delay * spawn_delay_ratio);

if(have_spawned || cannot_spawn)
{
    alarm[0] = spawn_delay;
}

var inst_name = "";
if(inst != noone)
{
    inst_name = object_get_name(inst.object_index);
}
else
{
    inst_name = "noone";   
}

if(alarm[0] != 1)
{
    my_console_log("Phenomena [" + string(alarm[0]) + "]: " + inst_name);
}
