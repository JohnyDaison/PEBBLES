function MessageBlink(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Blink";
    self.abiColor = g_blue;

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return "direction + " + get_control_name(abi) + " = Blink (Blue)\n"
                +  "Teleport in a direction by up to 8 blocks";
        }
    }

    /// @return {Bool}
    static showCondition = function () {
        var my_guy = self.overlay.my_guy;
        var RuleID = global.RuleID;

        return my_guy.potential_color == self.abiColor && rule_get_state(RuleID.Abilities) && has_level(my_guy, "teleport", 1);
    }
}
