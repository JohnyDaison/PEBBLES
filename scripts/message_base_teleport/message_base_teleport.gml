function MessageTeleport(overlay): TutorialOverlayAbilityMessage(overlay) constructor {
    self.title = "Teleport";
    self.abiColor = g_white;

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return get_control_name(abi) + " = Teleport (White)\n"
                +  "Return to Base instantly";
        }
    }
}
