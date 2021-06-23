if (instance_exists(guy_obj) && alarm[4] == -1 && !torch_sequence_started) {
    alarm[4] = torch_sequence_wait_time * singleton_obj.game_speed;
}

if (torch_sequence_started && !torch_sequence_finished) {
    var controller = self;
    
    if (!instance_exists(torch_obj)) {
        var color = torch_sequence[| torch_color_index];
        
        if (is_undefined(color)) {
            torch_sequence_finished = true;
        } else {
            with(crystal_ball_torch_obj) {
                if (my_color == color) {
                    controller.torch_obj = self;
                }
            }
        }
    }
    
    with(torch_obj) {
        energy += controller.torch_energy_tick;
        
        if (energy >= max_energy) {
            with(controller) {
                torch_color_index++;
                torch_obj = noone;
            }
        }
    }
}