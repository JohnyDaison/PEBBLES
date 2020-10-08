power_ratio = get_power_ratio(self.my_color,other.my_color);
if(power_ratio != 0)
{
    body_dmg = (force/8)*power_ratio;
    
    if((other.damage + body_dmg) < 0)
    {
        body_dmg = -other.damage;       
    }
    
    if(body_dmg != 0)
    {
        other.my_next_color = self.my_color;
        other.tint = self.tint;
        
        other.damage += body_dmg;
        other.aoe_met = true;
        other.last_dmg += body_dmg;
        other.energy += abs(body_dmg);
        
        i = instance_create(other.x,other.y,damage_popup_obj);
        i.damage = body_dmg;
        i.my_color = my_color;
        i.tint_updated = false;
        i.source = other.id;
    }
}

