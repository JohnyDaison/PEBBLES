/// @description  BURSTING
if(instance_exists(my_block) && instance_exists(turret))
{
    autofire = (my_block.bursting || my_block.spreading);
    if(autofire)
    {
        with(turret)
        {
            if(charging && charge+cur_charge_step < threshold)
            {
                charge += cur_charge_step;
            }
            if(object_index == charge_ball_obj)
            {
                with(other)
                {
                    if(instance_exists(my_beam))
                    {
                        my_beam.force = my_beam.orig_force;
                    }   
                }
            }
            
        }
    }

}

