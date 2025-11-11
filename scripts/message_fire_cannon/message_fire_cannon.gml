function MessageFireCannon(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Fire Cannon";

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return "Inside cannon: " + get_control_name(cast) + " + directions = Aim\n"
                +  "In or outside: " + get_control_name(altfire) + " = Toggle Autofire";
        }
    }

    /// @return {Bool}
    static showCondition = function () {
        var cannon = self.getCannon();

        if (cannon == noone) {
            return false;
        }

        if (cannon.shot_color > g_dark) {
            return true;
        }

        return false;
    }

    /// @return {Bool}
    static hideCondition = function () {
        var cannon = self.getCannon();

        if (cannon == noone) {
            return true;
        }

        with (big_projectile_obj) {
            if (self.my_guy == cannon) {
                return true;
            }
        }

        return false;
    }

    /// @return {Bool}
    static cancelCondition = function () {
        return self.overlay.cur_message_step > 900;
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

