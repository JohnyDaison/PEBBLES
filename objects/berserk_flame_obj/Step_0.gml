if (instance_exists(self.my_guy)) {
    self.x = self.my_guy.x;
    self.y = self.my_guy.y;
}

if (self.active) {
    part_emitter_region(self.system, self.em, self.x - 6, self.x + 6, self.y - 23, self.y + 25, ps_shape_diamond, ps_distr_gaussian);
    part_emitter_burst(self.system, self.em, self.pt, 5);
}
