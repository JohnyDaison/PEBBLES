/// @description Reset Flag Spawner

if (!self.cancelled && instance_exists(self.my_flag_spawner)) {
    self.my_flag_spawner.reset_flag();
}

event_inherited();
