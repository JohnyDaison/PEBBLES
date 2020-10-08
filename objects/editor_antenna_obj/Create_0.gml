near_antenna = instance_nearest(x,y,antenna_obj);
if(near_antenna == noone || !(near_antenna.x == x && near_antenna.y == y))
{
    near_antenna = instance_create(x,y, antenna_obj);
}

near_antenna.enabled[? round(image_angle/90)] = true;

instance_destroy();

