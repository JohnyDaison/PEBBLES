/// @param {Id.Instance} player
/// @param {Real} score_value
/// @param {Bool} show
function increase_achievement_score(player, score_value, show) {
    increase_stat(player, "score", score_value, show);
    increase_stat(player, "achievements_score", score_value, false);
}
