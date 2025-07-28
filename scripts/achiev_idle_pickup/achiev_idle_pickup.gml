/// @param {Id.Instance} myPlayer
function IdlePickupAchievement(myPlayer) : MyAchievement(myPlayer) constructor {
    static title = "Idle Recipient";
    static verb = "was delivered something";

    /// @return {Bool}
    static success = function() {
        var guy = self.myPlayer.my_guy;
        
        if (instance_exists(guy)) {
            return guy.idle && guy.idle_start < (guy.last_added_item_step - 300);
        }

        return false;
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
