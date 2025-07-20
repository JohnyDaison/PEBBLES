/// @description object_out_of_view(obj, camera)
/// @function object_out_of_view
/// @param {Id.Instance} obj
/// @param {Id.Instance} camera
function object_out_of_view(obj, camera) {
    var ret = false;

    if(instance_exists(obj) && instance_exists(camera))
    {
        var obj_x = obj.x;
        var obj_y = obj.y;
        if(obj.obj_center_offset)
        {
            obj_x += obj.obj_center_xoff;
            obj_y += obj.obj_center_yoff;
        }
        var x_diff = obj_x - camera.x;
        var y_diff = obj_y - camera.y;
        var rad_coef = 1;
        var buffer_size = 0;
    
        var half_width = __view_get( e__VW.WView, camera.view )/2;
        var half_height = __view_get( e__VW.HView, camera.view )/2;
    
        if(other.id == camera)
        {
            x_diff *= 0.9;
            y_diff *= 0.9;
        
            buffer_size = 48;
        
            rad_coef *= 1.2;
        }
    
        if((abs(x_diff) - obj.radius*rad_coef) > (half_width + buffer_size - camera.border_width/camera.zoom_level)
        || (abs(y_diff) - obj.radius*rad_coef) > (half_height + buffer_size - camera.border_width/camera.zoom_level))
        {
            if(other.object_index == radial_overlay)
            {
                radial_gui_dir = point_direction(0,0,x_diff, y_diff);
                radial_gui_x = other.x + lengthdir_x(other.gui_radius, radial_gui_dir);
                radial_gui_y = other.y + lengthdir_y(other.gui_radius, radial_gui_dir);
            }
        
            ret = true;
        }
    }

    return ret;
}
