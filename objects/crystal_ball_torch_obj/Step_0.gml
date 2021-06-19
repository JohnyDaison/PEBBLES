if (my_color > g_dark) {
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