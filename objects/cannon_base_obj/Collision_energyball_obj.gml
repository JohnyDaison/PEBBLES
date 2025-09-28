if (self.my_player != other.my_player && !self.destroyed && other.holographic == self.holographic) {
    receive_damage(other.force);
}
