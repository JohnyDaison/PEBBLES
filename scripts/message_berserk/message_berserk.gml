function MessageBerserk(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Berserk";
    self.abiColor = g_red;

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return get_control_name(abi) + " = Berserk (Red)\n"
                +  "Charge shots faster";
        }
    }
}
