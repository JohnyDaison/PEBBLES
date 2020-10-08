if(visible)
{
    if(enabled)
    {
        if(cursor_obj.x >= x && cursor_obj.x < (x + self.width)
        && cursor_obj.y >= y && cursor_obj.y < (y + self.height)
        && DB.mouse_has_moved)
        {
            mouse_over = true;
            if(!focused) gui_get_focus();
        }
        else
        {
            if(mouse_over && focused && !active)
            { 
                gui_lose_focus();
                self.depressed = false;
            }
            mouse_over = false;  
        }
    
    
        if(focused && mouse_check_button_pressed(mb_left) && mouse_over)
        {
            self.depressed = true;
            self.active = true;
            self.bg_color = self.depressed_color;
            keyboard_string = "";
            keyboard_lastchar = "";
        }
    
        if(focused && self.depressed)
        {
            if(keyboard_lastkey != 0 && keyboard_check(keyboard_lastkey))
            {
                self.key = keyboard_lastkey;
                self.depressed = false;
                self.active = false;
                if(last_key != key)
                {
                    self.key_text = string_upper(keyboard_lastchar);
                }
            }
        }
        if(!self.depressed && focused) self.bg_color = self.highlight_color;
        if(!self.depressed && !focused) self.bg_color = self.base_bg_color;
    
        //self.text = string(self.key)+"("+chr(self.key)+") "+string(keyboard_check(self.key));
    
        if(!had_focus && focused)
            my_sound_play(blip_sound);   
    
        had_focus = focused;
    }
    else
    {
        self.bg_color = self.disabled_color;
        self.depressed = false;
        self.active = false;
    }

    if(last_key != key)
    {
        if(self.key_text == "")
        {
            self.key_text = chr(key);
        }

        switch(key)
        {
            case vk_alt:
            {
                if(keyboard_check_direct(vk_lalt))
                {
                    key = vk_lalt;
                }
                if(keyboard_check_direct(vk_ralt))
                {
                    key = vk_ralt;
                }  
            } break;
        
            case vk_control:
            {
                if(keyboard_check_direct(vk_lcontrol))
                {
                    key = vk_lcontrol;
                }
                if(keyboard_check_direct(vk_rcontrol))
                {
                    key = vk_rcontrol;
                }  
            } break;
        
            case vk_shift:
            {
                if(keyboard_check_direct(vk_lshift))
                {
                    key = vk_lshift;
                }
                if(keyboard_check_direct(vk_rshift))
                {
                    key = vk_rshift;
                }  
            } break;
        }
    
        if(ds_map_exists(DB.keynames,key))
        {
            self.key_text = ds_map_find_value(DB.keynames,key);
        }
    
        //self.key_text += " ("+chr(self.key)+") "+string(self.key);
    }

    key_down = keyboard_check_direct(self.key);

    last_key = key;
}