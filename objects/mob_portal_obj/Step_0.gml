event_inherited();

if(enabled)
{
    image_angle += 5;
    if(emit_particles && image_angle mod 240 == 0 && image_angle mod 400 == 0)
    {
        effect_create_above(ef_firework,x,y,12,c_white);
    }
    
    scale = 0.9 + sin(degtorad(image_angle))*0.2;
    image_xscale = scale;
    image_yscale = scale;
}

