if (instance_exists(self.my_player)) {
    self.my_camera = self.my_player.my_camera;

    if (instance_exists(self.my_camera)) {
        self.view_offset = get_view_offset(self.my_camera.view);

        self.x = self.view_offset.x + (view_get_wport(self.my_camera.view) / 2) - (self.width / 2);
        self.y = self.view_offset.y + view_get_hport(self.my_camera.view) - (self.height + self.abi_panel_height + 2 * self.margin);
    }
}
