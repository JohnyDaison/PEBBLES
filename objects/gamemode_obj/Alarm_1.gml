/// @description CLOSE CENTER OVERLAY AND ACTIVATE BEAM TURRETS

if (singleton_obj.paused) {
    self.alarm[1] = 1;
    exit;
}

close_frame(center_overlay);
self.closed_welcome = true;

if (!self.single_cam) {
    main_camera_obj.on = false;
}

//main_camera_obj.normal_zoom = 0.8;
//main_camera_obj.zoom_level = 0.7;
singleton_obj.terrain_checked = false;

with (beam_turret_mount_obj) {
    self.charging = true;
}

self.alarm[2] = 60;
