/// @description CHUNK UPDATE AND VIEW SHAKE

// CHUNK UPDATE
if (self.on) {
    if (!instance_exists(chunkgrid_obj)) {
        show_debug_message("CAM END [" + string(self.view) + "]");
    }
    else {
        var cur_grid_x, cur_grid_y;
        cur_grid_x = floor(x / chunkgrid_obj.chunk_size);
        cur_grid_y = floor(y / chunkgrid_obj.chunk_size);

        var moved_to_new_chunk = (cur_grid_x != self.obs_chunk_x || cur_grid_y != self.obs_chunk_y);

        // GRID SECTION STATE UPDATE
        if (moved_to_new_chunk && singleton_obj.step_count > 5) {
            schedule_chunk_optimizer();
        }
    }
}

// VIEW SHAKE
if (self.shake_dist > 0) {
    if (self.shake_dist < 1) {
        self.shake_dist = 0;
    }
    else {
        self.shake_dist -= self.shake_dist_decay;
        self.shake_dir = (self.shake_dir + 180) mod 360;
    }

    x += 2 * lengthdir_x(self.shake_dist, self.shake_dir);
    y += 2 * lengthdir_y(self.shake_dist, self.shake_dir);
}


// NORMAL ZOOM
self.normal_zoom = self.base_normal_zoom;
if (singleton_obj.player_port_height < singleton_obj.current_height) {
    self.normal_zoom = self.small_normal_zoom;
}
