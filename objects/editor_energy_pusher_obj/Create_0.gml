near_pusher = instance_nearest(x,y, energy_pusher_obj);
if(near_pusher == noone || !(near_pusher.x == x && near_pusher.y == y))
{
    new_pusher = instance_create(x,y, energy_pusher_obj);
    new_pusher.direction = image_angle;
    new_pusher.image_angle = image_angle;
    new_pusher.tick_phase = 2*(floor(image_angle/90));
    //new_pusher.tick_phase = ( floor(new_pusher.x/32) + floor(new_pusher.y/32) ) mod new_pusher.tick_delay;
}

instance_destroy();

