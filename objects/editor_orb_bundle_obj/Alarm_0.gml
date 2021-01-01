var orb_bundle = instance_create(x,y,orb_bundle_obj);
orb_bundle.my_color = my_color;
orb_bundle.airborne = true;
orb_bundle.duplicate_me = duplicate_me;
if(!is_undefined(draw_label))
{
    orb_bundle.draw_label = draw_label;   
}

if(instance_exists(spawned_from) && spawned_from.spawned_item == id)
{
    spawned_from.spawned_item = orb_bundle;
}

instance_destroy();
