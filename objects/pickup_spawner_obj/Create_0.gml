event_inherited();

if(room == big_arena)
{
    spawn_delay = 180;
}
else
{
    spawn_delay = 600; // 600
}
hor_margin = 160;
ver_margin = 160;
slots_enabled = false;
spawned_item_count = 0;
spawned_item_limit = 16; //25

spawnables = ds_map_create();

// SPAWNABLES - PROBABILITY IN PERCENTS, LEAVE SOME FOR SLOTS - SUM MUST BE < 100
/*
switch(room)
{
    case chase:
    {
        ds_map_add(spawnables,overcharge_obj,5);
        ds_map_add(spawnables,crystal_obj,40);
        ds_map_add(spawnables,tp_rush_obj,25);
        // SLOTS 30
    }
    break;
    
    case alpinus_sandbox:
    {
        ds_map_add(spawnables,health_obj,20);
        ds_map_add(spawnables,overcharge_obj,10);
        ds_map_add(spawnables,tp_rush_obj,20);
        ds_map_add(spawnables,crystal_obj,20);
        // SLOTS 30
    }
    break;
     
    default:
    {
        ds_map_add(spawnables,health_obj,15); //15
        ds_map_add(spawnables,overcharge_obj,10); //10
        ds_map_add(spawnables,tp_rush_obj,5); //15
        ds_map_add(spawnables,crystal_obj,10); //15
        ds_map_add(spawnables,artifact_obj,15); //15
        //ds_map_add(spawnables,pickup_magnet_obj, 2);
        ds_map_add(spawnables,emp_grenade_obj, 25); //5
        // SLOTS 20
    }
}
*/

ds_map_add(spawnables,health_obj,15); //15
ds_map_add(spawnables,overcharge_obj,10); //10
ds_map_add(spawnables,tp_rush_obj,5); //15
ds_map_add(spawnables,crystal_obj,10); //15
ds_map_add(spawnables,artifact_obj,15); //15
//ds_map_add(spawnables,pickup_magnet_obj, 2);
ds_map_add(spawnables,emp_grenade_obj, 25); //5
// SLOTS 20
 
alarm[0] = spawn_delay;

my_console_log("RANDOM SPAWNER CREATED");