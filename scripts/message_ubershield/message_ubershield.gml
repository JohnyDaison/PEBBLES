function MessageUbershield(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Ubershield";
    self.abiColor = g_magenta;

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return get_control_name(abi) + " = Ubershield (Magenta)\n"
                +  "Temporary Bigger Shield, protects from Dark attacks";
        }
    }
}
