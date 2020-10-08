/// @description increase_achievement_score(player, score_value, show)
/// @function increase_achievement_score
/// @param player
/// @param score_value
/// @param show
function increase_achievement_score() {

	var player = argument[0];
	var score_value = argument[1];
	var show = argument[2];
        
	increase_stat(player, "score", score_value, show);
	increase_stat(player, "achievements_score", score_value, false);


}
