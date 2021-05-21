/// @description RECHECK

// CUT TAIL FALLS OFF
var count = body_size;
for (var i = count -1; i >= 0; i--) {
    var ter = ter_group.members[| i];
    
    if(is_undefined(ter) || !instance_exists(ter) || ter.damage >= ter.hp || ter.falling)
    {
        snake_mob_disassemble(i);
    }
}

if (done_for)  {
    instance_destroy();
    exit;
}

alarm[4] = recheck_delay;