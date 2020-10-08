action_inherited();
draw_set_color(c_green);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
my_draw_set_font(label_font);
    
if(joystick1_obj.on)
{
    buttons = joystick_buttons(1)/2;
    x=32;
    y=168;
    my_draw_text(64+self.view_x_offset,200+self.view_y_offset,string_hash_to_newline(joystick_name(1) + " | " + string(joystick_axes(1))+
                " | " + string(buttons*2) + " | " + string(joystick_has_pov(1))));

    for(i=1;i<=buttons;i+=1)
    {
        my_draw_text(64*(i)+self.view_x_offset,232+self.view_y_offset,string_hash_to_newline(string(i) + " " + string(joystick_check_button(1,i))));
        my_draw_text(64*(i)+self.view_x_offset,296+self.view_y_offset,string_hash_to_newline(string(i+buttons) + " " + string(joystick_check_button(1,i+buttons))));
    }  
    my_draw_text(64+self.view_x_offset,360+self.view_y_offset,
          string_hash_to_newline(string(joystick_direction(1))+
    " | "+string(joystick_xpos(1))+" | "+string(joystick_ypos(1))+" | "+string(joystick_zpos(1))+
    " | "+string(joystick_upos(1))+" | "+string(joystick_rpos(1))+" | "+string(joystick_vpos(1))+
    " | "+string(joystick_pov(1))));
    
    my_draw_text(64+self.view_x_offset,396+self.view_y_offset,string_hash_to_newline("Last joycontrol: "+string(joystick1_obj.last_control)));
    
    for(i=0;i<4;i+=1)
    {
        for(ii=0;ii<4;ii+=1)
        {
            my_draw_text(64+32*i+self.view_x_offset,460+32*ii+self.view_y_offset,string_hash_to_newline(string(joystick1_obj.states[# joy_right+i, ii])));
        } 
    }
}

