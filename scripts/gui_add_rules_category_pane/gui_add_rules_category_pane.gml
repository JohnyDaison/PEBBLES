function gui_add_rules_category_pane(category, gmrule_controls, rule_grid_unit) {
    var pane = rules_scroll_list.add_item();
    with (pane) {
        bg_color = c_black;
        bg_alpha = 0.8;
        text = category.name;
        
        var hor_spacing = 8;
        var vert_spacing = 8;
        var heading_height = 24;
        
        eloffset_x = x + hor_spacing;
        eloffset_y = y + heading_height + vert_spacing;
        
        var rule_chb_size = 40;
        var rule_dist = rule_grid_unit;
        var rules_width = width;

        var rules_content_x = eloffset_x;
        var gmrule_id, gmRule, gmrule_type, i, ii, rules, count;
        
        rules = category.rules;
        count = array_length(rules);

        for(i=0; i<count; i++)
        {
            gmrule_id = rules[i];
            gmRule = DB.gamemode_rules[? gmrule_id];
            gmrule_type = gmRule.type;
            
            if(gmrule_type == RuleType.Bool) {
                rule_dist = rule_grid_unit;
            }
        
            if(gmrule_type == RuleType.Number) {
                rule_dist = 2 * rule_grid_unit;
            }
            
            if((eloffset_x + rule_dist) > (rules_content_x + rules_width))
            {
                eloffset_x = rules_content_x;
                eloffset_y += rule_grid_unit + vert_spacing;
            }
            
            if(gmrule_id != "blank_space")
            {
                ii = noone;
        
                if(gmrule_type == RuleType.Bool)
                {
                    ii = gui_add_rule_boolbox(0, 0, gmrule_id, rule_chb_size);

                    ii.checkbox.user_clicked_script = rule_chb_user_click_script;
                    ii.checkbox.onchange_script = schedule_play_summary_update;
                    ii.checkbox.draw_unlocked_border = true;
                }
                else if(gmrule_type == RuleType.Number)
                {
                    ii = gui_add_rule_numberbox(0, 0, gmrule_id, rule_chb_size);

                    ii.checkbox.user_clicked_script = rule_chb_user_click_script;
                    ii.checkbox.onchange_script = number_rule_change_state_script;
                    ii.checkbox.draw_unlocked_border = true;
                    
                    ii.number_input.onchange_script = number_rule_change_value_script;
                }
            
                gmrule_controls[? gmrule_id] = ii;
            }
            
            eloffset_x += rule_dist;
        }
    
        eloffset_y += rule_grid_unit + vert_spacing + 4;
    }
    
    rules_scroll_list.resize_item(pane.item_index, pane.eloffset_y - pane.y);
    
    rules_scroll_list.update()
    
    return pane;
}