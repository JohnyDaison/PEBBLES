if (instance_exists(self.my_guy)) {
    self.x = self.my_guy.x;
    self.y = self.my_guy.y;
}

/*
part_emitter_region(self.system, self.em, self.x - 28, self.x + 26, self.y - 33, self.y + 34, 2, 1);
part_emitter_burst(self.system, self.em, self.pt, 14);
*/

if (self.active) {
    part_emitter_region(self.system, self.em, self.x - 12, self.x + 12, self.y - 23, self.y + 23, ps_shape_rectangle, ps_distr_gaussian);

    if (self.my_guy.step_count mod 8 == 0) {
        part_emitter_burst(self.system, self.em, self.pt, 1);
    }
}
