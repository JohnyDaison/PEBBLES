if (keyboard_check(187)) {
    if (self.square_side < 512) {
        self.square_side += 1;
    }
}

if (keyboard_check(189)) {
    if (self.square_side > 1) {
        self.square_side -= 1;
    }
}