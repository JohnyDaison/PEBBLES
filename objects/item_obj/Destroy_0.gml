if(fresh && instance_exists(pickup_spawner_obj) && object_index != color_orb_obj)
{
    pickup_spawner_obj.spawned_item_count -= stack_size; 
}

if(self.collected && inv_index >= 0)
{
    if(instance_exists(my_guy) && object_is_ancestor(my_guy.object_index, guy_obj))
    {
        my_guy.inventory[? inv_index] = noone;
    }
}

ds_map_destroy(levels);

last_attacker_destroy();

unregister_item(id);

event_inherited();
