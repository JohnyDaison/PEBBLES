if (!self.collected && instance_exists(self.my_shield) && !other.done_for && self.holographic == other.holographic) {
    receive_damage(other.energy);
}
