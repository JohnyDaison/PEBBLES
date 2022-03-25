function create_npc_guy(x, y, player) {
    var new_guy = instance_create(x,y, basic_bot);
    
    with(new_guy)
    {
        my_player = player;
        if(gamemode_obj.mode == "volleyball")
        {
            volleyball_bot2_init();
            npc_script = volleyball_bot2;
            npc_destroy_script = volleyball_bot2_destroy;
        }
        else if(instance_exists(place_controller_obj) && place_controller_obj.nav_graph_exists)
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
    }
    
    return new_guy;
}