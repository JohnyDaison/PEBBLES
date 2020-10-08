///@param total_seconds
function seconds_to_time_str() {
	var total = argument[0];

	var minutes = string(total div 60);    
	var seconds = string(total mod 60);


	while(string_length(minutes) < 2)
	{
	    minutes = "0" + minutes;
	}
	while(string_length(seconds) < 2)
	{
	    seconds = "0" + seconds;
	}

	return minutes + ":" + seconds;


}
