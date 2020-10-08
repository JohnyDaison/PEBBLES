draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,self.tint,image_alpha);

if(flag_icon != noone)
{
    var icon_offset = 2;
    
    if(!self.holographic)
    {
       icon_offset = max(1, gamemode_obj.spawner_shield_power) + 1;
    }
    
    draw_sprite_ext(flag_icon,0, x, y - 32*(icon_offset), 1,1,0, self.tint, image_alpha);
}

event_inherited();
