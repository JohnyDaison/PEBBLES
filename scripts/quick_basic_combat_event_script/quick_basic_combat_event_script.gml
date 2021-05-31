function quick_basic_combat_event_script(event, source, context_str, params) {
    if(event == "zone_enter")
    {
        var zone_id = get_group_key(source, get_group("zones"));
    
        if(zone_id == "spawn_sprinkler")
        {
            if(!instance_exists(access_card_obj))
            {
                with(mob_portal_obj)
                {
                    if(!enabled)
                    {
                        enabled = true;
                        alarm[0] = 3 * singleton_obj.game_speed;
                    }
                }
            }
        }
    }

    if(event == "mob_spawn")
    {
        var mob = params[? "mob"];
    
        if(mob.object_index == sprinkler_body_obj)
        {
            with(mob)
            {
                lockon_range = 1024;
                hp = 10;
                refire_time = 60;
                gun_count = 2;
                ammo_drop_count = 0;

                drop_item = create_drop_item(access_card_obj, id);
                drop_item.my_color = g_green;
            }
        
            with(mob_portal_obj)
            {
                enabled = false;
                active = false;
            }
        }
    }
}
