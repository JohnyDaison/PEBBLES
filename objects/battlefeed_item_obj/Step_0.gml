if (self.fade_ratio > self.battlefeed.fade_speed) {
    self.fade_ratio -= self.battlefeed.fade_speed;
}
else {
    self.fade_ratio = 0;

    var msg_index = ds_list_find_index(self.battlefeed.msg_list, self.id);

    if (msg_index != -1) {
        ds_list_delete(self.battlefeed.msg_list, msg_index);
    }

    instance_destroy();
}
