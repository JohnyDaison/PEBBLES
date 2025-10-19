/// @param {Id.Instance} source
/// @param {Id.Instance} projectile
function addSourceVelocityToProjectile(source, projectile) {
    projectile.hspeed += source.hspeed;
    projectile.vspeed += source.vspeed;
}
