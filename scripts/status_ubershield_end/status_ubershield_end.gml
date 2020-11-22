function status_ubershield_end() {
	show_debug_message("status_ubershield_end");
    
    var ubershield = DB.status_effects[? "ubershield"];
    
	self.shield_overcharge -= ubershield.shield_boost;
}
