function TutorialOverlayMessage(overlay, messageScript = undefined) constructor {
    self.overlay = overlay;
    self.script = messageScript;

    self.title = "";

    if (!is_undefined(messageScript)) {
        self.title = messageScript("title");
    }

    static message = function () {
        var result;
        with (self.overlay) {
            result = script_execute(other.script, "message");
        }
        return result;
    }

    static showCondition = function () {
        var result;
        with (self.overlay) {
            result = script_execute(other.script, "show_check");
        }
        return result;
    }

    static hideCondition = function () {
        var result;
        with (self.overlay) {
            result = script_execute(other.script, "hide_check");
        }
        return result;
    }

    static cancelCondition = function () {
        var result;
        with (self.overlay) {
            result = script_execute(other.script, "cancel_check");
        }
        return result;
    }
}
