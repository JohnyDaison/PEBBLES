///@description COLLAPSE, PARTICLES, POSITION, SIZE

// COLLAPSE
if(charge > threshold)
{
    if(instance_exists(my_guy))
    {
        if(object_is_ancestor(my_guy.object_index, guy_obj))
        {
            with(my_guy)
            {
                charging = false;
                status_left[? "frozen"] += 30;
                spec_effect_to_guy(other.charge,"damage");
            }
        }

        // IMPLOSION
        if(my_color == g_black)
        {
            i = instance_create(x,y,black_aoe_obj);
            i.my_player = my_guy.my_player;
            i.force = charge/2;
            i.my_color = my_color;
            i.my_guy = i.id;  
            i.my_source = object_index;
        }
        // EXPLOSION
        else
        {
            i = instance_create(x,y,slot_explosion_obj);
            i.my_color = my_color;
            i.my_player = my_guy.my_player;
            i.my_guy = my_guy;
            i.my_source = object_index;
            i.holographic = holographic;
            
            if(my_guy != id)
            {
                my_guy.lost_control = true;
                my_guy.front_hit = true;
                if(rel_x != 0)
                    my_guy.hspeed -= (radius/rel_x)*charge;
                if(rel_y != 0)
                    my_guy.vspeed -= (radius/rel_y)*charge;
            }
        }
    } 
    charge = 0;
}


// PARTICLES, POSITION, SIZE
sprite_size = size_coef*(0.25 + 0.50 * charge/max_charge);
particles_alpha = min(1, 0.1 + 0.9 * (charge / max(max_charge, max_charge+overcharge)));

if(instance_exists(my_guy) && sprite_index != noone && my_color != -1)
{
    self.x = my_guy.x + center_offset_x + rel_x;
    self.y = my_guy.y + center_offset_y + rel_y;
}

image_xscale = sprite_size;
image_yscale = sprite_size;
radius = base_radius*sprite_size;
orb_dist = radius;

part_emitter_region(system,em,x - radius,x + radius,y - radius,y + radius,ps_shape_ellipse,ps_distr_gaussian);
part_emitter_burst(system,em,pt,ceil(sprite_size)^2);

event_inherited();