with (editor_guy_spawner_obj) {
    if (self.player_number > other.player_number) {
        self.player_number -= 1;
    }
}

event_inherited();
