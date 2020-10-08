event_inherited();

last_node = ds_list_size(beam_nodes)-1;
if(beam_head_node > last_node)
{
    beam_head_node = last_node;
    beam_head_node_changed = true;
}

for(i=0;i<=last_node;i+=1)
{
    node = ds_list_find_value(beam_nodes,i);
    if(!instance_exists(node))
    {
        alarm[0] = 1;
        invalid = true;
    }
}

if(endpoint_reached && !invalid)
{
    if(head_facing==0)
    {    
        if(facing_right)
            head_facing = 1;
        else
            head_facing = -1;
    }
    
    if(beam_head_node_changed)
    {   
        //show_debug_message("beam:"+string(beam_head_node)+" "+string(ds_list_size(beam_nodes)));
        head_node = ds_list_find_value(beam_nodes, beam_head_node);
        
        if(instance_exists(head_node))
        {
            node_x = head_node.x;
            if(beam_head_node != last_node)
            {
                next_node = ds_list_find_value(beam_nodes,beam_head_node+1);
                next_node_x = next_node.x;
                if(object_is_ancestor(next_node.object_index,terrain_obj))
                    next_node_x += 16 - facing*16;
                if(next_node.object_index == shield_obj)
                    next_node_x += -facing*next_node.radius;
            }
            if(last_node == 0)
            {
                next_node_x = (1+1.1*head_facing)*room_width/2;
            }
            
            // PUSH
            if(!beam_head_landed)
            {
                pushed_guy = noone;
                if(object_is_ancestor(head_node.object_index,guy_obj))
                {
                    pushed_guy = head_node;
                }
                if(head_node.object_index == shield_obj && instance_exists(head_node.my_guy) && object_is_ancestor(head_node.my_guy.object_index,guy_obj))
                {
                    pushed_guy = head_node.my_guy;
                }
                if(pushed_guy != noone)
                {
                    if(pushed_guy != my_guy)
                        pushed_guy.hspeed -= head_facing*4;
                    else
                        pushed_guy.hspeed -= head_facing;
                }
            }
        }
        
        beam_head_node_changed = false;
    }
    
    // BEAM HEAD PROPAGATION    
    if(beam_head_fired)
    {
        if(!beam_head_landed)
        {
            beam_head_dist += (head_facing*beam_speed/2);
            //show_debug_message("head_dist: " + string(beam_head_dist));
            if(sign(next_node_x-(node_x+beam_head_dist)) != head_facing)
            {
                if(beam_head_node+1 < last_node)
                {
                    beam_head_node += 1;
                    beam_head_dist = 0;
                    head_facing *= -1;
                    show_debug_message("head_node: " + string(beam_head_node));
                    show_debug_message("head_facing: " + string(head_facing));
                    beam_head_node_changed = true;    
                }
                else
                {
                    beam_head_dist = next_node_x-node_x;
                    beam_head_landed = true;
                }
            }
        }
        
        if(beam_head_landed && !instance_exists(beam_end))
        {
            beam_end = instance_create(node_x+beam_head_dist,y,beam_end_obj);
            beam_end.my_beam = self.id;    
        }
        
        if(beam_head_landed && instance_exists(beam_end))
        {
            if(beam_head_node == last_node && last_node >= 1)
            {
                beam_head_dist = next_node_x-node_x;
            }   
            
            beam_end.x = head_node.x + beam_head_dist;
            beam_end.y = head_node.y;
            if(object_is_ancestor(head_node.object_index,terrain_obj))
            {
                beam_end.x += 16 - facing*16;
                beam_end.y += 16;
            }
        }
        
        if(abs(beam_head_dist) > 0 || beam_head_node > 0)
        {
            force -= 0.01;
        }
    }
    if(force < 0.3)
    {
        image_alpha -= 0.02;
        beam_alpha -= 0.02;
    }
    
    // DAMAGE DEALING
    if(force > 0)
    {            
        if(facing_right)
            facing = 1;
        else
            facing = -1;
          
        // BEAM GOES OUTSIDE ROOM
        if(!collided)
        {
            node = ds_list_find_value(beam_nodes,0);
            
            if(beam_head_fired)
            {
                with(phys_body_obj)
                {
                    if(my_player != other.my_player)
                    {
                        if(collision_rectangle(other.node.x,other.node.y-other.beam_big_core_size/2,other.node.x+other.beam_head_dist,other.node.y+other.beam_big_core_size/2,id,false,false))
                        {
                            receive_damage(other.force/other.big_beam_coef,true);
                        }
                    }
                }
                
                with(artifact_obj)
                {
                    if(collision_rectangle(other.node.x,other.node.y-other.beam_big_core_size/2,other.node.x+other.beam_head_dist,other.node.y+other.beam_big_core_size/2,id,false,false))
                    {
                        receive_damage(other.force/other.big_beam_coef,true);
                        event_perform(ev_other,ev_user1);
                    }
                }
                
                with(crystal_obj)
                {
                    if(collision_rectangle(other.node.x,other.node.y-other.beam_big_core_size/2,other.node.x+other.beam_head_dist,other.node.y+other.beam_big_core_size/2,id,false,false))
                    {
                        receive_damage(other.force/other.big_beam_coef,true);
                        event_perform(ev_other,ev_user1);
                    }
                }
                    
            }
            
            if(!beam_head_landed)
            {
                with(phys_body_obj)
                {
                    if(my_player != other.my_player)
                    {
                        if(collision_rectangle(other.node.x+other.beam_head_dist,other.node.y-other.beam_small_core_size/2,other.node.x+(1+1.1*other.facing)*room_width/2,other.node.y+other.beam_small_core_size/2,id,false,false))
                        {
                            receive_damage(other.force/other.small_beam_coef,false);
                        }
                    }
                }
                
                with(artifact_obj)
                {
                    if(collision_rectangle(other.node.x+other.beam_head_dist,other.node.y-other.beam_small_core_size/2,other.node.x+(1+1.1*other.facing)*room_width/2,other.node.y+other.beam_small_core_size/2,id,false,false))
                    {
                        receive_damage(other.force/other.small_beam_coef,false);
                        event_perform(ev_other,ev_user1);
                    }
                }
                
                with(crystal_obj)
                {
                    if(collision_rectangle(other.node.x+other.beam_head_dist,other.node.y-other.beam_small_core_size/2,other.node.x+(1+1.1*other.facing)*room_width/2,other.node.y+other.beam_small_core_size/2,id,false,false))
                    {
                        receive_damage(other.force/other.small_beam_coef,false);
                        event_perform(ev_other,ev_user1);
                    }
                }
            }
        }
        
        //BEAM HITS SOMETHING    
        else
        {   
            node_fix = 0;
            next_node_fix = 0;
            for(i=0;i<=last_node;i+=1)
            {
                node = ds_list_find_value(beam_nodes,i);
                
                if(i != 0)
                {
                    node_fix = next_node_fix;
                }
                
                if(i <= last_node-1)
                {
                    next_node = ds_list_find_value(beam_nodes,i+1);
                    
                    if(!instance_exists(next_node))
                    {
                       break; 
                    }
                    
                    if(object_is_ancestor(next_node.object_index,terrain_obj))
                        next_node_fix = 16 - facing*16;
                    if(next_node.object_index == shield_obj)
                        next_node_fix = -facing*next_node.radius;

                    if(beam_head_fired)
                    {
                        if(i < beam_head_node)
                        {
                            with(phys_body_obj)
                            {
                                if(my_player != other.my_player)
                                {
                                    if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_big_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_big_core_size/2,id,false,false))
                                    {
                                        receive_damage(other.force/other.big_beam_coef,true);
                                    }    
                                }
                            }
                            
                            with(artifact_obj)
                            {
                                if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_big_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_big_core_size/2,id,false,false))
                                {
                                    receive_damage(other.force/other.big_beam_coef,true);
                                    event_perform(ev_other,ev_user1);    
                                }    
                            }
                            
                            with(crystal_obj)
                            {
                                if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_big_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_big_core_size/2,id,false,false))
                                {
                                    receive_damage(other.force/other.big_beam_coef,true);
                                    event_perform(ev_other,ev_user1);    
                                }    
                            }
                        }
                        
                        if(i > beam_head_node)
                        {
                            with(phys_body_obj)
                            {
                                if(my_player != other.my_player)
                                {
                                    if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                                    {
                                        receive_damage(other.force/other.small_beam_coef,false);
                                    }
                                }    
                            }
                            
                            with(artifact_obj)
                            {
                                if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                                {
                                    receive_damage(other.force/other.small_beam_coef,false);
                                    event_perform(ev_other,ev_user1);    
                                }    
                            }
                            
                            with(crystal_obj)
                            {
                                if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                                {
                                    receive_damage(other.force/other.small_beam_coef,false);
                                    event_perform(ev_other,ev_user1);    
                                }    
                            }    
                        }
                        
                        if(i == beam_head_node)
                        {
                            with(phys_body_obj)
                            {
                                if(my_player != other.my_player)
                                {
                                    if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_big_core_size/2,other.node.x+other.node_fix+other.beam_head_dist,other.node.y+other.beam_big_core_size/2,id,false,false))
                                    {
                                        receive_damage(other.force/other.big_beam_coef,true);
                                    }
                                    
                                    if(sign(other.next_node.x-other.beam_head_dist) == other.head_facing)
                                    {
                                        if(collision_rectangle(other.node.x+other.node_fix+other.beam_head_dist,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                                        {
                                            receive_damage(other.force/other.small_beam_coef,false);
                                        }
                                    }    
                                }
                            }
                            
                            with(artifact_obj)
                            {
                                if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_big_core_size/2,other.node.x+other.node_fix+other.beam_head_dist,other.node.y+other.beam_big_core_size/2,id,false,false))
                                {
                                    receive_damage(other.force/other.big_beam_coef,true);
                                    event_perform(ev_other,ev_user1);    
                                }
                                
                                if(sign(other.next_node.x-other.beam_head_dist) == other.head_facing)
                                {
                                    if(collision_rectangle(other.node.x+other.node_fix+other.beam_head_dist,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                                    {
                                        receive_damage(other.force/other.small_beam_coef,false);
                                        event_perform(ev_other,ev_user1);    
                                    }
                                }    
                            }
                            
                            with(crystal_obj)
                            {
                                if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_big_core_size/2,other.node.x+other.node_fix+other.beam_head_dist,other.node.y+other.beam_big_core_size/2,id,false,false))
                                {
                                    receive_damage(other.force/other.big_beam_coef,true);
                                    event_perform(ev_other,ev_user1);    
                                }
                                
                                if(sign(other.next_node.x-other.beam_head_dist) == other.head_facing)
                                {
                                    if(collision_rectangle(other.node.x+other.node_fix+other.beam_head_dist,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                                    {
                                        receive_damage(other.force/other.small_beam_coef,false);
                                        event_perform(ev_other,ev_user1);    
                                    }
                                }    
                            }
                        }
                    }
                    else
                    {
                        with(phys_body_obj)
                        {
                            if(my_player != other.my_player)
                            {
                                if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                                {
                                    receive_damage(other.force/other.small_beam_coef,false);
                                }
                            }    
                        }
                        
                        with(artifact_obj)
                        {
                            if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                            {
                                receive_damage(other.force/other.small_beam_coef,false);
                                event_perform(ev_other,ev_user1);    
                            }    
                        }
                        
                        with(crystal_obj)
                        {
                            if(collision_rectangle(other.node.x+other.node_fix,other.node.y-other.beam_small_core_size/2,other.next_node.x+other.next_node_fix,other.node.y+other.beam_small_core_size/2,id,false,false))
                            {
                                receive_damage(other.force/other.small_beam_coef,false);
                                event_perform(ev_other,ev_user1);    
                            }    
                        }
                    }
                }
                facing *= -1;
            }
        }
    }
}


if(instance_exists(my_guy) && object_is_ancestor(my_guy.object_index, guy_obj))
{
    if(my_guy.lost_control)
    {
        my_holder = instance_create(x,y,place_holder_obj);
        ds_list_replace(beam_nodes,0,my_holder.id);
        
        if(force > 0.3)
        {
            force = 0.3;
        }
        
        with(my_guy)
        {   
            self.casting = false;
            self.casting_beam = false;
            charge_ball.firing = false;
            self.have_casted = true;
            alarm[0] = spell_cooldown;
        }
        
    }
}

if(instance_exists(my_ball))
{
    my_ball.charge = force;
}

if(force <= 0)
    instance_destroy();

