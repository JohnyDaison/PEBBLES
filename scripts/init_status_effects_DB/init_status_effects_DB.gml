function init_status_effects_DB() {
    status_effects = ds_map_create();

	status_effects[? "burn"] = instance_create(0,0, status_burn_obj).id;
	status_effects[? "frozen"] = instance_create(0,0, status_frozen_obj).id;
	status_effects[? "slow"] = instance_create(0,0, status_slow_obj).id;
	status_effects[? "confusion"] = instance_create(0,0, status_confusion_obj).id;
	status_effects[? "weakness"] = instance_create(0,0, status_weakness_obj).id;
	status_effects[? "suppressed"] = instance_create(0,0, status_suppressed_obj).id;
	status_effects[? "bounce"] = instance_create(0,0, status_bounce_obj).id;
	status_effects[? "heavy_shots"] = instance_create(0,0, status_heavy_shots_obj).id;

	status_effects[? "tp_rush"] = instance_create(0,0, status_tp_rush_obj).id;
	status_effects[? "overcharge"] = instance_create(0,0, status_overcharge_obj).id;
	status_effects[? "shield_down"] = instance_create(0,0, status_shield_down_obj).id;

	status_effects[? "berserk"] = instance_create(0,0, status_berserk_obj).id;
	status_effects[? "heal"] = instance_create(0,0, status_heal_obj).id;
	status_effects[? "haste"] = instance_create(0,0, status_haste_obj).id;
	status_effects[? "ubershield"] = instance_create(0,0, status_ubershield_obj).id;
	status_effects[? "invisibility"] = instance_create(0,0, status_invisibility_obj).id;

	status_effect_count = ds_map_size(status_effects);
    
    status_effects_list = ds_list_create();
    
    var effect_id = ds_map_find_first(status_effects);

	for(var i=0; i<status_effect_count; i++)
	{
        ds_list_add(status_effects_list, effect_id);
    
	    effect_id = ds_map_find_next(status_effects, effect_id);
	}
}