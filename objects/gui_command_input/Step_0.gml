if(visible)
{
    if(enabled)
    {
        if(self.bg_color == self.disabled_color)
        {
            self.bg_color = self.base_bg_color;
        }
    
        if(cursor_obj.x>=x && cursor_obj.x<=(x+self.width)
        && cursor_obj.y>=y && cursor_obj.y<=(y+self.height)
        && DB.mouse_has_moved)
        {
            mouse_over = true;
            if(!focused) gui_get_focus();
        }
        else
        {
            if(!active && mouse_over && focused)
            {
                gui_lose_focus();
            }
            mouse_over = false;  
        }
    
        if(focused)
        {   
            if((mouse_check_button_released(mb_left) && mouse_over) || (DB.gui_controls[# confirm,released] && (!mouse_over || active)))
            {   
                if(!self.active)
                {
                    if(self.text == self.prompt_str)
                    {
                        keyboard_string = "";    
                    }
                    else
                    {
                        keyboard_string = self.text;
                    }

                    //gui_dropdown_script();
                }
                if(was_active)
                {             
                    self.text = keyboard_string;
                    parse_user_command();
                    command_history_index = -1;
                    //gui_dropdown_script();
                }
                self.active = !self.active;
                self.depressed = self.active;
                my_sound_play(click_sound);    
            }
        }
    
        if(!mouse_over && mouse_check_button_released(mb_left))
        {
            focused = false;
        }
    
        if(!focused && had_focus)
        {
            if(was_active)
            {             
                self.text = keyboard_string;
            }
            self.active = false;
            self.depressed = false;
            self.bg_color = self.base_bg_color;
        }
    
        if(self.depressed)
        { 
            self.bg_color = self.depressed_color;
        }
        if(!self.depressed && focused)
        {
            self.bg_color = self.highlight_color;
        }
    
        if(!had_focus && focused)
            my_sound_play(blip_sound);
 
        if(depressed)
        {
            if(string_length(keyboard_string) > self.max_chars)
            {
                keyboard_string = string_copy(keyboard_string,0,self.max_chars);
            }
        
            var space_index = string_pos(" ", keyboard_string);
        
            var tab_key = keyboard_check_pressed(vk_tab);
            var up_key = keyboard_check_pressed(vk_up);
            var down_key = keyboard_check_pressed(vk_down);
        
            if(!history_mode && tab_key) 
            {
                if(space_index == 0)
                {
                    var list = DB.console_modes[? DB.console_mode], count = ds_list_size(list);
                    var command = self.text, index = ds_list_find_index(list, command), i, start;
            
                    start = (index + 1) mod count;
            
                    for(i=0; i < count; i++)
                    {
                        index = (start + i) mod count;
                        command = list[| index];
                        if(string_pos(tab_text, command) == 1)
                        {
                            self.tab_mode = true;
                            self.text = command;
                            break;
                        }
                    }
                }
            }
            else if(!tab_mode && (up_key || down_key))
            {
                var dir = 0, count = ds_list_size(DB.console_command_history);
                var last_index = count - 1;
                
                if(up_key)
                    dir--;
                if(down_key)
                    dir++;
                
                if(count > 0) {
                    if(command_history_index == -1)
                        command_history_index = last_index;
                
                    if(history_mode)
                    {
                        command_history_index += dir;
                        
                        if (command_history_index < 0)
                            command_history_index = 0;
                            
                        if (command_history_index > last_index)
                            command_history_index = last_index;
                    }
                
                    self.text = DB.console_command_history[| command_history_index];
                    history_mode = true;
                }
            
            }
            else if(keyboard_check_pressed(vk_anykey))
            {
                if(tab_mode || history_mode)
                {
                    var end_str = string_lettersdigits(keyboard_lastchar);
                
                    if(tab_mode)
                    {
                        end_str = " " + end_str;
                    }

                    keyboard_string = self.text + end_str;
                }
            
                tab_mode = false;
                history_mode = false;
            }
        
            if(!tab_mode && !history_mode)
            {
                self.text = keyboard_string;
                if(active)
                {
                    self.text += "_";
                }
            }

            if(space_index == 0)
            {
                self.tab_text = keyboard_string;
            }
            else
            {
                self.tab_text = string_copy(keyboard_string, 1, space_index);
            }
        
        
        }
    
        if(was_active && !active)
        {
            if(string_length(text) > 0)
            {
                while(string_char_at(text,string_length(text)) == " ")
                {
                    text = string_copy(text,1,string_length(text)-1);
                }
                while(string_char_at(text,1) == " ")
                {
                    text = string_copy(text,2,string_length(text)-1);
                }
            }
        
            if(string_length(text) == 0)
            {
                text = prompt_str;
            }  
        }
    
        had_focus = focused;
        was_active = active;
    }
    else
    {
        self.bg_color = self.disabled_color;
    }
}