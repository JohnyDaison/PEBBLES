function TutorialOverlayAbilityMessage(overlay): TutorialOverlayMessage(overlay) constructor {
    self.abiColor = g_nothing;
    self.playerLevelId = "";

    /// @return {String}
    static message = function () {
        return "ABILITY";
    }

    /// @return {Bool}
    static showCondition = function () {
        var my_guy = self.overlay.my_guy;
        var RuleID = global.RuleID;

        return my_guy.potential_color == self.abiColor && rule_get_state(RuleID.Abilities) && has_level(my_guy, self.playerLevelId, 1);
    }

    /// @return {Bool}
    static hideCondition = function () {
        var my_guy = self.overlay.my_guy;
        return my_guy.abi_cooldown[? self.abiColor] > 0;
    }

    /// @return {Bool}
    static cancelCondition = function () {
        var my_guy = self.overlay.my_guy;
        return my_guy.potential_color != self.abiColor;
    }
}
