/// @description  REINIT ORBS FROM GUY'S BELTS BASED ON HIS COLOR

if(instance_exists(my_guy) && object_is_ancestor(my_guy.object_index, guy_obj))
{
    chargeball_orbs_return(id);
    guy_orbs_return(my_guy);
    
    chargeball_orbs_draw(id);
}
