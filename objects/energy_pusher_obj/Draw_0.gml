var dirIndex = self.direction / 90;
var xx = 1, xcor = 0;
var yy = 1, ycor = 0;

if (dirIndex == 1) {
    ycor = 1;
}
else if (dirIndex == 2) {
    xcor = 1;
}

if (dirIndex > 1) {
    xx = -1;
}

draw_sprite_ext(self.sprite_index, self.image_index, self.x + xcor, self.y + ycor, xx, yy, (dirIndex mod 2) * 90, self.tint, 1);

event_inherited();
