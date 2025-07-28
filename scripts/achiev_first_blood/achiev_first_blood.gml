/// @param {Id.Instance} myPlayer
function FirstBloodAchievement(myPlayer) : MyAchievement(myPlayer) constructor {
    static title = "First Kill";
    static verb = "got First kill";

    /// @return {Bool}
    static success = function() {
        var what = noone;
        var achievPlayer = self.myPlayer;

        if (gamemode_obj.player_count == 1) {
            return false;
        }

        with (guy_obj) {
            if (dead && my_player != achievPlayer.id && last_attacker_map[? "player"] == achievPlayer.id) {
                what = last_attacker_map[? "source"];
            }
        }

        return achievPlayer.stats[? "kills"] > 0 && what == guy_obj;
    }

    /// @return {Bool}
    static fail = function() {
        var ret = false;
        
        if (!isPlayerStat(self.myPlayer, "kills", "highest", false)) {
            ret = true;
        }

        if (self.myPlayer.stats[? "kills"] > 0) {
            if (!self.success())
                ret = true;
        }
        
        return ret;
    }

    /// @return {Real}
    static reward_score = function() {
        return gamemode_obj.score_values[? "achiev_first_blood"];
    }

    /// @return {Bool}
    static reward = function() {
        return true;
    }
}
