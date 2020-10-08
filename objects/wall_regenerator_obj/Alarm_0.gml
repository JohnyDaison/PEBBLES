/// @description START REGEN ANIMATION

if(place_meeting(x,y, terrain_obj))
{
    alarm[0] = gamemode_obj.regenerate_terrain_delay;
    exit;
}

visible = true;
image_alpha = 0;
sprite_index = semitransp_wall_spr;
image_speed = -0.1;
image_index = image_number + image_speed;
tint = DB.colormap[? my_color];
tint_updated = true;