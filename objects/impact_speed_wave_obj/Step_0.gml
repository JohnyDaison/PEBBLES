active = false;

if(instance_exists(my_guy))
{
    x = my_guy.x;
    y = my_guy.y;
    active = !my_guy.lost_control && my_guy.vspeed >= my_guy.impact_speed;
}

if (active) {
    part_particles_create(system, x - particle_xoffset_start, y + particle_yoffset_start, pt, 1);
    part_particles_create(system, x + particle_xoffset_start, y + particle_yoffset_start, pt2, 1);
}