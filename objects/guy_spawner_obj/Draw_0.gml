// draw lightning to Shards
crystal_number = ds_list_size(crystals);

for(var i = 0; i < crystal_number; i++)
{
    var shard = crystals[| i];
    if(instance_exists(shard))
    {
        draw_set_colour(shard.tint);
        draw_set_alpha(lightning_alpha * shard.fade_counter);
        draw_lightning_width(x, y, shard.x, shard.y, lightning_width, lightning_steps, lightning_thickness);
    }
}

// draw self
draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,self.tint,image_alpha);

// draw flag
if(flag_icon != noone)
{
    var icon_offset = 2;
    
    if(!self.holographic)
    {
       icon_offset = max(icon_offset, shield_power);
    }
    
    draw_sprite_ext(flag_icon,0, x, y - 48*(icon_offset), 1,1,0, self.tint, image_alpha);
}

event_inherited();
