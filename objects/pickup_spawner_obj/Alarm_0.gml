if(room == chase)
{
    x = random(room_width/2 - hor_margin) + room_width/2 + hor_margin;
    y = random(room_height - 2*ver_margin) + ver_margin;
}
else
{
    x = random(room_width - 2*singleton_obj.grid_margin) + singleton_obj.grid_margin;
    y = random(room_height - 2*singleton_obj.grid_margin) + singleton_obj.grid_margin;
}

var have_spawned;
var num;
    
var offset;
var rand_value;
var inst;

var floor_below, yy, i, key, value, rand_color;

if(spawned_item_count >= spawned_item_limit)
{
    alarm[0] = spawn_delay;
}
else
{
    alarm[0] = 1;
    
    if(place_empty(x,y))
    {
        floor_below = false;
        yy = y;
        while(yy < room_height - singleton_obj.grid_margin && !floor_below)
        {
            yy += 64;
            if(place_meeting(x,yy,terrain_obj))
            {
                floor_below = true;
            }   
        }
        
        if(floor_below)
        {
            have_spawned = false;
            num = ds_map_size(spawnables);
            key = ds_map_find_first(spawnables);
            offset = 0;
            rand_value = irandom(100);
            inst = noone;
            
            for(i = 0; i < num && !have_spawned; i+=1)
            {
                value = ds_map_find_value(spawnables, key);
                if(rand_value < value + offset)
                {
                    inst = instance_create(x,y,key);         
                    have_spawned = true;
                    spawned_item_count += 1;
                }
                else
                {
                    offset += value;
                    key = ds_map_find_next(spawnables, key);
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
                inst = instance_create(x,y,color_orb_obj);
                inst.my_guy = inst.id;
                inst.airborne = true;
                inst.my_color = choose(g_red, g_green, g_blue);
                if(random(1) < 0.15)
                    inst.my_color = g_octarine;
                inst.color_added = true;
            }
            
            if(inst != noone)
            {
                my_console_log("RANDOM SPAWNED " + object_get_name(inst.object_index) + " at " + string(x) + "," + string(y));
                
                inst.hspeed = random_range(-6,6);
                inst.vspeed = random_range(-6,6);

                instance_create(x,y,spawn_effect_obj);
                    
                alarm[0] = spawn_delay;
                
                rand_color = ds_map_find_value(DB.colormap, irandom_range(g_dark, g_white));
                singleton_obj.new_background_color = merge_color(c_black, rand_color, 0.01);
                singleton_obj.bgcolor_updated = false;
            }
        }
    }
}
