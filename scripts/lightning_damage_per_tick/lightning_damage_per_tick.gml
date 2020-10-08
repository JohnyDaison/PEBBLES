/// @param max_ratio
/// @param dist
function lightning_damage_per_tick() {
	var max_ratio = argument[0];
	var dist = argument[1];

	var dmg = (impact_force/anim_damage_steps) * (max_ratio - (dist / radius));
	dmg = max(0, dmg);

	return dmg;


}
