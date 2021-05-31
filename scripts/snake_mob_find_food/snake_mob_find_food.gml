/// @description snake_mob_find_food();
/// @function snake_mob_find_food
function snake_mob_find_food() {
    var nearest_ter = noone;
    var min_dist = -1;
    var head = ter_group.members[| 0];

    if(!instance_exists(self.eat_target)
        || self.eat_target.moving || self.eat_target.falling)
    {
        self.eat_target = noone;
    }

    if(is_undefined(head) || !instance_exists(head) || head.my_list = noone)
    {
        return false;
    }

    if(instance_exists(eat_target))
    {
        var dir = point_direction(head.x,head.y, eat_target.x, eat_target.y);
        if(dir == travel_direction || (head.x+x_step == eat_target.x && head.y+y_step == eat_target.y))
        {
            return true;
        }
    }

    var xx, yy, ter_list, count, ter_i, ter, ii, dist, dir, coll_off = 24, coll, line_x1, line_y1, line_x2, line_y2, surround_count, food_count, body_count, sur_ter;

    var min_x = max(head.grid_x - grid_sight_distance, 0);
    var max_x = min(head.grid_x + grid_sight_distance, my_grid.grid_width-1);
    var min_y = max(head.grid_y - grid_sight_distance, 0);
    var max_y = min(head.grid_y + grid_sight_distance, my_grid.grid_height-1);

    for(xx = min_x; xx <= max_x; xx++)
    {
        for(yy = min_y; yy <= max_y; yy++)
        {
            ter_list = ds_grid_get(my_grid.terrain_grid, xx, yy);
            count = ds_list_size(ter_list);
        
            for(ter_i = 0; ter_i < count; ter_i++)
            {
                ter = ter_list[| ter_i];
            
                if(instance_exists(ter) && ter.object_index == wall_obj && ter.cover != cover_indestr && !(ter.moving || ter.falling))
                {
                    dist = point_distance(head.x + x_step, head.y + y_step, ter.x, ter.y);
                    coll = noone;
                
                    if(dist > 2*coll_off)
                    {
                        dir = point_direction(head.x, head.y, ter.x, ter.y);
                    
                        x_off = sign(lengthdir_x(dist, dir))*coll_off;
                        y_off = sign(lengthdir_y(dist, dir))*coll_off;
                    
                        line_x1 = head.x+15 + x_off;
                        line_y1 = head.y+15 + y_off;
                    
                        line_x2 = ter.x+15 - x_off;
                        line_y2 = ter.y+15 - y_off;
                    
                        coll = collision_line(line_x1, line_y1, line_x2, line_y2, terrain_obj, false, false);
                    }

                    if((coll == noone || (coll.object_index == grate_block_obj && !instance_exists(eat_target)))
                    && (dist < min_dist || min_dist == -1))
                    {
                        surround_count = 0;
                        food_count = 0;
                        body_count = 0;
                    
                        for(ii=0; ii<4; ii++)
                        {
                            sur_ter = instance_nearest(ter.x + DB.terrain_xx[? ii], ter.y + DB.terrain_yy[? ii], terrain_obj);
                            if(sur_ter.x == ter.x + DB.terrain_xx[? ii] && sur_ter.y == ter.y + DB.terrain_yy[? ii])
                            {
                                if(sur_ter.object_index == wall_obj && sur_ter.cover != cover_indestr)
                                {
                                     if(sur_ter.moving)
                                     {
                                        body_count++;
                                        if(sur_ter.id != head.id)
                                        {
                                            surround_count++;
                                        }
                                     }
                                     else if(!sur_ter.falling)
                                     {
                                        food_count++;
                                     }
                                }
                                else
                                {
                                    surround_count++;
                                }
                            }
                        }
                    
                        if(surround_count < 3)
                        {
                            nearest_ter = ter.id;
                            min_dist = dist;
                        }
                    }
                }
            }
        }
    }

    if(instance_exists(nearest_ter))
    {
        //var new_dist = point_distance(head.x+x_step, head.y+y_step, nearest_ter.x, nearest_ter.y)
        var change_target = false;
    
        if(instance_exists(self.eat_target))
        {
            var old_dist = point_distance(head.x+x_step, head.y+y_step, eat_target.x, eat_target.y);
            if(old_dist > body_size // body_size*32 maybe?, or new_dist?
                || (eat_target.x == head.x+x_step && sign(eat_target.y - (head.y+y_step)) == sign(y_step))
                || (eat_target.y == head.y+y_step && sign(eat_target.x - (head.x+x_step)) == sign(x_step))
                /*|| (eat_target.x == head.x+x_step && eat_target.y == head.y+y_step)*/)
            {
                change_target = true;
            }
        }
        else
        {
            change_target = true;
        }
    
    
        if(change_target)
        {
            self.eat_target = nearest_ter.id;
        }
        return true;
    }
    else
    {
        return false;
    }
}
