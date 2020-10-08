if(sprite_index==noone)
{
    sprite_index = black_aoe;
    image_index = 0;
    image_speed = 0.5;
    image_alpha = 0.8;
}
else
{
    if(my_guy != noone)
    {
        x = my_guy.x;
        y = my_guy.y;
    }
    if(image_index+image_speed<image_number)
        draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_ltgray,image_alpha);
    else
        instance_destroy();
}


action_inherited();
