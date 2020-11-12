/// @description play_anim_set(current_step)
/// @function play_anim_set
/// @param current_step
function play_anim_set(argument0) {
	var current_step = argument0; //singleton_obj.step_count

	var i, temp_dur = 0, duration;
	if(self.steps_total > 0 && self.duration_total > 0 && current_step >= 0)
	{
	    if(loop)
	    {
	        current_step = current_step mod self.duration_total;
	    }
    
	    if(current_step >= 0 && current_step < self.duration_total)
	    {
	        for(i=0; i<self.steps_total; i++)
	        {
	            step = self.steps[| i];
	            duration = step[? "duration"];
	            var step_type = step[? "step_type"];
	            var disp_obj = undefined, done = false;
            
	            if(step_type == "display")
	            {
	                disp_obj = find_display_instance(step[? "display_type"], step[? "display_index"], step[? "display_id"]);
                
	                target_disp = disp_obj;
	            }
            
	            if(step_type == "connection")
	            {
	                disp_obj = find_display_instance(step[? "from_display_type"], step[? "from_display_index"], step[? "from_display_id"]);
                
	                target_disp = find_display_instance(step[? "to_display_type"], step[? "to_display_index"], step[? "to_display_id"]);
	            }
            
	            if(current_step >= temp_dur && current_step < temp_dur+duration)
	            {
	                var step_type = step[? "step_type"];
	                var type = step[? "type"];
	                var what = step[? "what"];
	                var how = step[? "how"];
	                var scale = step[? "scale"];
	                var label = step[? "label"];
	                var sublabel = step[? "sublabel"];
	                if(is_undefined(sublabel))
	                {
	                    sublabel = "";
	                }
                
	                var time = (current_step-temp_dur)/duration;
  
	                if(instance_exists(disp_obj))
	                {
	                    var puppet = "";
	                    var control = "";
	                    var control_type = "";
	                    var state = "";
	                    var text = "";
	                    var style = "";
                    
	                    disp_obj.main_label = "";
	                    disp_obj.single_text_mode = false;
                    
	                    if(type = "empty")
	                    {
	                        //clear_display(disp_obj);
	                        empty_display(disp_obj);
	                    }
	                    else if(type == "control")
	                    {
	                        switch(what)
	                        {
	                            case "jump":
	                                control = "A_button";
	                                control_type = "button";
	                                break;
                                
	                            case "red":
	                                control = "B_button";
	                                control_type = "button";
	                                break;
                                
	                            case "green":
	                                control = "Y_button";
	                                control_type = "button";
	                                break;
                                
	                            case "blue":
	                                control = "X_button";
	                                control_type = "button";
	                                break;
                                
	                            case "cast":
	                                control = "R_trigger";
	                                control_type = "trigger";
	                                break;
                                
	                            case "channel":
	                                control = "L_trigger";
	                                control_type = "trigger";
	                                break;
                                
	                            case "alt_fire":
	                                control = "R_bumper";
	                                control_type = "bumper";
	                                break;
                                
	                            case "ability":
	                                control = "L_bumper";
	                                control_type = "bumper";
	                                break;
                                
	                            case "direction":
	                                control = "Xbox_stick";
	                                control_type = "analog_stick";
	                                state = how;
	                                break; 
                                
	                            case "look":
	                                control = "analog_stick_button";
	                                control_type = "button";
	                                break;
                            
	                            case "move_lock":
	                                control = "move_lock";
	                                control_type = "abstract";
	                                state = "right";
	                                break;
                                
	                            case "inventory_1":
	                                control = "DPad_Up";
	                                control_type = "DPad";
	                                break;
                                
	                            case "inventory_2":
	                                control = "DPad_Left";
	                                control_type = "DPad";
	                                break;
                                
	                            case "color":
	                                control = "color";
	                                control_type = "abstract";
	                                state = how;
	                                break;
                                    
                                case "colorinfo":
	                                control = "back_button";
	                                control_type = "button";
	                                break;
                                    
                                case "pause":
	                                control = "start_button";
	                                control_type = "button";
	                                break;
	                        }
                        
	                        switch(how)
	                        {
	                            case "click":
	                                state = anim_control_click_action(time);
	                                break;
                                
	                            case "doubleclick":
	                                state = anim_control_doubleclick_action(time);
	                                break;
                                
	                            case "press":
	                                state = anim_control_press_action(time);
	                                break;
                                
	                            case "hold":
	                                state = anim_control_hold_action(time);
	                                break;
                                
	                            case "release":
	                                state = anim_control_release_action(time);
	                                break;
                                
	                            case "free":
	                                state = "free";
	                                break;
	                        }
	                    }
	                    else if(type == "anim")
	                    {
	                        puppet = what;
	                        state = how;
	                    }
                    
	                    if(type == "text")
	                    {
	                        disp_obj.ready = true;
	                        disp_obj.active = true;
	                        disp_obj.label_offset = 0;
	                        disp_obj.sublabel_offset = 8;
	                        if(what == "heading")
	                        {
	                            disp_obj.heading_label = label;
	                        }
	                        else
	                        {
	                            disp_obj.main_label = label;
	                            disp_obj.sub_label = sublabel;
	                            if(sublabel == "")
	                            {
	                                disp_obj.single_text_mode = true;
	                            }
	                        }
	                    }
                    
	                    if(control != "" && control_type != "" && state != "")
	                    {
	                        disp_obj.ready = true;
	                        disp_obj.active = true;
	                        disp_obj.anim_scale = scale;
	                        disp_obj.main_label = label;
	                        disp_obj.sub_label = sublabel;
	                        play_control_state_display(disp_obj.id, control, control_type, state);
	                    }
                    
	                    if(puppet != "" && state != "")
	                    {
	                        disp_obj.ready = true;
	                        disp_obj.active = true;
	                        disp_obj.anim_scale = scale;
	                        disp_obj.main_label = label;
	                        disp_obj.sub_label = sublabel;
	                        play_anim_state_display(disp_obj.id, puppet, state);
	                    }
                    
	                    if(step_type == "connection")
	                    {
	                        x_diff = target_disp.x - disp_obj.x;
	                        y_diff = target_disp.y - disp_obj.y;
                        
	                        disp_obj.sprite_xx += x_diff*time;
	                        disp_obj.sprite_yy += y_diff*time;
	                        disp_obj.main_label = label;
	                        disp_obj.sub_label = sublabel;
	                    }
                    
	                    disp_obj.label_offset = 0;
	                    disp_obj.sublabel_offset = 0;
                    
	                    if(sprite_exists(disp_obj.bg_sprite))
	                    {
	                        disp_obj.label_offset = min(disp_obj.label_offset, -sprite_get_yoffset(disp_obj.bg_sprite));
	                        disp_obj.sublabel_offset = max(disp_obj.sublabel_offset, sprite_get_height(disp_obj.bg_sprite) - sprite_get_yoffset(disp_obj.bg_sprite));
	                    }
                    
	                    if(sprite_exists(disp_obj.sprite))
	                    {
	                        disp_obj.label_offset = min(disp_obj.label_offset, -sprite_get_yoffset(disp_obj.sprite));
	                        disp_obj.sublabel_offset = max(disp_obj.sublabel_offset, sprite_get_height(disp_obj.sprite) - sprite_get_yoffset(disp_obj.sprite));
	                    }
                    
	                    if(sprite_exists(disp_obj.fg_sprite))
	                    {
	                        disp_obj.label_offset = min(disp_obj.label_offset, -sprite_get_yoffset(disp_obj.fg_sprite));
	                        disp_obj.sublabel_offset = max(disp_obj.sublabel_offset, sprite_get_height(disp_obj.fg_sprite) - sprite_get_yoffset(disp_obj.fg_sprite));
	                    }
                    
	                    if(disp_obj.label_offset != 0)
	                    {
	                        disp_obj.label_offset -= 4;
	                    }
                    
                    
	                }  
	            }
            
	            temp_dur += duration;
	        }
	    }
    
	}



}
