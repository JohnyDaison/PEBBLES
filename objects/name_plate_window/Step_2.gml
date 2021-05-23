my_draw_set_font(font);
width = string_width(text)+16;

if(instance_exists(my_guy))
{
    //x = my_guy.x - width/2;
    //y = my_guy.y -80 -height/2;
    color = my_guy.tint;
    if(my_guy.my_color <= g_magenta && my_guy.my_color != g_yellow) //  && my_guy.my_color != g_dark 
    {
        bg_color = c_ltgray;
    }
    else
    {
        bg_color = c_dkgray;
    }
    
    my_camera = my_guy.my_player.my_camera;
    if(instance_exists(my_camera))
    {
        border_width = my_camera.border_width+1;
    }
}
