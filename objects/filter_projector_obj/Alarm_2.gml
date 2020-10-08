/// @description  CREATE FIELD
//my_console_write("projector alarm " + string(id) + " " + string(singleton_obj.step_count));
if(enabled)
{
    if(!instance_exists(my_field))
    {
        if(instance_exists(paired_projector))
        {
            var new_col = my_color & paired_projector.my_color;
            if(new_col > g_black && new_col < g_octarine)
            {
                my_field = instance_create(mean(x, paired_projector.x), mean(y, paired_projector.y), filter_field_obj);
                paired_projector.my_field = my_field;
                
                my_field.my_projectors[? 1] = id;
                my_field.my_projectors[? 2] = paired_projector.id;
                
                active = true;
            }
            else
            {
                active = false;
            }
        }
        else
        {
            enabled = false;
        }
    }
    
    if(!instance_exists(my_field))
    {
        alarm[2] = 1;
    }
}

