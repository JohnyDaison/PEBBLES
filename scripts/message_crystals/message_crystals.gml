function MessageCrystals(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Shard";

    static message = function () {
        return "Break the Shard's Shield and collect it";
    }

    static showCondition = function () {
        var my_guy = self.overlay.my_guy;

        with (crystal_obj) {
            var dist = point_distance(self.x, self.y, my_guy.x, my_guy.y);

            if (self.my_guy == self.id && dist < 320) {
                return true;
            }
        }

        return false;
    }

    static hideCondition = function () {
        with (guy_obj) {
            if (find_in_inventory(crystal_obj) != noone) {
                return true;
            }
        }

        return false;
    }

    static cancelCondition = function () {
        var my_guy = self.overlay.my_guy;
        var found = false;

        with (crystal_obj) {
            var dist = point_distance(self.x, self.y, my_guy.x, my_guy.y);

            if (self.my_guy == self.id && dist < 480) {
                found = true;
            }
        }

        return !found || self.overlay.cur_message_step > 900;
    }
}
