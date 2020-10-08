var nearest_guy = instance_nearest(x,y,player_guy);
if(nearest_guy != noone)
{
    if(point_distance(x,y,nearest_guy.x,nearest_guy.y) < DB.sound_cutoff_dist)
    {
        my_sound_play(spawn_sound);
    }
}

