for(var pair_i = 0; pair_i < particle_pairs; pair_i++)
{
    var coef = pair_i / particle_pairs;
    
    var particle_rotation_start = particle_max_rotation * (1 - particle_animated_rotation_ratio) * coef;
    var particle_x_offset = particle_xoffset_start + coef * particle_xoffset_distance;
    var particle_y_offset = particle_yoffset_start + coef * particle_yoffset_distance;
    
    part_type_orientation(pt, -particle_rotation_start, -particle_rotation_start, -particle_rotation_step, 0, false);
    part_type_orientation(pt2, particle_rotation_start, particle_rotation_start, particle_rotation_step, 0, false);
    
    part_particles_create(system, x - particle_x_offset, y + particle_y_offset, pt, 1);
    part_particles_create(system, x + particle_x_offset, y + particle_y_offset, pt2, 1);
}

active = false;
alarm[1] = particle_life;
