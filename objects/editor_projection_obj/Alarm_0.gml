var projector = instance_nearest(self.x, self.y, projector_obj);

if (instance_exists(projector)) {
    if (distance_to_object(projector) < projector.radius) {
        projector.text_x = self.x - projector.x;
        projector.text_y = self.y - projector.y;
        projector.text = self.text;
    }
}

instance_destroy();
