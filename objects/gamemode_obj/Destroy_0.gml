for(var i = -1; i <= player_count; i++)
{
    player = players[? i];
    if(!is_undefined(player)) 
    {
        with(player)
        {
            instance_destroy();
        }
    }
}

ds_map_destroy(players);
ds_map_destroy(limits);
ds_map_destroy(limit_active);
ds_map_destroy(stats);
ds_map_destroy(score_values);

//levels
ds_map_destroy(level_min);
ds_map_destroy(level_max);
ds_map_destroy(level_minstart);
ds_map_destroy(level_maxstart);

ds_list_destroy(losers);

// mods
ds_map_destroy(mods_state);
ds_map_destroy(custom_mods);

singleton_obj.show_minimap = false;

if(instance_exists(world))
{
    instance_destroy(world);   
}

