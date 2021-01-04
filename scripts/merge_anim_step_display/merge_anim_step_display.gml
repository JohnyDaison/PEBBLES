function merge_anim_step_display(display) {
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

    if(display_type != "")
    {
        var disp_obj = undefined;
    
        disp_obj = find_display_instance(display_type, display_index, display_id);
        
        if(!is_undefined(self.visible_steps_total[? disp_obj.id])) {
            self.visible_steps_total[? disp_obj.id]--;
        }
    }
}
