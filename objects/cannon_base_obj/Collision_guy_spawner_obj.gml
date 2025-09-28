if (point_distance(self.x, self.y, other.x, other.y) < 16 && !other.destroyed) {
    other.done_for = true;
    other.damage = other.hp;

    instance_destroy();
}
