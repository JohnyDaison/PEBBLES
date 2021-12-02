with(charge_ball)
{
    instance_destroy();
}

with(my_waypoint)
{
    instance_destroy();
}

if(!cancelled)
{
    if(shot_color > g_dark)
    {
        ii = instance_create(x, y, slot_explosion_obj);
        ii.my_guy = id;
        ii.my_color = shot_color;
        ii.my_source = object_index;
        ii.holographic = holographic;
    }
    else
    {
        my_sound_play(wall_crumble_sound);
    }
    
    var stat_str = "";
    var la_player = last_attacker_map[? "player"];
    
    if(instance_exists(la_player))
    {
        if(la_player.team_number != my_player.team_number)
        {
            score_value = gamemode_obj.score_values[? "cannon_killed"];
            
            increase_stat(la_player, "score", score_value, false);
            stat_str = stat_label("score", score_value, "+");
        }
    }
    
    battlefeed_post_destruction(id, id.last_attacker_map, stat_str);
}
else
{
    with(platform_obj)
    {
        if(my_struct == other.id)
            instance_destroy();
    }
}

ds_map_destroy(orbs);
ds_map_destroy(orb_light);

cannon_unassign_player(self);

event_inherited();
