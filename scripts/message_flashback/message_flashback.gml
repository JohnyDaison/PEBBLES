function MessageFlashback(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Rewind";
    self.abiColor = g_dark;

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return get_control_name(abi) + " = Rewind (Dark)\n"
                +  "Return in time by 2 seconds";
        }
    }
}
