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
        var spawner = my_guy.my_spawner;
        var minDistance = 64;

        var startX = my_guy.xstart;
        var startY = my_guy.ystart;

        if (instance_exists(spawner)) {
            startX = spawner.x;
            startY = spawner.y;
        }

        return point_distance(startX, startY, my_guy.x, my_guy.y) > minDistance;
    }

    static cancelCondition = function () {
        return false;
    }
}
