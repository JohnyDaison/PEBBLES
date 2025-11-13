function MessageBlink(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Blink";
    self.abiColor = g_blue;
    self.playerLevelId = "teleport";

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return "direction + " + get_control_name(abi) + " = Blink (Blue)\n"
                +  "Teleport in a direction by up to 8 blocks";
        }
    }
}
