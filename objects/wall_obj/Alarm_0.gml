/// @description  FIND NEAR WALLS
for(var i=0; i<4; i++)
{
    near_walls[? i] = noone;

    var wall = instance_nearest(x+ DB.terrain_xx[? i], y+ DB.terrain_yy[? i], wall_obj);
    if(instance_exists(wall))
    {
        if(wall.x == x+ DB.terrain_xx[? i] && wall.y == y+ DB.terrain_yy[? i])
        {
            near_walls[? i] = wall;  
            if(self.is_new)
            {
                wall.alarm[0] = 1;
            }  
        }
    }
}

burst_recheck = true;
is_new = false;
