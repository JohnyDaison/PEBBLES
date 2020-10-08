lightning_step_size = lightning_base_step_size;
lightning_thickness = lightning_base_thickness;
lightning_width = lightning_base_width;

draw_set_color(tint);
draw_set_alpha(image_alpha);

repeat(3)
{
    lightning_steps = ceil(sprite_height/lightning_step_size);
    draw_lightning_width(x, bbox_top, x, bbox_bottom, lightning_width, lightning_steps, lightning_thickness);
    
    lightning_step_size *= 1.5;
    lightning_thickness = round(lightning_thickness/2);
    lightning_width *= 2;
}

//draw_sprite_ext(lightning_strike_impact_spr, 0, x, y, 1, 1, 0 , tint, 0.9*image_alpha);

event_inherited();
