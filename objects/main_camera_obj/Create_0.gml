event_inherited();

self.guy_hor_dist = 128;
self.guy_ver_dist = 128;
self.view = 0;
self.only_cam = true;
self.on = true;
self.draw_debug = false;
self.gui_fix_applied = false;

self.player_view_list = ds_list_create();
self.cameras = ds_map_create();
self.playerCamCount = 0;
self.last_view = 0;

self.bg_xoffset = 0;
self.bg_yoffset = 0;
self.bg_hspeed = -0.2;
self.bg_vspeed = 0;

/// @param {Id.Instance} player_camera
function add_player_camera(player_camera) {
    ds_list_add(self.player_view_list, player_camera.view);
    self.cameras[? player_camera.view] = player_camera.id;

    self.playerCamCount = ds_list_size(self.player_view_list);

    if (player_camera.view > self.last_view) {
        self.last_view = player_camera.view;
    }
}
