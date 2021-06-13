event_inherited();

if(is_burner)
{
    draw_sprite_ext(burner_spr, 0, x+scale_dist, y+scale_dist, scale, scale, 0, c_white, image_alpha*lock_alpha);
}

if(color_locked)
{
    draw_sprite_ext(color_lock_spr, 0, x+scale_dist, y+scale_dist, scale, scale, 0, c_white, image_alpha*lock_alpha);
}
