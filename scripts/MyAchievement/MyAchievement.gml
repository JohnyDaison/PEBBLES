/// @param {Id.Instance} myPlayer
function MyAchievement(myPlayer) constructor {
    self.myPlayer = myPlayer
    
    static title = "[title]";
    static verb = "[verb]";

    /// @return {Bool}
    static success = function() {
        return true;
    }

    /// @return {Bool}
    static fail = function() {
        return false;
    }

    /// @return {Real}
    static reward_score = function() {
        return 0;
    }

    /// @return {Bool}
    static reward = function() {
        return true;
    }
}