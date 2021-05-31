/// @param x
/// @param y
/// @param unique
function get_closest_spawner(xx, yy, unique) {
    var dist, closest_dist = -1, closest_spawner = noone;

    closest_spawner = instance_nearest(xx, yy, guy_spawner_obj);

    if(instance_exists(closest_spawner) && unique)
    {
        closest_dist = point_distance(closest_spawner.x,closest_spawner.y,xx,yy);
    
        with(guy_spawner_obj)
        {
            var dist = point_distance(x, y, xx, yy);
         
            if(instance_exists(closest_spawner) && closest_spawner.id != id && abs(dist - closest_dist) < 8)
            {
                closest_spawner = noone;
            }
        }
    }

    return closest_spawner;
}
