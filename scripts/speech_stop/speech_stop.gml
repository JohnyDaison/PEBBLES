/// @description speech_stop([interrupted])
/// @function speech_stop
/// @param [interrupted]
function speech_stop() {

	var interrupted = false;
	if(argument_count > 0)
	{
	    interrupted = argument[0];
	}

	var stopped_count = 0;

	self.speaking = false;

	with(speech_popup_obj)
	{
	    if(source == other.id && !fading)
	    {
	        fading = true;
	        alarm[0] = max_alpha_length + fade_out_length;
        
	        if(interrupted)
	        {
	            self.interrupted = true;
	            alarm[0] = fade_out_length;
	        }
        
	        stopped_count++;
	    }
	}

	self.speech_popup = noone;

	return stopped_count;


}
