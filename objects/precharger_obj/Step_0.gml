chargeball = instance_nearest(x,y,charge_ball_obj);
dist = distance_to_object(chargeball);
var full_charge = 0;
with(chargeball)
{
    full_charge = (max_charge+overcharge)*orb_exhaustion_ratio;
}
if(dist < 48 && chargeball.charging && chargeball.charge < full_charge)
{
    with(chargeball)
    {
        charge = full_charge;
    }
    instance_destroy();
}

