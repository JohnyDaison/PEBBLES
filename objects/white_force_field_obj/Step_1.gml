event_inherited();

if (instance_exists(self.my_projector) && self.my_spawner == noone) {
    self.my_spawner = self.my_projector;
}

if (instance_exists(self.my_spawner) && self.my_guy == noone) {
    self.my_guy = self.my_spawner.my_guy;
}

switch (shape) {
    case shape_circle:

        self.height = 2 * self.radius;
        self.width = 2 * self.radius;

        break;

    case shape_rect:

        self.radius = min(self.width, self.height);

        break;
}
