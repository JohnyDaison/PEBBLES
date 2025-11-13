function MessageChanneling(overlay): TutorialOverlayMessage(overlay) constructor {
    self.title = "Channeling";

    /// @return {String}
    static message = function () {
        with (self.overlay) {
            return "Low on energy? Return to base, or hold " + get_control_name(channel);
        }
    }

    /// @return {Bool}
    static showCondition = function () {
        return self.guyHasLowColor();
    }

    /// @return {Bool}
    static hideCondition = function () {
        return self.overlay.my_guy.channeling;
    }

    /// @return {Bool}
    static cancelCondition = function () {
        return !self.guyHasLowColor();
    }

    /// @return {Bool}
    static guyHasLowColor = function () {
        var my_guy = self.overlay.my_guy;
        var comp = color_to_components(my_guy.my_color);
        var powerLevelThreshold = 0.5;
        
        var low_color = false;

        for (var col = g_red; col <= g_blue; col++) {
            if (col == g_yellow) {
                    continue;
                }
            
            if (comp[col] && get_orb_list_power_level(my_guy.orbs_in_use[? col]) < powerLevelThreshold) {
                low_color = true;
            }
        }

        return low_color;
    }
}
