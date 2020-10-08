angle += 5;
angle = angle mod 360;
scale = 0.9 + sin(degtorad(angle))*0.2;

if(was_prepared)
{
    prepare_anim_phase--;
    
    if(prepare_anim_phase <= 0)
    {
        prepare_anim_phase = 0;
        was_prepared = false;
    }
}
