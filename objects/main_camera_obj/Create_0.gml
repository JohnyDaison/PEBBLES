event_inherited();

guy_hor_dist = 128;
guy_ver_dist = 128;
view = 0;
only_cam = true;
on = true;
draw_debug = false;
gui_fix_applied = false;

self.player_view_list = ds_list_create();
self.cameras = ds_map_create();
count = 0;
last_view = 0;

bg_xoffset = 0;
bg_yoffset = 0;
bg_hspeed = -0.2;
bg_vspeed = 0;

function add_player_camera(player_camera) {
    ds_list_add(player_view_list, player_camera.view);
    cameras[? player_camera.view] = player_camera.id;
    
    count = ds_list_size(self.player_view_list);
    if (player_camera.view > last_view) {
        last_view = player_camera.view;
    }
}