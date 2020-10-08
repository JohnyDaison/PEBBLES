with(guy_obj)
{      
    if(self.id != other.my_guy)
    {    
        // RETURN GRAVITY BACK TO NORMAL
        if(holographic == other.holographic && (gravity_coef != old_coef || gravity_direction != 270))
        {
            gravity_direction = 270;
            gravity_coef = old_coef;
            y-=1;
            airborne = false;
        }
    }
    else
    {
        self.casting = false;
        self.casting_ring = false;
        self.have_casted = true;
        alarm[0] = spell_cooldown;
    }
}

for(i=slot_count-1; i>=0; i--)
{
    slot = ds_list_find_value(stolen_slots,i);
    if(instance_exists(slot))
    {
        if(slot.my_guy == id)
        {
            slot.my_guy = slot.id;
            slot.airborne = true;
        }
    }
}

ds_list_destroy(stolen_slots);

action_inherited();
