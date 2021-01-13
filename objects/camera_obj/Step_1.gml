/// @description  FOLLOW AND ZOOM
if(on && view != -1)
{
    //show_debug_message("CAMERA "+string(view)+" ON");
    last_zoom_level = zoom_level;
    var camera = view_get_camera(view);
    var view_x = camera_get_view_x(camera);
    var view_y = camera_get_view_y(camera);
    var view_width = camera_get_view_width(camera);
    var view_height = camera_get_view_height(camera);
    
    // FOLLOW GUY
    if(follow_guy && instance_exists(my_guy))
    {
        followed_x = my_guy.x + my_guy.hspeed;
        followed_y = my_guy.y + my_guy.vspeed;
        box_xoffset = -2*my_guy.hspeed;
        box_yoffset = -2*my_guy.vspeed;
        
        //speed_threshold = my_guy.running_maxspeed +1;
        //speed_threshold = 10;
        speed_threshold = DB.max_jump_pad_power;
        
        var ratio;
        if(my_guy.object_index != place_holder_obj && my_guy.max_speed > 0)
        {
            ratio = clamp((speed-speed_threshold)/speed_threshold, 0,1); 
        }
        else
        {
            ratio = 0;
        }
        
        var des_zoom = lerp(normal_zoom,min_zoom,ratio);
        var dir = sign(des_zoom-zoom_level);
        if(stop_zoom)
            dir = 0;

        zoom_level = clamp(zoom_level + dir*zoom_speed, min_zoom, normal_zoom);
        
        if(my_guy.wanna_look)
        {
            if(my_guy.hor_dir_held)
            {
                box_xoffset = -my_guy.facing*guy_hor_dist;
            }
            if(my_guy.looking_up)
            {
                box_yoffset = guy_ver_dist;
            }
            if(my_guy.looking_down)
            {
                box_yoffset = -guy_ver_dist;
            }
            
            var ratio = clamp((my_guy.step_count - (my_guy.look_start + look_zoom_delay*singleton_obj.game_speed))/30, 0,1);
            var des_zoom = lerp(normal_zoom, look_zoom, ratio);
            zoom_level = des_zoom;
            if(my_guy.aim_dist > 0)
            {
                followed_x += lengthdir_x(/*2**/guy_hor_dist, my_guy.aim_dir); //*(1-zoom_level)
                followed_y += lengthdir_y(/*2**/guy_ver_dist, my_guy.aim_dir); //*(1-zoom_level)
            }
        }
        
    }
    
    // FOLLOW SPAWNER 
    if(follow_spawner && instance_exists(my_spawner))
    {
        followed_x = my_spawner.x;
        followed_y = my_spawner.y;
        box_xoffset = 0;
        box_yoffset = 0;
        
        var dir = sign(normal_zoom-zoom_level);
        if(stop_zoom)
            dir = 0;

        zoom_level = clamp(zoom_level + dir*zoom_speed, min_zoom, normal_zoom);
    }
    
    // FOLLOW SHOT
    if(follow_shot)
    {
        if(instance_exists(my_shot))
        {
            followed_x = my_shot.x + my_shot.hspeed;
            followed_y = my_shot.y + my_shot.vspeed;
            box_xoffset = -3*my_shot.hspeed;
            box_yoffset = -3*my_shot.vspeed;
            if(my_guy.max_speed > 0)
            {
                var ratio = speed/my_guy.max_speed;
                var des_zoom = lerp(normal_zoom,min_zoom,ratio);
                var dir = sign(des_zoom-zoom_level);
                zoom_level += dir*zoom_speed;
            }
            if(alarm[1] < 0)
            {
                alarm[1] = 300;
            }
        }
        else if(my_shot != noone)
        {
            follow_shot = false;
            alarm[1] = 20;
        }   
    }
    else
    {
        my_shot = noone;
    }
    
    // FOLLOW OVERRIDE
    if(follow_override && instance_exists(my_override))
    {
        followed_x = my_override.x;
        followed_y = my_override.y;
        box_xoffset = 0;
        box_yoffset = 0;
        
        var dir = sign(normal_zoom-zoom_level);
        if(stop_zoom)
            dir = 0;

        zoom_level = clamp(zoom_level + dir*zoom_speed, min_zoom, normal_zoom);
    }
    
    var half_xsize = box_xsize / 2;
    var half_ysize = box_ysize / 2;
    var x_margin = view_width/2 - half_xsize;
    var y_margin = view_height/2 - half_ysize;
    
    followed_x = clamp(followed_x, x_margin, room_width - x_margin);
    followed_y = clamp(followed_y, y_margin, room_height - y_margin);
                    
    x_dist = followed_x-(x+box_xoffset);
    y_dist = followed_y-(y+box_yoffset);
    
    move_speed_x = move_speed_coef * x_dist;
    move_speed_y = move_speed_coef * y_dist;
    
    // speed tweening
    /*
    var spd_diff;
    var delta = move_delta * sqrt(max(1, delta_coef * move_speed_x));
    
    if(move_speed_x != desired_move_speed_x) {
        spd_diff = desired_move_speed_x - move_speed_x;
        if(abs(spd_diff) > delta)
        {
            if(abs(spd_diff) > reverse_coef*delta && sign(desired_move_speed_x) != sign(move_speed_x))
            {
                delta *= reverse_coef;
            }
            
            spd_diff = sign(spd_diff)*delta;
        }
        
        move_speed_x += spd_diff;
    }
    
    delta = move_delta * sqrt(max(1, delta_coef * move_speed_y));
    
    if(move_speed_y != desired_move_speed_y) {
        spd_diff = desired_move_speed_y - move_speed_y;
        if(abs(spd_diff) > delta)
        {
            if(abs(spd_diff) > reverse_coef*delta && sign(desired_move_speed_y) != sign(move_speed_y))
            {
                delta *= reverse_coef;
            }
            
            spd_diff = sign(spd_diff)*delta;
        }
        
        move_speed_y += spd_diff;
    }
    */
    
    /*    
    show_debug_message("camera xspeed: "+string(move_speed_x));
    show_debug_message("camera yspeed: "+string(move_speed_y));
    */
    
    
    
    // BOX CHECK
    hspeed = 0;
    if(abs(x_dist) > half_xsize)
    {
        if(abs(x_dist-move_speed_x) > half_xsize)
        {
            if((x_dist < 0 && view_x > 0)
            || (x_dist > 0 && view_x < room_width - view_width))
                hspeed = move_speed_x;   
        }
        else
        {
            x = followed_x-box_xoffset - sign(x_dist)*half_xsize;   
        }
    }
    
    vspeed = 0;
    if(abs(y_dist) > half_ysize)
    {
        if(abs(y_dist-move_speed_y) > half_ysize)
        {
            if((y_dist < 0 && view_y > 0)
            || (y_dist > 0 && view_y < room_height - view_height))
                vspeed = move_speed_y;   
        }
        else
        {
            y = followed_y-box_yoffset - sign(y_dist)*half_ysize;      
        }
    }   
    
    // ZOOMING
    
    
    /*
    if(zoom_out)
    {
        zoom_level = max(min_zoom, zoom_level-zoom_speed);
    }
    else
    {
        zoom_level = min(1, zoom_level+zoom_speed);
    }
    */

    var zoom_changed = false;
    
    if(last_zoom_level != zoom_level)
    {
        zoom_changed = true;
    }
    
    // APPLY CHANGES
    if(view_enabled)
    {
        if(camera_get_view_target(camera) != id)
        {
            camera_set_view_target(camera, id);
            update_display();
        }
        
        if(zoom_changed)
        {
            update_display();
        }
        
        var old_x = x;
        var old_y = y;
            
        view_x = x - view_width/2; 
        view_y = y - view_height/2;
        
        view_x = clamp(view_x, 0, room_width - view_width);
        view_y = clamp(view_y, 0, room_height - view_height);
        
        camera_set_view_pos(camera, view_x, view_y);
            
        x = view_x + view_width/2; 
        y = view_y + view_height/2;
        
        
        stop_zoom = false;
        
        if(old_x != x)
        {
            hspeed = 0; 
        }
        
        if(old_x != x && (view_x == 0 || (view_x + view_width) >= room_width))
        {
            stop_zoom = true;
            shake_dist = 0;
        }
        
        if(old_y != y)
        {
            vspeed = 0;    
        }
        
        if(old_y != y && (view_y == 0 || (view_y + view_height) >= room_height))
        {
            stop_zoom = true;
            shake_dist = 0;
        }
        
        x_dist = followed_x-(x+box_xoffset);
        y_dist = followed_y-(y+box_yoffset);
        

        view_set_visible(view, true);
        
        if(view == 0 || view == 1)
        {
            camera_before_view();
        }
        
    } 
}
if(!on && view > -1)
{
    view_set_visible(view, false);
}
