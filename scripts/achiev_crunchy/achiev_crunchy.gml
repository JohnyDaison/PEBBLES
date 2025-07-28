/// @param {Id.Instance} myPlayer
function CrunchyAchievement(myPlayer) : MyAchievement(myPlayer) constructor {
    static title = "Crunchy";
    static verb = "is Crunchy!";
    
    /// @return {Bool}
    static success = function() {
        if (gamemode_obj.is_campaign) {
            return false;
        }

        return self.myPlayer.stats[? "score"] >= gamemode_obj.score_values[? "crunchy_limit"];
    }

    /// @return {Bool}
    static fail = function() {
        return false;
    }

    /// @return {Bool}
    static reward = function() {
        return true;
    }
}
