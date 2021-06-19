if(instance_exists(my_guy)) {
    draw_sprite_ext(my_guy.sprite_index ,0,x,y,1,1, my_guy.image_angle, my_guy.tint, 0.3);
}

event_inherited();