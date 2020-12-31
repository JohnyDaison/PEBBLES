function console_divider_level(characters, level) {
    var steps = clamp(DB.console_divider_max_steps - (level-1), 1, DB.console_divider_max_steps);
    console_divider_length(characters, steps * DB.console_divider_step_length);
}