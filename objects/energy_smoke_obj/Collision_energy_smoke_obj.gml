if (self.my_color == other.my_color && self.my_guy == other.my_guy && self.holographic == other.holographic
    && !self.consolidated && self.speed < 0.5 && other.speed < 0.5) {
    //other.force = mean(self.force, other.force);
    other.force += self.force;
    other.consolidated = true;
    other.x = mean(other.x, self.x);
    other.y = mean(other.y, self.y);

    instance_destroy();
}
