function play_control_state_display(display, control, control_type, state, time) {
    if(control_type == "button")
    {
        display.fg_sprite = noone;
        display.sprite = noone;
        display.bg_sprite = round_button_bg_spr;
        display.main_tint = DB.colormap[? g_white];
        display.fg_tint = DB.colormap[? g_white];
    
        if(control = "A_button")
        {
            display.fg_sprite = A_button_face_spr;
            display.bg_tint = DB.colormap[? g_green];
        }
        else if(control = "B_button")
        {
            display.fg_sprite = B_button_face_spr;
            display.bg_tint = DB.colormap[? g_red];
        }
        else if(control = "X_button")
        {
            display.fg_sprite = X_button_face_spr;
            display.bg_tint = DB.colormap[? g_blue];
        
        }
        else if(control = "Y_button")
        {
            display.fg_sprite = Y_button_face_spr;
            display.bg_tint = DB.colormap[? g_yellow];
        }
        else if(control = "analog_stick_button")
        {
            display.fg_sprite = noone;
            display.sprite = analog_stick_main_spr;
            display.bg_sprite = analog_stick_bg_spr;
            display.bg_tint = DB.colormap[? g_white];
        }
        else if(control = "back_button")
        {
            display.fg_sprite = back_button_arrow_spr;
            display.bg_sprite = back_button_bg_spr;
            display.bg_tint = DB.colormap[? g_white];
        }
        else if(control = "start_button")
        {
            display.fg_sprite = start_button_arrow_spr;
            display.bg_sprite = back_button_bg_spr;
            display.bg_tint = DB.colormap[? g_white];
        }
    
        if(state == "held")
        {
            if(display.bg_sprite == round_button_bg_spr)
            {
                display.sprite = round_button_highlight_spr;
            }
        
            if(display.bg_sprite == analog_stick_bg_spr)
            {
                display.sprite = analog_stick_highlight_spr;
            }
            
            if(display.bg_sprite == back_button_bg_spr)
            {
                display.sprite = back_button_highlight_spr;
            }
        }
        else
        {
            if(display.bg_sprite != analog_stick_bg_spr)
            {
                display.sprite = noone;   
            }
        }
    
        display.sprite_step = sign(state == "held");
        display.bg_sprite_xx = 0;
        display.bg_sprite_yy = 0;
        display.sprite_xx = 0;
        display.sprite_yy = 0;
    }

    if(control_type == "bumper")
    {
        display.bg_sprite = bumper_button_bg_spr;
        display.fg_tint = DB.colormap[? g_white];
        display.main_tint = DB.colormap[? g_white];
        display.bg_tint = DB.colormap[? g_black];
    
        if(control = "R_bumper")
        {
            display.fg_sprite = R_bumper_face_spr;
        }
        else if(control = "L_bumper")
        {
            display.fg_sprite = L_bumper_face_spr;
        }
    
        if(state == "held")
        {
            display.sprite = bumper_button_highlight_spr;
        }
        else
        {
            display.sprite = noone;   
        }
    
        display.sprite_step = sign(state == "held");
        display.bg_sprite_xx = 0;
        display.bg_sprite_yy = 0;
        display.sprite_xx = 0;
        display.sprite_yy = 0;
    }

    if(control_type == "trigger")
    {
        display.bg_sprite = gamepad_trigger_bg_spr;
        display.fg_tint = DB.colormap[? g_white];
        display.main_tint = DB.colormap[? g_white];
        display.bg_tint = DB.colormap[? g_black];
    
        if(control = "R_trigger")
        {
            display.fg_sprite = R_trigger_face_spr;
        }
        else if(control = "L_trigger")
        {
            display.fg_sprite = L_trigger_face_spr;
        }
    
        if(state == "held")
        {
            display.sprite = gamepad_trigger_highlight_spr;
        }
        else
        {
            display.sprite = noone;   
        }
    
        display.sprite_step = sign(state == "held");
        display.bg_sprite_xx = 0;
        display.bg_sprite_yy = 0;
        display.sprite_xx = 0;
        display.sprite_yy = 0;
    }

    if(control_type == "analog_stick")
    {
        var aim = false, dirstate = "";
    
        display.fg_sprite = noone;
        display.bg_tint = DB.colormap[? g_white];
        display.main_tint = DB.colormap[? g_white];
        display.fg_tint = DB.colormap[? g_white];
    
        display.bg_sprite_xx = 0;
        display.bg_sprite_yy = 0;
    
        if(string_pos("aim", state) == 1)
        {
            dirstate = string_delete(state, 1, 3);
            aim = true;
        }
        else
        {
            dirstate = state;
        }
        
        var from_dir, to_dir;
        var dir_list = ds_list_create();
        var dir_count = string_explode(dirstate, "to", dir_list)
        
        from_dir = dir_list[| 0];
        to_dir = dir_list[| 0];
        
        if(dir_count > 1) {
            to_dir = dir_list[| 1];
        }
        
        ds_list_destroy(dir_list);
    
        if(control = "Xbox_stick")
        {
            display.sprite = analog_stick_main_spr;
            if(aim)
            {
                display.sprite = analog_stick_highlight_spr;
            }
            display.bg_sprite = analog_stick_bg_spr;
        }
    
        display.sprite_step = 0;
        var stick_offset = 16;
        var from_vector = control_dir_to_vector(from_dir, stick_offset);
        var to_vector = control_dir_to_vector(to_dir, stick_offset);
        
        display.sprite_xx = lerp(from_vector.x, to_vector.x, sqrt(time));
        display.sprite_yy = lerp(from_vector.y, to_vector.y, sqrt(time));
    }

    if(control_type == "DPad")
    {
        display.fg_sprite = noone;
        display.sprite = DPad_outline_spr;
        display.bg_sprite = DPad_bg_spr;
        display.bg_tint = c_gray; //DB.colormap[? g_black];
        display.main_tint = DB.colormap[? g_white];
        display.fg_tint = DB.colormap[? g_white];
        display.sprite_xx = 0;
        display.sprite_yy = 0;
    
        if(control = "DPad_Up")
        {
            display.fg_sprite = DPad_Up_button_highlight_spr;
        }
    
        if(control = "DPad_Left")
        {
            display.fg_sprite = DPad_Left_button_highlight_spr;
        }
    
        if(state != "held")
        {
            display.fg_sprite = noone;
        }
    }

    if(control_type == "abstract")
    {
        display.bg_sprite_xx = 0;
        display.bg_sprite_yy = 0;
        display.sprite_xx = 0;
        display.sprite_yy = 0;
        display.bg_sprite = noone;
        display.fg_sprite = noone;
    
        display.main_tint = DB.colormap[? g_white];
    
        if(control == "arrow")
        {
            display.sprite = directions_info_spr;
        }
        else if(control == "move_lock")
        {
            display.sprite = move_lock_icon;
        }
        else if(control == "color")
        {
            display.fg_sprite = round_button_highlight_spr;
            display.sprite = noone;
            display.bg_sprite = round_button_bg_spr;
        
            display.main_tint = DB.colormap[? state];
            display.fg_tint = DB.colormap[? state];
        }
    
    
        switch(state)
        {
            case "right":
                display.sprite_step = 0;
                break;
            case "up":
                display.sprite_step = 1;
                break;
            case "left":
                display.sprite_step = 2;
                break;
            case "down":
                display.sprite_step = 3;
                break;
        }
    }
}
