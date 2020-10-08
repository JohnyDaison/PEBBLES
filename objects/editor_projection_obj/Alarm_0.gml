projector = instance_nearest(x,y, projector_obj);

if(instance_exists(projector))
{
    if(distance_to_object(projector) < projector.radius)
    {
        projector.text_x = x - projector.x;
        projector.text_y = y - projector.y;
        projector.text = text;   
    }
}

instance_destroy();

