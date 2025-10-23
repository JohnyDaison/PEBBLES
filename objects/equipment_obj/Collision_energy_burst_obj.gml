if (!self.unhittable && other.holographic == self.holographic && !other.done_for) {
    receive_damage(other.energy);
}
