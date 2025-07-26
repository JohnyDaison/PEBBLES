/// @param {Id.Instance} player
function player_quests_destroy(player) {
    var count = 0;

    with (player) {
        count = ds_list_size(root_quest_list);
    
        for (var i = count-1; i >= 0; i--) {
            var context = root_quest_list[| i];
            player_quest_state_destroy(id, context);
        }
    
        ds_list_destroy(quest_category_list);
        ds_list_destroy(root_quest_list);
        ds_list_destroy(all_quest_list);
        ds_map_destroy(quest_states);
    }

    return count;
}
