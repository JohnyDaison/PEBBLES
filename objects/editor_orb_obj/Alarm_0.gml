orb = instance_create(x,y,color_orb_obj);
orb.my_color = my_color;
//orb.my_guy = orb.id;
orb.color_added = true;
orb.airborne = true;
orb.duplicate_me = duplicate_me;
if(!is_undefined(draw_label))
{
    orb.draw_label = draw_label;   
}

if(instance_exists(spawned_from) && spawned_from.spawned_item == id)
{
    spawned_from.spawned_item = orb;
}

instance_destroy();
