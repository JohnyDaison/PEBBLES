if (instance_exists(self.my_guy)) {
    self.x = my_guy.x;
    self.y = my_guy.y;

    part_type_color1(self.pt, self.my_guy.tint);

    var energy_ratio = max(0.2, self.my_guy.energy / self.my_guy.max_energy);

    part_type_size(self.pt, energy_ratio * 0.7, energy_ratio * 0.7, -0.03, 0);
    part_type_life(self.pt, energy_ratio * 10, energy_ratio * 25);
    part_type_speed(self.pt, energy_ratio * 5, energy_ratio * 5, -0.2, 0.2);
}

if (self.active) {
    part_emitter_region(self.system, self.em,
                        self.x - self.radius, self.x + self.radius, self.y - self.radius, self.y + self.radius,
                        ps_shape_ellipse, ps_distr_gaussian);
    part_emitter_burst(self.system, self.em, self.pt, 4);
}
