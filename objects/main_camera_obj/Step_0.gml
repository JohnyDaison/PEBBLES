event_inherited();

if (self.playerCamCount > 0 && !self.on) {
    var total_x = 0;
    var total_y = 0;

    if (self.my_chunkgrid != noone) {
        observer_remove(self.my_chunkgrid, self.id);
    }

    for (var viewIndex = 0; viewIndex < self.playerCamCount; viewIndex++) {
        var player_view = self.player_view_list[| viewIndex];
        var cam = self.cameras[? player_view];
        cam.on = true;

        if (cam.my_chunkgrid == noone) {
            observer_add(chunkgrid_obj, cam.id);
        }

        total_x += cam.x;
        total_y += cam.y;
    }

    self.x = total_x / self.playerCamCount;
    self.y = total_y / self.playerCamCount;

    self.followed_x = self.x;
    self.followed_y = self.y;

    var viewCamera = view_get_camera(self.view);
    camera_set_view_pos(viewCamera,
        self.x - camera_get_view_width(viewCamera) / 2,
        self.y - camera_get_view_height(viewCamera) / 2
    );

    if (self.ter_list_length > 0) {
        for (var terIndex = self.ter_list_length - 1; terIndex >= 0; terIndex--) {
            var ter_block = self.ter_list[| terIndex];

            if (!is_undefined(ter_block) && instance_exists(ter_block)) {
                ter_block.visible = false;
            }
        }

        ds_list_clear(self.ter_list);
        self.ter_list_length = 0;
    }
}

if (self.on || self.playerCamCount == 0) {
    for (var viewIndex = 0; viewIndex < self.playerCamCount; viewIndex++) {
        var player_view = self.player_view_list[| viewIndex];
        var cam = self.cameras[? player_view];

        with (cam) {
            self.on = false;

            if (self.ter_list_length > 0) {
                for (var terIndex = self.ter_list_length - 1; terIndex >= 0; terIndex--) {
                    var ter_block = self.ter_list[| terIndex];

                    if (!is_undefined(ter_block) && instance_exists(ter_block)) {
                        ter_block.visible = false;
                    }
                }

                ds_list_clear(self.ter_list);
                self.ter_list_length = 0;
            }

            if (self.my_chunkgrid != noone) {
                observer_remove(self.my_chunkgrid, self.id);
            }
        }
    }

    if (self.my_chunkgrid == noone) {
        observer_add(chunkgrid_obj, self.id);
    }
}

self.bg_xoffset += self.bg_hspeed;
self.bg_yoffset += self.bg_vspeed;
