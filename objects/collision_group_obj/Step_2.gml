if(!self.resolved)
{
    var count = ds_list_size(members);
    var dig_orig, speed_orig;
    dir_orig[count] = 0;
    speed_orig[count] = 0;
    var cur_item = noone;
    var other_item = noone;
    var total_weight = 0;
    var i = 0;
    var coef = 0.8; // inertia
    
    for(i = count - 1; i >= 0; i--)
    {
        cur_item = ds_list_find_value(members,i);
        if(!instance_exists(cur_item))
        {
            ds_list_delete(members,i);
        }
    }
    
    meeting_terrain = false;
    
    count = ds_list_size(members);
    if(count > 1)
    {
        if(!self.annihilate)
        {
            for(i=0;i<count;i+=1)
            {
                cur_item = members[| i];
                dir_orig[i] = degtorad(cur_item.direction);
                speed_orig[i] = cur_item.speed;
                total_weight += cur_item.radius;
            }
            
            for(i=0;i<count;i+=1)
            {
                cur_item = members[| i];
                
                for(ii=0;ii<count;ii+=1)
                {
                    if(i!=ii)
                    {
                        other_item = members[| ii];
                        
                        speed_size = speed_orig[ii] * coef * (other_item.radius/cur_item.radius / (count-1));
                        
                        cur_item.hspeed += speed_size * cos(dir_orig[ii]);
                        cur_item.vspeed -= speed_size * sin(dir_orig[ii]);
                        
                        other_item.hspeed += -speed_size * cos(dir_orig[ii]);
                        other_item.vspeed -= -speed_size * sin(dir_orig[ii]);
                        
                        /*
                        with(cur_item)
                        {
                            motion_add(dir_orig[ii],speed_orig[ii] );
                        }
                        with(other_item)
                        {
                            motion_add(dir_orig[ii],-speed_orig[ii] * cur_item.radius/other_item.radius / (count-1));
                        }
                        */
                    }
                }  
            }
            self.resolved = true;
        }
        
        
        // BALL MERGING
        /*
        for(i = count - 1; i >= 0; i--)
        {
            cur_item = ds_list_find_value(members,i);
            //count = ds_list_size(members);
            
            if(cur_item != noone)
            {
                for(ii = count-1; ii >= 0; ii--)
                {
                    other_item = ds_list_find_value(members,ii);
                    //show_debug_message("cur_item: " + string(cur_item));
                    //show_debug_message("other_item: " + string(other_item));
                    
                    if(instance_exists(cur_item) && instance_exists(other_item))
                    {
                        if(cur_item.id != other_item.id)
                        {
                            if(abs(cur_item.hspeed-other_item.hspeed) < speed_threshold
                            && abs(cur_item.vspeed-other_item.vspeed) < speed_threshold
                            && cur_item.radius >= other_item.radius)
                            {
                                var new_place_ok = false;
                                var new_x = (cur_item.x + other_item.x)/2;
                                var new_y = (cur_item.y + other_item.y)/2;
                                
                                with(cur_item)
                                {
                                    if(!place_meeting(new_x,new_y,terrain_obj))
                                    {
                                        new_place_ok = true;
                                    }
                                }
                                
                                if(new_place_ok)
                                {
                                    cur_item.x = new_x;
                                    cur_item.y = new_y;
                                }
                                
                                cur_item.speed = 0;
                                cur_item.force = cur_item.force + other_item.force;
                                
                                ds_list_replace(members,ii,noone);
                                with(other_item) 
                                {
                                    instance_destroy();
                                }
                            }
                        }
                    }
                }  
            }
        }
        */
        
        // BALL ANNIHILATION
        if(self.annihilate)
        {
            /*
            force[? base_color] = 0;
            force[? g_white-base_color] = 0;
            
            for(i=0;i<count;i+=1)
            {
                cur_item = ds_list_find_value(members,i);
                force[? cur_item.my_color] += cur_item.force;
            }
            */
            
            if(base_color == g_black)
            {
                for(i=g_red; i<g_white; i++)
                {
                    if(force[? i] > 0)
                    {
                        switch(i)
                        {
                            case g_red:
                            case g_green:
                            case g_blue:
                                base_color = i;
                                break;
                            default:
                                base_color = g_white - i;
                        }
                    }   
                }
            }
            
            ready = false;
            if(ratio_updated && ratio > 0)
            {
                ready = true;
            }
            
            if(!ratio_updated || ratio == 0)
            {
                if(force[? base_color] > 0 && force[? g_white-base_color] > 0)
                    ratio = force[? base_color] / force[? g_white-base_color];
                else
                    ratio = 0;
                ratio_updated = true;
                
                /*
                if(abs(1-ratio) < balance_margin)
                    ready = true;
                */
                if(ratio == 0)
                    self.resolved = true;
            }
            
            if(ready)
            {
                var total_energy = 0;
                var total_x = 0, total_y = 0;
                var object = noone;
                
                for(i = count - 1; i >= 0; i--)
                {
                    cur_item = members[| i];
                    //count = ds_list_size(members);
                    
                    object = cur_item.object_index;
                    
                    total_energy += cur_item.force;
                    total_x += cur_item.x;
                    total_y += cur_item.y;
                                        
                    members[| i] = noone;
                    with(cur_item) 
                    {
                        instance_destroy();
                    }
                }
                
                var explo = instance_create(total_x/count, total_y/count, slot_explosion_obj);
                explo.my_color = g_white;
                explo.my_player = gamemode_obj.environment;
                explo.my_guy = explo;
                explo.my_source = object;
                explo.fire_projectiles = false;
                explo.energy = total_energy;
                my_sound_play(slot_absorbed_sound);
                
                /*
                i = instance_create(other.x,other.y,damage_popup_obj);
                i.damage = total_energy;
                i.my_color = g_white;
                i.tint_updated = false;
                i.source = id;
                */
                
                self.resolved = true;
            }
        }
    }
    if(count == 0)
    {
        instance_destroy();
    }
}
else
{
    instance_destroy();
}
