/// @description  DUPLICATION FOR GUIDE AND OTHER PLAYERS
// TODO: Is this still used? Where? What was the benefit?
if (self.duplicate_me && !self.is_duplicate) {
    self.for_player = 1;

    show_debug_message("DUPLICATE CHECKPOINT");

    var total = gamemode_obj.player_count;

    for (var playerNumber = 0; playerNumber <= total; playerNumber++) {
        if (playerNumber == self.for_player) {
            continue;
        }

        var inst = instance_create(self.x, self.y, self.object_index);
        inst.for_player = playerNumber;

        if (playerNumber == 0) {
            inst.holographic = true;
        }

        inst.is_duplicate = true;
        inst.invisible = self.invisible;
    }
}
