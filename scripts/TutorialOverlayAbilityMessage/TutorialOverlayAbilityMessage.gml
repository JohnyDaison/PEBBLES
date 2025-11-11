function TutorialOverlayAbilityMessage(overlay): TutorialOverlayMessage(overlay) constructor {
    self.abiColor = g_nothing;
    
    /// @return {String}
    static message = function () {
        return "ABILITY";
    }
    
    /// @return {Bool}
    static showCondition = function () {
        var my_guy = self.overlay.my_guy;
        return my_guy.potential_color == self.abiColor;
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
