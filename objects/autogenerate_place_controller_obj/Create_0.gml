event_inherited();

trigger_group_id = "triggers";
trigger_group = noone;

anim_group_count = 0;

if(gamemode_obj.cpu_player_exists)
{
    nav_graph_create();

    auto_init_waypoints = true;
    auto_generate_nav_graph = true;
    generate_nav_graph = true;
}

alarm[1] = 2;
alarm[2] = 4;