function MessageAttack(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Attack";
    
    static message = function () {
        with (self.overlay) {
            return get_control_name(cast) + " + direction = Attack\n"
                + "hold for stronger shot";
        }
    }

    static showCondition = function () {
        return true;
    }

    static hideCondition = function () {
        return self.overlay.my_guy.has_casted_ever;
    }

    static cancelCondition = function () {
        return false;
    }
}
