if(random(30) < 1)
{
    effect_create_above(ef_firework,
        x + (random(2)-1)*effect_radius, y + (random(2)-1)*effect_radius,
        effect_size, DB.colormap[? irandom_range(g_red, g_white)]);
    my_sound_play(choose(firework1_sound, firework2_sound, firework3_sound));
}

