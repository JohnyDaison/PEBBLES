if(!instance_exists(my_block))
{
    my_block = instance_nearest(x-16,y, wall_obj);
    if(!place_meeting(x,y, my_block))
    {
        instance_destroy();
        exit;
    }
    else
    {
        x = my_block.x + 15;
        y = my_block.y;
    }
}


// DRAIN ENERGY FROM BLOCK
var available_energy = min(my_block.energy, drain_speed);
var required_energy = min(spawn_cost - energy, drain_speed);
var transferable_energy = min(available_energy, required_energy);

if(energy < spawn_cost && !spawning && !standby && my_block.my_color != g_octarine)
{
    if(transferable_energy > 0)
    {
        energy += transferable_energy;
        my_block.energy -= transferable_energy;
                
        my_color = my_block.my_color;
        tint = merge_colour(black_tint, DB.colormap[? my_color], energy/spawn_cost);
        tint_updated = true;      
    }
    
    if(my_block.energy == 0)
    {
        my_block.my_next_color = g_dark;
    }
}

// TRIGGER SPAWN
if(energy >= spawn_cost && !spawning)
{
    var have_spawned = false;
    var num = ds_map_size(spawnables);
    var key = ds_map_find_first(spawnables);
    var offset = 0;
    var rand_value = irandom(100);
    var inst = noone;
    
    for(i = 0; i < num && !have_spawned; i+=1)
    {
        var value = ds_map_find_value(spawnables,key);
        if(rand_value < value + offset)
        {
            inst = instance_create(x,y-spawn_height,key);
            inst.spawned_from = id;
            have_spawned = true;
            spawned_item_count += 1;
        }
        else
        {
            offset += value;
            key = ds_map_find_next(spawnables,key);
            
        }
    }

    if(instance_exists(inst))
    {
        spawned_item = inst;
        spawned_item.invisible = true;
        if(duplicate_items)
        {
            spawned_item.duplicate_me = true;   
        }
        
        spawn_effect = instance_create(x, y - spawn_height, spawn_effect_obj);
        spawn_effect.image_speed = 0.5; 
        
        energy = 0;
        spawn_tint = tint;
        my_color = g_dark;
        tint_updated = false;
        
        
        spawning = true;
    }
}

// END SPAWNING WHEN SPAWN EFFECT ENDS
if(spawning && !instance_exists(spawn_effect))
{
    spawning = false;
    if(instance_exists(spawned_item))
    {
        spawned_item.invisible = false;
    }
    spawn_effect = noone;
    standby = true;
}

// KEEP CHECK OF LAST ITEM
has_item = instance_exists(spawned_item);

if(has_item && !object_is_child(spawned_item, item_obj))
{
    has_item = false;
    spawned_item.invisible = false;
}

if(has_item)
{
    if (spawned_item.collected || spawned_item.placed)
        has_item = false;
    if(distance_to_object(spawned_item) > spawn_height)
        has_item = false;
        
    if(!has_item)
        spawned_item.invisible = false;
}


// DURING SPAWNING
if(spawning && has_item)
{
    spawned_item.y = y - spawn_height;
    spawned_item.speed = 0;
}


// ARM ANGLE
if(spawning || has_item)
{
    arm_angle = 0;
}
else
{
    des_arm_angle = max(0, 1-(energy/spawn_cost))*max_arm_angle;
    arm_angle = lerp(arm_angle, des_arm_angle, 1/12);
}


// RESTART
if(standby && !has_item)
{
    standby = false;
    tint_updated = false;
    spawned_item = noone;
}

event_inherited();