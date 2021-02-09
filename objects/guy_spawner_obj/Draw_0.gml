draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,self.tint,image_alpha);

if(flag_icon != noone)
{
    var icon_offset = 2;
    
    if(!self.holographic)
    {
       icon_offset = max(icon_offset, gamemode_obj.spawner_shield_power);
    }
    
    draw_sprite_ext(flag_icon,0, x, y - 48*(icon_offset), 1,1,0, self.tint, image_alpha);
}

event_inherited();
