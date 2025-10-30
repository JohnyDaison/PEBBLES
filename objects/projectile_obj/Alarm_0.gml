///@description SET UP FRICTION AND RULES
friction = orig_friction;

var RuleID = global.RuleID;
var curve_ball = rule_get_state(RuleID.CurveBalls);
var be_heavy = object_is_child(my_guy, guy_obj) && my_guy.status_left[? "heavy_shots"] > 0;

if(curve_ball)
{
    was_stopped = true;
    gravity_coef *= 2;
    gravity = gravity_coef;
}

if(be_heavy)
{
    orig_friction *= 2;
    friction = orig_friction;
    was_stopped = true;
    gravity_coef *= 10;
    gravity = gravity_coef;
}
