///@description SET UP FRICTION AND RULES
self.friction = self.orig_friction;

var RuleID = global.RuleID;
var curve_ball = rule_get_state(RuleID.CurveBalls);
var be_heavy = object_is_child(self.my_guy, guy_obj) && self.my_guy.status_left[? "heavy_shots"] > 0;

if (curve_ball) {
    self.was_stopped = true;
    self.gravity_coef *= 2;
    self.gravity = self.gravity_coef;
}

if (be_heavy) {
    self.orig_friction *= 2;
    self.friction = self.orig_friction;
    self.was_stopped = true;
    self.gravity_coef *= 10;
    self.gravity = self.gravity_coef;
}
