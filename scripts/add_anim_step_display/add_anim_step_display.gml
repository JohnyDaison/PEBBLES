/// @description add_anim_step_display(duration, display index/id, type, what, how, scale, [label], [sublabel])
/// @function add_anim_step_display
/// @param duration
/// @param  display index/id
/// @param  type
/// @param  what
/// @param  how
/// @param  scale
/// @param  [label]
/// @param  [sublabel]
function add_anim_step_display() {
    var duration = argument[0];
    var display = argument[1];
    var type = argument[2];
    var what = argument[3];
    var how = argument[4];
    var scale = argument[5];
    var label = "";
    var sublabel = "";
    if(argument_count > 6)
    {
        label = argument[6];
    }
    if(argument_count > 7)
    {
        sublabel = argument[7];
    }


    var display_index = -1, display_id = "", display_type = "";

    if(is_real(display) && display >= 0)
    {
        display_index = display;
        display_type = "index";
    }
    else if(is_string(display) && display != "")
    {
        display_id = display;
        display_type = "id";   
    }

    if(duration > 0 && display_type != "" && is_string(type))
    {
        var disp_obj = undefined, done = false;
    
        /*
        if(display_type == "index")
        {
            disp_obj = self.order[? display_index];
        }
        else if(display_type == "id")
        {
            disp_obj = self.member_ids[? display_id];
        }
        */
        disp_obj = find_display_instance(display_type, display_index, display_id);
    
    
        if(!is_undefined(disp_obj) && instance_exists(disp_obj))
        {
            var map = ds_map_create();
            map[? "step_type"] = "display";
            map[? "duration"] = duration;
            map[? "display_type"] = display_type;
            map[? "display_index"] = display_index;
            map[? "display_id"] = display_id;
            map[? "type"] = type;
            map[? "what"] = what;
            map[? "how"] = how;
            map[? "scale"] = scale;
            map[? "label"] = label;
            map[? "sublabel"] = sublabel;
            
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
