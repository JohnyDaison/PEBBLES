function MessageMovement(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Movement";
    
    static message = function () {
        with (self.overlay) {
            return get_control_name(directions) + " = Move/Aim\n" +
                   get_control_name(jump) + " = Jump \nMOVE OUT!";
        }
    }

    static showCondition = function () {
        return true;
    }

    static hideCondition = function () {
        var my_guy = self.overlay.my_guy;
        var base = my_guy.my_base;

        if (!instance_exists(base)) {
            return false;
        }

        if (base.object_index == guy_spawner_obj) {
            if (instance_exists(base.my_shield) && point_distance(base.x, base.y, my_guy.x, my_guy.y) > base.my_shield.radius) {
                return true;
            }

            if (base.destroyed) {
                return true;
            }
        }
        else {
            return true;
        }

        return false;
    }

    static cancelCondition = function () {
        return false;
    }
}
