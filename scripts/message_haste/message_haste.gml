function MessageHaste(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Haste";
    self.abiColor = g_yellow;
    self.playerLevelId = "haste";

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return get_control_name(abi) + " = Haste (Yellow)\n"
                +  "Run faster than usual";
        }
    }
}
