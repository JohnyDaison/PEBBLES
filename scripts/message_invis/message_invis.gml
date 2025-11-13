function MessageInvisibility(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Invisibility";
    self.abiColor = g_cyan;

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return get_control_name(abi) + " = Invisibility (Cyan)\n"
                +  "Turrets and mobs won't fire at you";
        }
    }
}
