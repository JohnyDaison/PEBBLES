function MessageLoadCannon(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Load Cannon";

    /// @return {String}
    static message = function () {
        return "You have extra Color Orbs,\nget inside your Cannon to load them.";
    }

    /// @return {Bool}
    static showCondition = function () {
        var my_guy = self.overlay.my_guy;
        var cannon = self.getCannon();

        if (cannon == noone) {
            return false;
        }

        for (var col = g_red; col <= g_blue; col++) {
            if (col == g_yellow) {
                continue;
            }

            if (my_guy.orb_reserve[? col] >= 1) {
                return true;
            }
        }

        return false;
    }

    /// @return {Bool}
    static hideCondition = function () {
        var cannon = self.getCannon();

        if (cannon == noone) {
            return true;
        }

        if (cannon.shot_color > g_dark) {
            return true;
        }

        return false;
    }

    /// @return {Bool}
    static cancelCondition = function () {
        var my_guy = self.overlay.my_guy;
        var orb_found = false;

        for (var col = g_red; col <= g_blue; col++) {
            if (col == g_yellow) {
                continue;
            }

            if (my_guy.orb_reserve[? col] >= 1) {
                orb_found = true;
            }
        }

        return !orb_found || self.overlay.cur_message_step > 900;
    }
    
    /// @return {Id.Instance}
    static getCannon = function () {
        var base = self.overlay.my_guy.my_base;

        if (!instance_exists(base) || base.object_index != guy_spawner_obj) {
            return noone;
        }

        if (!instance_exists(base.base_cannon)) {
            return noone;
        }
        
        return base.base_cannon;
    }
}
