/// @description AUTO CLICK

if(self.ondown_script != noone)
    script_execute(self.ondown_script);
    
ondown_function();

if(self.onup_script != noone)
    script_execute(self.onup_script);
    
onup_function();