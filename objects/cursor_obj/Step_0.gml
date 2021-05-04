if (keyboard_check(187)) {
    if(square_side < 512)
    {
        square_side += 1;
    }
}

if (keyboard_check(189)) {
    if(square_side > 1)
    {
        square_side -= 1;
    }
}