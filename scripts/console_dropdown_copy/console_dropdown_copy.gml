/// @description console_dropdown_copy()
/// @function console_dropdown_copy
function console_dropdown_copy() {

	var dropdown = console_window.menu_pane.command_drop;

	console_window.command_input.text =
	    dropdown.list_picker.scroll_list.items[| dropdown.value];



}
