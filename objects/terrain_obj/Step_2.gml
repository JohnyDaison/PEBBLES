// FALL OUT OF ARENA
var place = gamemode_obj.world.current_place;
var place_bottom = place.y + place.height;
var fell_out = y > place_bottom && !moving;

if(fell_out) {
    done_for = true;
}

if(done_for && !destroyed)
{
    // STATS
    if(object_index == wall_obj && damage >= hp && !cancelled)
    {
        gamemode_obj.stats[? "terrain_destroyed_total"] += 1;
        
        var la_player = last_attacker_map[? "player"];
        var what = last_attacker_map[? "source"];
        
        if(instance_exists(la_player))
        {
            increase_stat(la_player, "terrain_destroyed", 1, false);
            if(what == guy_obj || what == emp_grenade_obj)
            {
                increase_stat(la_player, "terrain_destroyed_by_guy", 1, false);
            }
        }
        
        var params = create_params_map();
        params[? "who"] = last_attacker_map[? "source_id"];
            
        broadcast_event("object_destroy", id, params);
    }
    
    // STRUCTURES
    with(structure_obj)
    {
        if(my_block == other.id)
        {
            cancelled = cancelled || other.cancelled;
            instance_destroy();
        }
    }
    
    destroyed = true;
}

if (fell_out) {
    instance_destroy();
}