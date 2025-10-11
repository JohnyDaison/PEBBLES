/// @param {Id.Instance} guy
function guy_provide_chargeball(guy) {
    if (has_level(guy, "chargeball", 1)) {
        if (!instance_exists(guy.charge_ball)) {
            var ii = instance_create(guy.x, guy.y, charge_ball_obj);

            ii.my_guy = guy.id;
            ii.my_player = guy.my_player;

            guy.charge_ball = ii;
        }
    }
}
