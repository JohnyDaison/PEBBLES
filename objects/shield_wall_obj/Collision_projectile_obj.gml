projectile = other.id;

if(my_color == other.my_color)
{
    with(other)
    {
        move_bounce_all(false);
        speed -= 0.2;
        my_sound_play(wall_hum_sound, true);
    }
}
else
{
    with(projectile)
    {
        with(other)
        {
            receive_damage(other.force);
        }
    }
}

