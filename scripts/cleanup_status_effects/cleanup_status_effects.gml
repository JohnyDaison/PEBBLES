/// @self guy_obj
function cleanup_status_effects() {
    for (var i = 0; i < DB.status_effect_count; i++) {
        var effect_id = DB.status_effects_list[| i];
        instance_destroy(self.status_particles[? effect_id]);
    }

    ds_map_destroy(self.status_left);
    ds_map_destroy(self.status_start);
    ds_map_destroy(self.status_particles);
}
