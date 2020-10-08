near_rod = instance_nearest(x,y, energy_drain_rod_obj);
if(near_rod == noone || !(near_rod.x == x && near_rod.y == y))
{
    near_rod = instance_create(x,y, energy_drain_rod_obj);
}

near_rod.enabled[? round(image_angle/90)] = true;

instance_destroy();

