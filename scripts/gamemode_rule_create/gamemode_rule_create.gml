/// @param {String} ruleId
/// @param {String} name
/// @param {Real} type values: RuleType.Bool or RuleType.Number
/// @param {Bool} public is it exposed in the UI
/// @param {Asset.GMSprite} icon
/// @param {String} description
function gamemode_rule_create(ruleId, name, type, public, icon = noone, description = "") {
    if (ds_list_find_index(self.gamemode_rule_list, ruleId) != -1) {
        return;
    }

    var rule = new Rule(name, type, public, icon, description);

    ds_list_add(self.gamemode_rule_list, ruleId);
    self.gamemode_rules[? ruleId] = rule;

    return rule;
}
