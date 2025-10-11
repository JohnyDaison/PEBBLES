if (self.damage >= self.hp) {
    instance_destroy();
}
else {
    self.image_alpha = 1 - 0.66 * (self.damage / self.hp);
    self.image_index = irandom(10);
}
