if (my_color > g_dark && energy > 0) {
    if (!instance_exists(flame)) {
        flame = instance_create_depth(x,y, 16, ball_torch_flame_obj);
        flame.my_guy = id;
    }
} else {
    if (instance_exists(flame)) {
        flame.active = false;
        flame.alarm[0] = 1;
    }
}

energy = clamp(energy, 0, max_energy);

var energy_ratio = energy/max_energy;

ambient_light = energy_ratio * max_ambient_light;
direct_light = energy_ratio * max_direct_light;