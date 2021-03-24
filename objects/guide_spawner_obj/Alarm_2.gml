/// @description SPAWN GUIDE

my_guy = instance_create(x,y, basic_bot);

with(my_guy)
{
    tut_guide3_init();
    npc_script = tut_guide3;
    npc_destroy_script = tut_guide3_destroy;
    switch(room)
    {
        // old tutorial
        case room_movement_mountain:
            topic = guide_movement2;
            break;
            
        // quick tutorial    
        case room_quick_tut_movement:
            topic = guide_quick_movement2;
            break;
            
        case room_quick_tut_base_colors:
            topic = guide_quick_base_colors2;
            break;
            
        case room_quick_tut_catalyst:
            topic = guide_quick_catalyst2;
            break;
            
        case room_quick_tut_basic_combat:
            topic = guide_quick_basic_combat;
            break;
            
        case room_quick_tut_advanced_combat:
            topic = guide_quick_advanced_combat;
            break;
            
        case room_quick_tut_advanced_combat_new:
            topic = guide_quick_advanced_combat_new;
            break;
            
        case room_quick_tut_abilities:
            topic = guide_quick_abilities;
            break;
    }
    
    name = DB.I18n[? "tut_guide/name"];
    //my_color = g_white;
    holographic = true;
    facing_right = false;
    
    my_player.my_guy = id;
    my_spawner = other.id;
    my_player.my_spawner = other.id;
    guy_spawn_point_create(my_spawner, my_player, true);
    
    // CHARGEBALL
    guy_provide_chargeball(my_guy);
    
    // guide 3
    script_execute(topic, "init", noone);
    
    // Main camera should be World's my_camera and follow World's my_guy?
}

instance_create(x,y,spawn_effect_obj);