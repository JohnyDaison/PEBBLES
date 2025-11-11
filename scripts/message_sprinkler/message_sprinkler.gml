
function MessageSprinkler(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Sprinkler";

    /// @return {String}
    static message = function () {
        return "Kill the Sprinkler for score and Color Orbs.";
    }

    /// @return {Bool}
    static showCondition = function () {
        return instance_exists(sprinkler_body_obj);
    }

    /// @return {Bool}
    static hideCondition = function () {
        var my_guy = self.overlay.my_guy;

        if (instance_exists(sprinkler_body_obj)) {
            return (sprinkler_body_obj.last_attacker_map[? "source"] == my_guy);
        }

        return false;
    }

    /// @return {Bool}
    static cancelCondition = function () {
        return self.overlay.cur_message_step > 600;
    }
}
