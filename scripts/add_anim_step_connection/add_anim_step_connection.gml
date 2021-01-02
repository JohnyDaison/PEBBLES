/// @description add_anim_step_connection(duration, from display index/id, to display index/id, type, what, how, scale, [label])
/// @function add_anim_step_connection
/// @param duration
/// @param  from display index/id
/// @param  to display index/id
/// @param  type
/// @param  what
/// @param  how
/// @param  scale
/// @param  [label]
function add_anim_step_connection() {
    var duration = argument[0];
    var from_display = argument[1];
    var to_display = argument[2];
    var type = argument[3];
    var what = argument[4];
    var how = argument[5];
    var scale = argument[6];
    var label = "";
    if(argument_count > 7)
    {
        label = argument[7];
    }

    var from_display_index = -1, from_display_id = "", from_display_type = "";
    var to_display_index = -1, to_display_id = "", to_display_type = "";

    if(is_real(from_display) && from_display >= 0)
    {
        from_display_index = from_display;
        from_display_type = "index";
    }
    else if(is_string(from_display) && from_display != "")
    {
        from_display_id = from_display;
        from_display_type = "id";   
    }

    if(is_real(to_display) && to_display >= 0)
    {
        to_display_index = to_display;
        to_display_type = "index";
    }
    else if(is_string(to_display) && to_display != "")
    {
        to_display_id = to_display;
        to_display_type = "id";   
    }

    if(duration > 0 && from_display_type != "" && to_display_type != "" && is_string(type))
    {
        var from_disp_obj = undefined, to_disp_obj = undefined, done = false;
    
        /*
        if(from_display_type == "index")
        {
            from_disp_obj = self.order[? from_display_index];
        }
        else if(from_display_type == "id")
        {
            from_disp_obj = self.member_ids[? from_display_id];
        }
        */
        from_disp_obj = find_display_instance(from_display_type, from_display_index, from_display_id);
    
        /*
        if(to_display_type == "index")
        {
            to_disp_obj = self.order[? to_display_index];
        }
        else if(to_display_type == "id")
        {
            to_disp_obj = self.member_ids[? to_display_id];
        }
        */
        to_disp_obj = find_display_instance(to_display_type, to_display_index, to_display_id);
    
        if(!is_undefined(from_disp_obj) && instance_exists(from_disp_obj) && !is_undefined(to_disp_obj) && instance_exists(to_disp_obj))
        {
            var map = ds_map_create();
            map[? "step_type"] = "connection";
            map[? "duration"] = duration;
            map[? "from_display_type"] = from_display_type;
            map[? "from_display_index"] = from_display_index;
            map[? "from_display_id"] = from_display_id;
            map[? "to_display_type"] = to_display_type;
            map[? "to_display_index"] = to_display_index;
            map[? "to_display_id"] = to_display_id;
            map[? "type"] = type;
            map[? "what"] = what;
            map[? "how"] = how;
            map[? "scale"] = scale;
            map[? "label"] = label;
            
            if(type != "empty") {
                if(is_undefined(self.visible_steps_total[? disp_obj.id])) {
                    self.visible_steps_total[? disp_obj.id] = 0;
                }
                
                if(type != "pause") {
                    self.visible_steps_total[? disp_obj.id] += 1;
                }
                
                map[? "visible_index"] = self.visible_steps_total[? disp_obj.id];
            }
        
            ds_list_add(self.steps, map);
            done = true;
        }
    
        if(done)
        {
            self.steps_total += 1;
            self.duration_total += duration;
        }
    }
}
