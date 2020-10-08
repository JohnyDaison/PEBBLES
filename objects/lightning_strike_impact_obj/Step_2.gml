if(!instance_exists(my_strike))
{
    instance_destroy();
    exit;
}

image_alpha = my_strike.image_alpha;
my_color = my_strike.my_color;
tint = my_strike.tint;

event_inherited();
