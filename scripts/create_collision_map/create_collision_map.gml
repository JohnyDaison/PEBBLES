/// @description create_collision_map(DB)
/// @param DB
function create_collision_map(argument0) {

	var db = argument0;


	var main_map = ds_map_create();
	db.collision_map = main_map;

	var blocking = ds_map_create();
	main_map[? coltype_blocking] = blocking;


	var slime_mob = ds_list_create();
	var spark = ds_list_create();

	blocking[? slime_mob_obj] = slime_mob;
	blocking[? spark_obj] = spark;

	ds_list_add(slime_mob, solid_terrain_obj); //, perma_wall_structure_obj
	ds_list_copy(spark, slime_mob);
	//ds_list_add(spark, slime_mob_obj);
	/*
	slime_mob[? "solid_terrain"] = true;
	slime_mob[? "solid_structures"] = true;
	*/


	var phys_body = ds_list_create();
	ds_list_add(phys_body, terrain_obj); // , perma_wall_structure_obj, gate_field_obj

	blocking[? player_guy] = phys_body;
	blocking[? basic_bot] = phys_body;

	blocking[? spitter_body_obj] = phys_body;
	blocking[? sprinkler_body_obj] = phys_body;

	/*
	var guy = ds_list_create();

	ds_list_add(guy, terrain_obj, perma_wall_structure_obj, gate_field_obj);

	guy[? "terrain"] = true;
	guy[? "solid_structures"] = true;
	guy[? "gate_field"] = true;
	*/

	/*
	var mobs = ds_list_create();

	ds_list_add(mobs, terrain_obj, perma_wall_structure_obj, gate_field_obj);

	mobs[? "terrain"] = true;
	mobs[? "solid_structures"] = true;
	mobs[? "gate_field"] = true;
	*/



}
