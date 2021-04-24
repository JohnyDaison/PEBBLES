function abi_flashback_step() {
    var abi_color = g_black;
    for(i=0;i<self.time_rate && ds_list_size(self.flashback_queue) > 1;i+=1)
    {
        ds_list_delete(self.flashback_queue,ds_list_size(self.flashback_queue)-1);
    }
    time_left = ds_list_size(self.flashback_queue);

    ds_map_read(old_state, self.flashback_queue[| time_left-1]);
    x = ds_map_find_value(old_state,"x");
    y = ds_map_find_value(old_state,"y");
    sprite_index = ds_map_find_value(old_state,"sprite_index");
    image_index = ds_map_find_value(old_state,"image_index");
    facing = ds_map_find_value(old_state,"facing");
    my_color = ds_map_find_value(old_state,"my_color");
    slots_absorbed = ds_map_find_value(old_state,"slots_absorbed");
    tint = ds_map_find_value(old_state,"tint");
    var orig_damage = damage;
    damage = ds_map_find_value(old_state,"damage");
    my_player.rewound_dmg_total += orig_damage - damage;

    if(self.flashing_back && time_left <= time_rate)
    {
        speed = ds_map_find_value(old_state,"speed")/2;
        direction = ds_map_find_value(old_state,"direction");
        //airborne = !(ds_map_find_value(old_state,'airborne'));
        airborne = false;
        lost_control = false;
        mask_index = guy_stand;
        for(var col=g_red; col<=g_white; col++)
        {
            var effect = DB.color_effects[? col];
            if(status_left[? effect.codename] > 0)
                status_left[? effect.codename] = 0;
        }
    
        self.frozen_in_time = false;
        self.flashing_back = false;
        self.protected = false;
        self.abi_script[? abi_color] = empty_script;
        if(instance_exists(self.charge_ball))
        {
            self.charge_ball.alarm[2] = 1;
        }
        show_debug_message("flashback finished");
    }
}
