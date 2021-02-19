//self.facing_right = true;
self.facing = 1;
self.damage = 0;
self.damage_tint_ratio = 0;
self.damage_tint_alpha = 1;
self.damage_tint_fade_step = 0.05;
self.last_damage_tint = c_black;
self.hp = 0;
self.gravity_coef = 0;
self.last_gravity = 0;
self.gravity_direction = 270;
self.friction = 0;
self.rotation_speed = 0;
self.rotation_delta = 0;
self.x_offset = 0;
self.y_offset = 0;
self.light_xoffset = 0;
self.light_yoffset = 0;
self.immovable = false;
self.protected = false;
self.triggerable = false;
self.trigger_script = empty_script;
self.last_attacker_map = noone;
self.holographic = false;
self.holo_alpha = -1;
self.my_source = noone;
self.cancellable = true;
self.cancelled = false;

shape = shape_inherit;
light_shape = shape_inherit;

obj_center_offset = false;
obj_center_updated = false;
obj_center_xoff = 0;
obj_center_yoff = 0;
obj_center_dist = 0;
obj_center_angle = 0;

self.my_player = gamemode_obj.environment;

self.my_color = g_black;
self.multicolor = true;
self.tint_updated = false;
self.tint = c_dkgray;
self.forced_tint = c_white;
self.new_tint = self.tint;
self.alpha_ratio = 1;
self.gives_light = false;
self.ambient_light = 0;
self.direct_light = 0;
self.light_boost = 1;
self.radius = 0;
self.invisible = false;
self.octarine_phase_shift = 0;

self.read_terrain = false;
self.ter_list = noone;
self.ter_list_length = -1;
self.ter_grid_x = -10;
self.ter_grid_y = -10;
self.ter_right = 0;
self.ter_left = 0;
self.ter_up = 0;
self.ter_down = 0;

self.name = "";
self.draw_label = false;
self.label_scale = 1;
self.label_alpha = 1;
self.label_distance = 24;

self.my_groups = ds_list_create();
self.my_keys = ds_map_create();
self.transform_memory = ds_map_create();

/*
blocked_by_terrain = false;
blocked_by_solid_terrain = false;
blocked_by_perma_structure = false;
blocked_by_gate_field = false;


var blocking_coll_params = get_collision_params(coltype_blocking, object_index);

if(!is_undefined(blocking_coll_params))
{
    if(object_index == slime_mob_obj)
    {
        var a = 5;
    }
    blocked_by_terrain = ds_list_find_index(blocking_coll_params, terrain_obj) != -1;
    blocked_by_solid_terrain = ds_list_find_index(blocking_coll_params, solid_terrain_obj) != -1;
    //blocked_by_perma_structure = ds_list_find_index(blocking_coll_params, perma_wall_structure_obj) != -1;
    blocked_by_gate_field = ds_list_find_index(blocking_coll_params, gate_field_obj) != -1;
}
*/
