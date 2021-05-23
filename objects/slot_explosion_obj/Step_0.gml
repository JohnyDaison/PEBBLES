if(instance_exists(slot))
{
    my_color = slot.my_color;
    with(slot)
    {
        instance_destroy();
    }
}

if(!fired && my_color != g_dark)
{
    var dir, dir_step = 360/self.shrapnel_count, xx, yy, inst;
    
    if(self.fire_projectiles)
    {
        for(dir = 0; dir<360; dir+=dir_step)
        {
            xx = lengthdir_x(1,dir);
            yy = lengthdir_y(1,dir);
            
            //inst = instance_create(x+xx*12,y+yy*12,small_projectile_obj);
            inst = create_energy_ball(id, "small_bolt", my_color, shrapnel_charge);
            inst.x += xx*12;
            inst.y += yy*12;
            
            inst.my_guy = id;
            if(instance_exists(my_guy))
            {
                inst.my_guy = my_guy;
            }
            inst.my_source = my_source;
            inst.direction = dir + image_angle;
            inst.speed = energy;
        }
    }
    
    if(self.create_shockwave)
    {
        inst = instance_create(x,y,shield_obj);
        inst.my_player = my_player;
        inst.overcharge = self.energy/2;
        inst.chargerate = 250;
        inst.charge = self.shield_charge;
        inst.my_color = self.my_color; 
        inst.my_guy = inst.id;
        inst.my_source = my_source;
        inst.source_id = source_id;
        inst.holographic = self.holographic;
    }
    
    if(self.create_sparks)
    {
        var sparks = ceil(self.energy/spark_cost);
        for(var a=0; a<sparks; a+=1)
        {
            inst = instance_create(x,y,spark_obj);
            inst.direction = random(360);
            inst.speed = self.energy;
            inst.my_color = self.my_color;
            inst.holographic = self.holographic;
        }
    }
    
    fired = true;
}


if(fired)
{
    instance_destroy();
}
