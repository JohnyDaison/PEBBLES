/// @description destroy_anim_set()
/// @function destroy_anim_set
function destroy_anim_set() {

	clear_anim_set(true);

	ds_list_destroy(steps);



}
