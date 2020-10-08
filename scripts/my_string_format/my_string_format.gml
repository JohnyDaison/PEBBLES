/// @description my_string_format(val, total, dec)
/// @function my_string_format
/// @param val
/// @param  total
/// @param  dec
function my_string_format(argument0, argument1, argument2) {
	var val = argument0;
	var total = argument1;
	var dec = argument2;

	var str = string_replace_all(string_format(val,total,dec)," ","0");

	return str;




}
