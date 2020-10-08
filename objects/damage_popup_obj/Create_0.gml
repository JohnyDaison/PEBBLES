event_inherited();

damage = 0;
bg_alpha = 0.4;
alarm[1] = 2;
type = "";

max_number = 50;

if(my_instance_number(object_index) > max_number)
{
    instance_destroy(object_index.id)
}