/// @description guy_orbs_return(guy_obj)
/// @function guy_orbs_return
/// @param guy_obj
function guy_orbs_return(argument0) {
	var guy = argument0;
	var i, orb;

	if(instance_exists(guy) && ds_exists(guy.color_slots, ds_type_list))
	{
	    for(i=guy.slot_number-1; i>=0; i--)
	    {
	        orb = guy.color_slots[|i];
	        if(!is_undefined(orb))
	        {
	            orb_transfer(orb, guy, "orbit", guy, "belt");
	        }
	        else
	        {
	            show_debug_message(guy.name + "'s Orb " + string(i) + "is undefined!");
	        }
	    }
    
	    guy.slot_number = 0;
	    guy.current_slot = guy.slot_number;
	}



}
