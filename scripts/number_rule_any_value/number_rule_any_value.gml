function number_rule_any_value(gmRule, new_value) {
    return gmRule.type == RuleType.Number && is_bool(new_value) && new_value;
}