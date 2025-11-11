
function MessageCreateShield(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Shield";

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return get_control_name(cast) + " + no direction = Shield";
        }
    }

    /// @return {Bool}
    static showCondition = function () {
        var my_guy = self.overlay.my_guy;
        return my_guy.my_color > g_dark;
    }

    /// @return {Bool}
    static hideCondition = function () {
        var my_guy = self.overlay.my_guy;
        return instance_exists(my_guy.my_shield);
    }

    /// @return {Bool}
    static cancelCondition = function () {
        var my_guy = self.overlay.my_guy;
        return my_guy.my_color <= g_dark;
    }
}
