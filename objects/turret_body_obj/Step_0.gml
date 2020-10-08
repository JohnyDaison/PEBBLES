event_inherited();

if(!instance_exists(my_guy) && instance_exists(my_player))
{
    my_guy = my_player.my_guy;
}
autofire = my_mount.autofire;
fire = false;
if(charging)
{
    charge += cur_charge_step;
}
charge = min(charge, threshold);
size = charge/threshold;

if(instance_exists(my_mount.my_block) && my_color != my_mount.my_block.my_color
&& my_mount.my_block.color_locked && my_mount.my_block.my_color > g_black)
{
    my_color = my_mount.my_block.my_color;
    tint_updated = false;
}

image_xscale = size;
image_yscale = size;

if(charge == threshold)
{
    charging = false;
    with(guy_obj) 
    {
        turret_line_of_sight();
    }
    
    if(!fire)
    {
        with(mob_obj) 
        {
            turret_line_of_sight();
        }
    }
    
    if(!fire && autofire)
    {
        target_dir = my_mount.direction;
        fire = true;
    }
    
    if(fire && my_mount.my_block.my_next_color != g_octarine)
    {
        //var inst = instance_create(x,y,big_projectile_obj);
        var inst = create_energy_ball(id, "big_bolt", my_color, 1);
        inst.direction = target_dir;
        inst.speed = 12;
        inst.x += hspeed;
        inst.y += vspeed;
        
        inst.my_guy = self.id;
        /*
        inst.force = 1;
        inst.my_color = my_color;         
        inst.my_player = self.my_player;
        
        inst.my_source = object_index;
        
        my_sound_play(shot1_sound);
        */
        charge = 0;
        charging = true;

        if(!my_mount.my_block.color_locked)
        {
            switch(my_color)
            {
                case g_red:
                    my_color = g_blue;
                    break;
                case g_green:
                    my_color = g_red;
                    break;
                case g_blue:
                    my_color = g_green;
                    break;
            }
            tint_updated = false;
        }
    }
}

