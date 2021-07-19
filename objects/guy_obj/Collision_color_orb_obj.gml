var guy = id;
var orb = other;

with(orb)
{
    if(collected || holographic != guy.holographic
    || !(for_player == -1 || for_player == guy.my_player.number))
    {
        exit;
    }
    
    var guy_ok = false;
    if(instance_exists(my_guy))
    {
        if(my_guy.id == self.id)
        {
            guy_ok = true;
        }
        if(my_guy.object_index == black_aoe_obj || my_guy.object_index == black_projectile_obj)
        {
            if(guy.my_player == my_guy.my_player)
            {
                guy_ok = true;
            }
        }
    }
    
    if(guy.slots_triggered || guy.lost_control)
    {
        guy_ok = false;
    }
    
    if(guy_ok)
    {
        var in_use_list = guy.orbs_in_use[? my_color];
        var can_add_to_belt = in_use_list != undefined && ds_list_size(in_use_list) < guy.belt_size[? my_color];
        var has_cannon = ds_list_size(guy.my_player.my_cannons) > 0;
        var can_be_stored = my_color > g_dark && my_color < g_octarine && guy.orb_reserve[? my_color] < guy.my_player.levels[? "orb_storage_size"];
        var orb_collected = false, orb_converted = false;

        if(can_add_to_belt) {
            if(ds_exists(guy.orb_belts[? my_color], ds_type_list)) {
                // add to belt
                orb_transfer(id, id, "free", guy.id, "belt");
                level_increase(guy.id, "orbs" + string(my_color), 1);
                
                orb_collected = true;
            }
        }
        else if(!has_cannon || !can_be_stored) {
            // consume orb for score
            var score_gain = gamemode_obj.score_values[? "extra_orb"];
            increase_stat(guy.my_player, "score", score_gain, false);
            battlefeed_post_pickup(guy.my_player, object_index, score_gain);
            
            orb_collected = true;
            orb_converted = true;
        }
        else if(can_be_stored) {
            // add to storage
            my_guy = guy.id;
            my_guy.orb_reserve[? my_color] += 1;
            
            orb_collected = true;
            orb_converted = true;
        }
        
        if (orb_collected) {
            effect_create_above(ef_firework, x,y, 1, tint);
            my_sound_play(slot_absorbed_sound);
            
            var params = create_params_map();
            params[? "who"] = guy.id;
            
            broadcast_event("item_pickup", id, params);
        }
        
        if (orb_converted) {
            instance_destroy();
        }
    }
}
