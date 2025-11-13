var count = ds_list_size(self.player_view_list);

for (var viewIndex = count - 1; viewIndex >= 0; viewIndex--) {
    var player_view = self.player_view_list[| viewIndex];
    var camera = self.cameras[? player_view];

    instance_destroy(camera);
}

ds_map_destroy(self.cameras);
ds_list_destroy(self.player_view_list);

event_inherited();
