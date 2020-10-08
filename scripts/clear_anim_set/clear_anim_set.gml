/// @description clear_anim_set(clear_displays)
/// @function clear_anim_set
/// @param clear_displays
function clear_anim_set(argument0) {
	var clear_displays = argument0;
    
	var i, map, disp_obj;
	for(i=self.steps_total-1; i>=0; i--)
	{
	    map = self.steps[| i];
	    ds_map_destroy(map);
	}
	ds_list_clear(steps);

	if(clear_displays)
	{
	    var count = ds_list_size(self.members), disp;
	    for(i=count-1; i>=0; i--)
	    {
	        disp_obj = self.members[| i];  
	        clear_display(disp_obj);
	    }
	}

	self.duration_total = 0;
	self.steps_total = 0;





}
