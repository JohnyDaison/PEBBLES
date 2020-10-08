//var anim_step = clamp((singleton_obj.step_count mod 120)-(120-anim_total_length), 0, anim_total_length-1);
anim_step++;

if(anim_step < anim_fadein_steps)
{
    image_alpha = anim_step / anim_fadein_steps;    
}
else if(anim_step >= anim_fadein_steps && anim_step < anim_fadein_steps + anim_damage_steps)
{
    image_alpha = 1;
    if(anim_step == anim_fadein_steps)
    {
        my_sound_play(lightning_strike_sound);
    }
}
else
{
    image_alpha = 1 - (anim_step - (anim_fadein_steps + anim_damage_steps -1)) / anim_fadeout_steps;
}


ambient_light = orig_ambient_light * image_alpha;
direct_light = orig_direct_light * image_alpha;

if(anim_step >= anim_total_length)
{
    instance_destroy();
}