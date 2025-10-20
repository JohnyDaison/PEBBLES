if (!self.collected && instance_exists(self.my_shield) && self.holographic == other.holographic) {
    //show_debug_message("projectile collision");
    receive_damage(other.force);
}
