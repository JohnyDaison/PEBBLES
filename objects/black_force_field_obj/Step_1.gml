event_inherited();

switch (self.shape) {
    case shape_circle:
        self.height = 2 * self.radius;
        self.width = 2 * self.radius;

        break;

    case shape_rect:
        self.radius = min(self.width, self.height);

        break;
}
