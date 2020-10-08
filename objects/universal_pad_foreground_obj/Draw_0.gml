if(!instance_exists(background))
{
    instance_destroy();
    exit;
}

x = background.x;
y = background.y;

// BURST
if(background.burst_anim_sprite != noone)
{
    draw_sprite_ext(background.burst_anim_sprite,background.burst_anim_index,x,y,1,1,0,background.burst_tint,background.image_alpha/2);  
}
