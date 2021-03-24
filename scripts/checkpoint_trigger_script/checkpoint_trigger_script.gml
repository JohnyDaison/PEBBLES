function checkpoint_trigger_script() {
    var guy = other;
    var player = guy.my_player;
    var player_num = player.number;

    if(is_undefined(spawn_points[? player_num]) && guy_can_capture_spawner(guy, id))
    {
        visible = false;

        // ANNOUNCEMENT
        my_sound_play(checkpoint_sound);
        
        var i = instance_create(x,y-24,text_popup_obj);
        i.str = "CHECKPOINT!";
        i.my_color = g_white;
        i.tint_updated = false;
    
        // CREATE SPAWN POINT
        guy_spawn_point_create(id, player);
    }
}
