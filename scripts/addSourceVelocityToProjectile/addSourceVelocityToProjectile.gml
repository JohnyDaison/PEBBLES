/// @param {Id.Instance} source
/// @param {Id.Instance} projectile
function addSourceVelocityToProjectile(source, projectile) {
    var maxApplicableDiff = 90;
    var angleDiff = abs(angle_difference(source.direction, projectile.direction));
    var reducedAngleDiff = min(angleDiff, maxApplicableDiff);
    var ratio = 1 - reducedAngleDiff / maxApplicableDiff;
    
    projectile.speed += ratio * source.speed;
}
