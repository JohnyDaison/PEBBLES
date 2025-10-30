/// @param {Id.Instance} myPlayer
function UndyingAchievement(myPlayer) : MyAchievement(myPlayer) constructor {
    static title = "Undying";
    static verb = "has destroyed enemy Crystal without dying";
    
    /// @return {Bool}
    static success = function() {
        if (gamemode_obj.player_count == 2) {
            var opponent = gamemode_obj.players[? myPlayer.number mod 2 + 1];

            return (instance_exists(opponent.my_base) 
                && opponent.my_base.object_index == guy_spawner_obj
                && opponent.my_base.last_attacker_map[? "player"] == myPlayer.id
                && opponent.my_base.destroyed
                && myPlayer.stats[? "deaths"] == 0);
        }
        // TODO: proper general implementation with teams in mind

        return false;
    }

    /// @return {Bool}
    static fail = function() {
        var RuleID = global.RuleID;

        return !rule_get_state(RuleID.BaseCrystals) || myPlayer.stats[? "deaths"] > 0;
    }

    /// @return {Real}
    static reward_score = function() {
        return gamemode_obj.score_values[? "achiev_undying"];
    }

    /// @return {Bool}
    static reward = function() {
        return true;
    }
}
