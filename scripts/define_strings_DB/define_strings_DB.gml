function define_strings_DB() {
	speech_splitter = "|";

	I18n[? "tut_guide/name"] = "Holo-Guide";
	I18n[? "tut_guide/hello_guide"] = "Hello, Guide.";

	quick_tutorial_movement_strings();
	quick_tutorial_base_colors_strings();
	quick_tutorial_catalyst_strings();
	quick_tutorial_basic_combat_strings();
	quick_tutorial_advanced_combat_strings();
	quick_tutorial_advanced_combat_strings_new();
	quick_tutorial_abilities_strings();

	tutorial_movement_strings();

	I18n[? "bark/welcome1"] = "Welcome.";
	I18n[? "bark/follow_me1"] = "Follow me!";
	I18n[? "bark/jump1"] = "Jump!";
	I18n[? "bark/go1"] = "Go, go.";
	I18n[? "bark/go2"] = "Go on.";
	I18n[? "bark/oops1"] = "Oops.";
	I18n[? "bark/oops2"] = "Ah oh.";

	I18n[? "secret/read1"] = "It says: \"$message\"";
	I18n[? "secret/observe1"] = "It's $description";
	I18n[? "secret/comment1"] = "$comment";



}
