if(sprite_index == no_sprite)
{
    if(aiming_up)
    {
        sprite_index = aoe_up_mask;
    }
    if(aiming_down)
    {
        sprite_index = aoe_down_mask;
    }
    image_index = 0;
    image_speed = 0.5;
    image_alpha = 0.8;
}
else
    draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,self.tint,image_alpha);


action_inherited();
