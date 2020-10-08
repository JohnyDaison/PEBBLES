part_emitter_destroy(system,em);
part_type_destroy(pt);
part_system_destroy(system);

// VIEWSHAKE
            
if(object_index == big_projectile_obj && impact_strength > 0)
{
    with(guy_obj)
    {
        var cam = my_player.my_camera;
        if(cam != noone)
        {
            var dist = point_distance(x,y,other.x,other.y);
            if(dist < other.shake_range)
            {
                viewshake(cam, other.direction,
                    min(20, 7 * max(1,other.impact_strength)*sqrt(1-dist/other.shake_range) ) );
            }
        }
    }
}

event_inherited();