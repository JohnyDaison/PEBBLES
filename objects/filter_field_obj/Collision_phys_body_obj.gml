var body = other;

if (!self.isValidCollision(body, false)) {
    exit;
}

if (body.speed > self.speedlimit) {
    body.speed *= 0.8;
}

var oldxdiff = body.xprevious - self.x;
var oldydiff = body.yprevious - self.y;
var xdiff = (body.x + body.hspeed) - self.x;
var ydiff = (body.y + body.vspeed) - self.y;
var leftdiff = (body.bbox_right + body.hspeed) - self.x1;
var rightdiff = (body.bbox_left + body.hspeed) - self.x2;
var topdiff = (body.bbox_bottom + body.vspeed) - self.y1;
var bottomdiff = (body.bbox_top + body.vspeed) - self.y2;
var boost_coef = 1;
var hboost = 0;
var vboost = 0;

if (abs(leftdiff) < abs(rightdiff)) {
    hboost = -boost_coef;
}
else {
    hboost = boost_coef;
}

if (abs(topdiff) < abs(bottomdiff)) {
    vboost = -boost_coef;
}
else {
    vboost = boost_coef;
}

if (sign(oldxdiff) != sign(xdiff) && abs(body.hspeed) > self.speedlimit) {
    body.x = body.xprevious;
    body.hspeed = 0;
    hboost *= -1;
}

if (sign(oldydiff) != sign(ydiff) && abs(body.vspeed) > self.speedlimit) {
    body.y = body.yprevious;
    body.vspeed = 0;
    vboost *= -1;
}

if (sign(oldydiff) == -1 && sign(topdiff) == 1) {
    vboost -= (body.gravity + body.friction);
}

if (object_is_child(body, guy_obj)) {
    var guy = body;

    if (abs(topdiff) > 2) {
        guy.holding_wall = false;
    }

    if (guy.air_dashing) {
        guy.lost_control = true;
        guy.front_hit = true;
    }

    if (guy.max_doublejumps > 0 && guy.doublejump_count == guy.max_doublejumps) {
        guy.doublejump_count--;
    }
}

var boostedX = body.x + body.hspeed + hboost;
var boostedY = body.y + body.vspeed + vboost;

with (body) {
    if (!place_meeting(boostedX, body.y, body.blocking_object)) {
        body.hspeed += hboost;
    }

    if (!place_meeting(body.x, boostedY, body.blocking_object)) {
        body.vspeed += vboost;
    }
}
