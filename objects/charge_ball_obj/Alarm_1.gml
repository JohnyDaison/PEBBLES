/// @description  BARRAGE SHOT
if (instance_exists(my_guy))
{    
    var hboost, vboost, force;
    
    if (charge >= small_charge)
    {
        force = small_charge;
    }
    else
    {
        force = charge;
    }
    
    var inst = create_energy_ball(id, "small_bolt", my_color, force);
    //var inst = instance_create(x,y,small_projectile_obj);
    //inst.facing_right = my_guy.facing_right;
    /*
    inst.my_player = self.my_player;
    inst.my_guy = my_guy.id;
    inst.my_source = object_index;
    inst.holographic = self.holographic;
    */
    
    inst.direction = point_direction(0,0, rel_x, rel_y);
    
    if (object_is_ancestor(my_guy.object_index, guy_obj) && my_guy.my_player.my_guy == my_guy)
    {
        viewshake(my_player.my_camera, inst.direction+180, 3);
    }
    if (desired_dist != 0)
    {
        inst.speed = 3 + 6*self.trig_charge*point_distance(0,0, rel_x, rel_y)/desired_dist;
    }
    else
    {
        inst.speed = 3 + 6*self.trig_charge;
    }
    
    
    hboost = -inst.hspeed/50;
    vboost = -inst.vspeed/50;
                
    inst.hspeed += my_guy.hspeed;
    inst.vspeed += my_guy.vspeed;
                
    if (my_guy != id && !my_guy.immovable) 
    {   
        with(my_guy)
        {
            hspeed += hboost;
                        
            if (vboost <= 0 || !place_meeting(x,y+1, terrain_obj))
            {
                vspeed += vboost;
            }
        }
    }
                
    if (object_is_ancestor(my_guy.object_index, guy_obj))
    {
        inst.guided = true;
    }
    /*
    inst.my_color = self.my_color;
    inst.tint_updated = false;
    */
    charge -= force;
    //show_debug_message("BARRAGE left: " +string(charge));
}

if (charge > 0)
{
    alarm[1] = shot_delay;
}
else
{
    firing = false;
}
