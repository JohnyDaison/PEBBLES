function abi_base_teleport() {
    show_debug_message("base teleport used");
    var abi_color = g_white;
    var success = false;

    if(instance_exists(my_base) && !(my_base.object_index == guy_spawner_obj && my_base.destroyed))
    {
        drop_enemy_flags();
        
        x = my_base.x;
        y = my_base.y;
        last_x = x;
        last_y = y;
        speed = 0;
        self.abi_cooldown_length[? abi_color] = DB.abi_cooldowns[? abi_color];
        my_sound_play(base_tp_sound);
        success = true;
        
        var cam = my_player.my_camera;
        if (instance_exists(cam)) {
            cam.x += x - xprevious;
            cam.y += y - yprevious;
        }
    }
    else
    {
        self.abi_cooldown_length[? abi_color] = 1;
        my_sound_play(failed_sound);
    }

    return success;
}
