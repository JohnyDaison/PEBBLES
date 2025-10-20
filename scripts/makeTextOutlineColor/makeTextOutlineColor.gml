/// @pure
/// @param {Constant.Color} textColor
/// @param {Bool} contrasting 
/// @return {Constant.Color}
function makeTextOutlineColor(textColor, contrasting) {
    var redComponent = color_get_red(textColor);
    var greenComponent = color_get_green(textColor);
    var blueComponent = color_get_blue(textColor);
    
    if (contrasting) {
        redComponent = redComponent - 128;
        greenComponent = greenComponent - 128;
        blueComponent = blueComponent - 128;
    } else {
        redComponent = 128 - redComponent;
        greenComponent = 128 - greenComponent;
        blueComponent = 128 - blueComponent;
    }
    
    return make_color_rgb(redComponent, greenComponent, blueComponent);
}
