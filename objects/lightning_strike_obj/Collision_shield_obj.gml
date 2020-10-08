var shield = other;
var strike = id;

if(image_alpha == 1 && instance_exists(shield.my_guy) && shield.my_guy != shield.id
&& shield.holographic == holographic)
{
    var dmg = lightning_damage_per_tick(1, 0);
    
    with(shield.my_guy)
    {
        if(!place_meeting(x,y,strike)) // PREVENT DUPLICATE DAMAGE
        {
            receive_damage(dmg);
        }
    }
}