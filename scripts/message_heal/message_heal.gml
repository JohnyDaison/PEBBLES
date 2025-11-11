function MessageHeal(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Heal";
    self.abiColor = g_green;

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return get_control_name(abi) + " = Heal (Green)\n"
                +  "Regenerate over time";
        }
    }
}
