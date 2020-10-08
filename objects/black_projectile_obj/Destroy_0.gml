if(instance_number(object_index)==1)
{
    my_sound_stop(black_projectile_sound);
}

// give guys normal gravity
with(guy_obj)
{
    if(self.id != other.my_guy)
    {
        if(holographic == other.holographic && (gravity_coef != old_coef || gravity_direction != 270))
        {
            self.gravity_direction = 270;
            gravity_coef = old_coef;
            y-=1;
            airborne = false;
        }
    }
}

explosion_count = 0;

// explode slots
for(i=0; i<slot_count; i+=1)
{
    slot = ds_list_find_value(stolen_slots,i);
    if(instance_exists(slot))
    {
        if(slot.my_guy == self.id)
        {
            if(slot.my_color == g_black)
            {
                i = instance_create(x,y,black_aoe_obj);
                //i.my_player = my_guy.my_player;
                i.force = force;
                i.my_color = my_color;
                i.my_guy = i.id;
                i.holographic = holographic;
                with(slot)
                {
                    instance_destroy();
                }
                explosion_count += 1;
            }
            else
            {
                ii = instance_create(x,y,slot_explosion_obj);
                ii.slot = slot.id;
                ii.my_source = slot.object_index;
                ii.holographic = holographic;
                slot.my_guy = ii.id;
                explosion_count += 1;
            }
        }
    }
}

// if slots exploded, destroy unclaimed pickups
if(explosion_count > 0)
{
    for(i=0; i<pickup_count; i+=1)
    {
        pickup = ds_list_find_value(picked_pickups,i);
        if(instance_exists(pickup) && (!pickup.collected || (pickup.placed && pickup.stuck_to == noone)))
        {
            with(pickup)
            {
                instance_destroy();
            }
        }
    }
}

ds_list_destroy(stolen_slots);
ds_list_destroy(picked_pickups);

action_inherited();
