function tut_guide3_init() {
	npc_guy2_init();
	bot_type = "tut_guide";
	bot_activation_distance *= 10;
	bot_deactivation_distance *= 20;
	topic = empty_script;
	main_quest_id = "";
	main_context = "";

	npc_auto_demonstrate = false;
	has_spoken = false;
	has_autospoken = false;
	player_was_near = false;
	talk_start_dist = 48;
	talk_stop_dist = 96;
	autospeak_dist = 256;
	speech_color = g_green;
	speech_pitch = 1.2;

	last_selected_subtask = "";
	next_selected_subtask = "";
	last_subtask_state = "";
	next_subtask_state = "";
	last_subtask_change = 0;
	demonstration_mode = false;
	demonstration_start = 0;
	demonstration_done = true;
	grab_attention_mode = false;
	grab_attention_start = 0;
	grab_attention_duration = 90;
	grab_attention_done = false;
	npc_autospeak = false;

	subtask_change_min_delay = 180; // 180
	subtask_change_delay_range = 60; //60
	subtask_change_fast_min_delay = 1;
	subtask_change_fast_delay_range = 0;

	npc_confusion_start_delay = 15;
	npc_confusion_stop_delay = 10;

	my_tp_sound = noone;


}
