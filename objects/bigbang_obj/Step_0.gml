event_inherited();

if(start_step == -1)
{
    start_step = singleton_obj.step_count;
}
if(!fired && singleton_obj.step_count-start_step > delay)
{  
    var dir, dist, xx, yy, inst;
    
    while(energy >= quantum_size)
    {
        dir = random(360);
        dist = 2+random(total_energy);
        xx = lengthdir_x(dist,dir);
        yy = lengthdir_y(dist,dir);
        
        inst = create_energy_ball(id, "small_bolt", irandom_range(g_red,g_cyan), quantum_size);
        inst.x += xx;
        inst.y += yy;
        
        inst.direction = dir;
        inst.speed = dist/10;
        inst.my_guy = inst.id;
        
        energy -= quantum_size;
    }
    fired = true;
}

if(fired && singleton_obj.step_count-start_step > life)
{
    instance_destroy();
}
