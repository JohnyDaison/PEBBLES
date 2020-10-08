near_projector = instance_nearest(x,y,projector_obj);
if(near_projector == noone || !(near_projector.x == x && near_projector.y == y))
{
    near_projector = instance_create(x,y, projector_obj);
}

near_projector.enabled[? round(image_angle/90)] = true;

instance_destroy();

