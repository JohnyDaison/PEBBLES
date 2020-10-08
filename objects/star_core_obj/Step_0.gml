event_inherited();

var dir, dist, xx, yy, i;

if(start_step == -1)
{
    start_step = singleton_obj.step_count;
}

if(!fired && singleton_obj.step_count-start_step < delay)
{
    repeat(3)
    {
        dir = random(360);
        dist = random(total_energy)/2;
        xx = lengthdir_x(dist,dir);
        yy = lengthdir_y(dist,dir);
            
        part_type_life(part_type,60,60);
        part_type_speed(part_type,dist/60,dist/60,0, 0);
        part_type_direction(part_type,dir+180,dir+180,0,0);
        part_particles_create(part_system, x+xx, y+yy, part_type, 1);
    }
}

if(!fired && singleton_obj.step_count-start_step > delay)
{  
    var big = true;
    var energy_threshold = total_energy*self.small_bolt_ratio;
    while(energy >= quantum_size)
    {
        if(energy > energy_threshold)
        {
            big = true;
            dir = 360* (energy - energy_threshold)/(total_energy - energy_threshold); 
            dist = total_energy/2; //4.2
        }
        else
        {
            big = false;
            dir = 360*(energy/energy_threshold);
            dist = total_energy/3; //8.4
        }
        xx = lengthdir_x(dist,dir);
        yy = lengthdir_y(dist,dir);
        if(big)
        {
            i = create_energy_ball(id, "big_bolt", my_color, quantum_size*2);
        }
        else
        {
            /*
            i = instance_create(x+xx,y+yy,small_projectile_obj);
            i.force = quantum_size;
            */
            i = create_energy_ball(id, "small_bolt", my_color, quantum_size);
            i.x += xx;
            i.y += yy;
        }
        i.gravity = friction + 0.005;
        i.direction = dir; //135
        i.speed = dist/10; //100
        i.hspeed += hspeed;
        i.vspeed += vspeed;
        
        energy -= i.force;
    }
    part_system_clear(part_system);
    draw_label = false;
    gives_light = false;
    fired = true;
}

if(fired && singleton_obj.step_count-start_step > life)
{
    instance_destroy();
}

