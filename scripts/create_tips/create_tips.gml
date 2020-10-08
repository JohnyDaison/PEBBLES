/// @description create_tips(db)
/// @function create_tips
/// @param db
function create_tips(argument0) {
	var db = argument0;

	if(instance_exists(db))
	{
	    var t = ds_list_create(), i=0;
	    db.tips = t;
    
	    t[|i++] = "DON'T PANIC";
	    t[|i++] = "Don't worry about the elephant.";
	    t[|i++] = "Damage of the same color as the body can heal it.";
	    t[|i++] = "When in doubt, change color.";
	    t[|i++] = "Don't forget to Shield up before going Berserk.";
	    t[|i++] = "During Channeling, you can absorb Sparks as Health.";
	    t[|i++] = "The universe you are currently in is most likely virtual.";
	    t[|i++] = "Go forth and BE AWESOME!";
	    t[|i++] = "You can turn down the Game Speed in the Settings.";
	}



}
