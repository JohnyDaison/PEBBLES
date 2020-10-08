//draw_sprite_ext(sprite_index, image_index, x,y, 1,1,0, tint, 1);
draw_sprite_ext(item_spawner_base_spr, 0, x,y, 1,1,0, tint, 1);

draw_sprite_ext(item_spawner_arm_spr, 0, x-arm_offset_x+1, y+arm_offset_y, -1,1, -arm_angle, tint, 1);
draw_sprite_ext(item_spawner_arm_spr, 0, x+arm_offset_x, y+arm_offset_y, 1,1, arm_angle, tint, 1);

if(spawning)
{
    draw_set_color(spawn_tint);
    
    draw_lightning_width(x-arm_offset_x +1, y+arm_offset_y, x, y-spawn_height, lightning_width, lightning_steps, lightning_thickness);
    draw_lightning_width(x+arm_offset_x, y+arm_offset_y, x, y-spawn_height, lightning_width, lightning_steps, lightning_thickness);
    
    draw_lightning_width(x-arm_offset_x-arm_tip_offset_x +1, y+arm_offset_y+arm_tip_offset_y, x, y-spawn_height, lightning_width, lightning_steps, lightning_thickness);
    draw_lightning_width(x+arm_offset_x+arm_tip_offset_x, y+arm_offset_y+arm_tip_offset_y, x, y-spawn_height, lightning_width, lightning_steps, lightning_thickness);
}

event_inherited();
