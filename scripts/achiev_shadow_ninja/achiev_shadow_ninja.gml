/// @param {Id.Instance} myPlayer
function ShadowNinjaAchievement(myPlayer) : MyAchievement(myPlayer) constructor {
    static title = "Shadow Ninja";
    static verb = "has killed without leaving the shadows";
    
    /// @return {Bool}
    static success = function() {
        var what = noone;
        var achievPlayer = self.myPlayer;

        with (guy_obj) {
            if (dead && my_player != achievPlayer.id && last_attacker_map[? "player"] == achievPlayer.id) {
                what = last_attacker_map[? "source"];
            }
        }

        return achievPlayer.stats[? "kills"] > 0 && what == guy_obj;
    }

    /// @return {Bool}
    static fail = function() {
        var guy = self.myPlayer.my_guy;
        return guy.my_color > g_dark && !guy.channeling;
    }

    /// @return {Real}
    static reward_score = function() {
        return gamemode_obj.score_values[? "achiev_shadow_ninja"];
    }

    /// @return {Bool}
    static reward = function() {
        return true;
    }
}
