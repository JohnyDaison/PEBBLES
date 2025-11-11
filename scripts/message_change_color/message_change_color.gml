function MessageChangeColor(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Change color";

    static message = function () {
        with (self.overlay) {
            return  get_control_name(b) + "," +
                    get_control_name(g) + "," +
                    get_control_name(r) + " = choose Color\n" +
                    get_control_name(cast) + " = accept";
        }
    }

    static showCondition = function () {
        var my_guy = self.overlay.my_guy;
        
        return get_level(my_guy, "orbs1") > 0 || get_level(my_guy, "orbs2") > 0 || get_level(my_guy, "orbs4") > 0;
    }

    static hideCondition = function () {
        var my_guy = self.overlay.my_guy;

        return my_guy.my_color != g_dark;
    }

    static cancelCondition = function () {
        return false;
    }
}
