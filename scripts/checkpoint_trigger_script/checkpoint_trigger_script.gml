function checkpoint_trigger_script() {
    var guy = other;
    var player = guy.my_player;
    var player_num = player.number;
    
    if(is_undefined(spawn_points[? player_num]) && guy_can_capture_spawner(guy, id))
    {
        visible = false;
        
        if (!invisible) {
            // ANNOUNCEMENT
            my_sound_play(checkpoint_sound);
        
            var popup = instance_create(x, y-24, text_popup_obj);
            popup.str = "CHECKPOINT!";
            popup.my_color = g_white;
            popup.tint_updated = false;
        }
    
        // CREATE SPAWN POINT
        guy_spawn_point_create(id, player);
    }
}
