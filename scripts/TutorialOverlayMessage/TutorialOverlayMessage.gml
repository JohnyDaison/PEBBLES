function TutorialOverlayMessage(overlay) constructor {
    self.overlay = overlay;
    self.title = "";

    /// @return {String}
    static message = function () {
        return "message";
    }

    /// @return {Bool}
    static showCondition = function () {
        return false;
    }

    /// @return {Bool}
    static hideCondition = function () {
        return false;
    }

    /// @return {Bool}
    static cancelCondition = function () {
        return false;
    }
}
