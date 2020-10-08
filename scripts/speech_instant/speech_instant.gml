/// @description speech_instant(str)
/// @function speech_instant
/// @param strID
function speech_instant(argument0) {
	var strID = argument0;

	speech_start(strID);
	speech_popup.display_str = speech_popup.str;
	speech_popup.spoken_count = string_length(speech_popup.str);
	speech_popup.instant = true;



}
