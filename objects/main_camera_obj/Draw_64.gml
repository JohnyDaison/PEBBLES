event_inherited();

if(draw_debug)
{
    var step = 64, i = step;
    draw_set_colour(c_orange);
    my_draw_set_font(big_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    my_draw_text(64, i, string(gamemode_obj.player_count));
    i += step;
    with(camera_obj)
    {
        my_draw_text(64, i, string(view)+": "
            + string(on) + " " + string(visible) + "|| " + string(zoom_level) + "/" + string(normal_zoom));
            //string(view_visible[view])
            //+ " " + string(view_yport[view])+ ", " + string(view_hport[view])+ " | "
        i += step;
    }
    /*
    with(player_display_obj)
    {
        my_draw_text(64, i, string(my_camera.view)+": "
            + string(my_camera.view_surface));
        i += step;
    }
    */
    
    my_draw_text(64, i, "energy balls: " + string(instance_number(energyball_obj)));
    i += step;
}
