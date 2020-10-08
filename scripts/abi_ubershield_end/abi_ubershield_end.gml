function abi_ubershield_end() {
	var abi_color = g_purple;
	if(self.shield_overcharge >= ball_ubercharge_boost)
	{
	    self.shield_overcharge -= ball_ubercharge_boost;
	}
	self.abi_script[? abi_color] = empty_script;
	show_debug_message("uber shield finished");



}
