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
        var consume = false;
        
        if(instance_exists(guy.my_base) && guy.my_base.object_index == guy_spawner_obj && !instance_exists(guy.my_base.base_cannon))
            consume = true;
        
        if(consume || guy_ok)
        {
            var params = ds_map_create();
            params[? "who"] = guy.id;
            register_ds("params", ds_type_map, params, id);
            
            broadcast_event("item_pickup", id, params);
        }
        
        if(consume)
        {
            var score_gain = gamemode_obj.score_values[? "extra_orb"];
            increase_stat(guy.my_player, "score", score_gain, false);
            battlefeed_post_pickup(guy.my_player, object_index, score_gain);
            guy_ok = false;
            instance_destroy();   
        }
        
        if(guy_ok)
        {
            var in_use_list = guy.orbs_in_use[? my_color];
            if(in_use_list != undefined && ds_list_size(in_use_list) < guy.belt_size[? my_color])
            {
                if(ds_exists(guy.orb_belts[? my_color], ds_type_list))
                {
                    orb_transfer(id, id, "free", guy.id, "belt");
                    my_sound_play(slot_absorbed_sound);
                    effect_create_above(ef_firework, x,y, 2, tint);
                    level_increase(guy.id, "orbs" + string(my_color), 1);
                }
            }
            else
            {
                if(my_color > g_black && my_color < g_octarine && guy.orb_reserve[? my_color] < guy.my_player.levels[? "orb_storage_size"])
                {
                    my_guy = guy.id;
                    my_guy.orb_reserve[? my_color] += 1;
                    my_sound_play(slot_absorbed_sound);
                    effect_create_above(ef_firework, x,y, 2, tint);
                    instance_destroy();
                }
            }
        }
    }
}

