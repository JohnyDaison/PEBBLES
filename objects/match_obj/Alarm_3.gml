/// @description  WIN MESSAGE

center_overlay.message = "It's a draw!";

if(winner != noone)
{
    center_overlay.message = winner.name + " WINS!";
}

center_overlay.adjusted = false;
alarm[4] = 180;

if(reached_limit_name == "user_terminated")
{
    alarm[4] = 30;
}
