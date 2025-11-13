function gui_focus_shift(argument0) {
    var shift_dir, focus_node, initing, find_focus, find_extreme, find_next,
        check_parent, check_node, done, refocus, safety_limit, repeats;

    show_debug_message("shifting focus");
    shift_dir = argument0;
    focus_node = self;
    initing = true;
    find_focus = false;
    find_extreme = false;
    find_next = false;
    check_parent = false;
    check_node = false;
    done = false;
    refocus = false;
    safety_limit = 250;
    repeats = 0;

    while (!done && repeats < safety_limit) {
        repeats += 1;

        show_debug_message("focus repeat: " + string(repeats));
        if (instance_exists(focus_node)) {
            show_debug_message("node id: " + string(focus_node.id));
        }

        // INIT
        if (!done && initing) {
            if (focus_node.content_focused != -1) {
                find_focus = true;
            }
            else {
                find_extreme = true;
            }
            initing = false;
        }

        // FIND FOCUSED NODE
        if (!done && find_focus && instance_exists(focus_node)) {
            show_debug_message("finding focus");
            if (ds_list_size(focus_node.gui_content) > 0 && focus_node.content_focused != -1) {
                new_focus_node = ds_list_find_value(focus_node.gui_content, focus_node.content_focused);
                if (!instance_exists(new_focus_node)) {
                    ds_list_delete(focus_node.gui_content, focus_node.content_focused);
                    focus_node.content_focused = -1;
                }
                else {
                    focus_node = new_focus_node;
                }
            }
            else {
                if (focus_node.active) {
                    done = true;
                }
                else {
                    with (focus_node) {
                        gui_lose_focus();
                    }
                    check_parent = true;
                    find_focus = false;
                }
            }
        }

        // CHECK NODE
        if (!done && check_node && instance_exists(focus_node)) {
            show_debug_message("checking node");

            if (focus_node.shift_stop_dir == shift_dir) {
                done = true;
            }
            else {
                count = ds_list_size(focus_node.gui_content);

                if (count != 0 && focus_node.enabled && focus_node.visible) {
                    show_debug_message("GO DEEPER");
                    find_extreme = true;
                }
                else {
                    if (focus_node.want_focus && focus_node.enabled && focus_node.visible) {
                        show_debug_message("OK");
                        done = true;
                        if (!focus_node.active && !focus_node.focused) {
                            refocus = true;
                        }
                    }
                    else {
                        show_debug_message("NOT OK");
                        find_next = true;
                    }
                }
            }

            check_node = false;
        }

        // CHECK IF PARENT EXISTS
        if (!done && check_parent && instance_exists(focus_node)) {
            show_debug_message("checking parent");
            if (instance_exists(focus_node.gui_parent) && !find_extreme) {
                find_next = true;
            }
            else {
                find_extreme = true;
                find_next = false;
            }
            check_parent = false;
        }

        // UPDATE STATS
        if (!done && instance_exists(focus_node)) {
            // CHECK FOR FAILS
            count = ds_list_size(focus_node.gui_content);

            show_debug_message("count: " + string(count));

            if (find_next && !instance_exists(focus_node.gui_parent)) {
                find_next = false;
                find_extreme = true;
            }

            if (count == 0 && find_extreme) {
                find_extreme = false;
                check_node = true;
            }

            // EXTREME STEP
            if (find_extreme) {
                show_debug_message("finding extreme");
                switch (shift_dir) {
                    case down:
                    case right:
                        focus_jump_index = 0;
                        //shift_delta = 1;
                        break;
                    case up:
                    case left:
                        focus_jump_index = count - 1;
                        //shift_delta = -1;
                        break;
                }
                show_debug_message("focus jump index: " + string(focus_jump_index));
                /*
                new_focus_node = ds_list_find_value(focus_node.gui_content, focus_jump_index);
                node_found = false;

                while (!node_found &&
                    ((shift_delta == 1 && focus_jump_index <= count - 1)
                        || (shift_delta == -1 && focus_jump_index >= 0))
                ) {
                    new_focus_node = ds_list_find_value(focus_node.gui_content, focus_jump_index);

                    if (new_focus_node.want_focus && new_focus_node.enabled && new_focus_node.visible) {
                        node_found = true;
                    }
                    else {
                        focus_jump_index += shift_delta;
                    }
                }

                if (node_found) {
                */
                    focus_node.content_focused = focus_jump_index;
                    focus_node = ds_list_find_value(focus_node.gui_content, focus_jump_index);

                    if (shift_dir == right || shift_dir == left) {
                        find_next = true;
                    }
                    else {
                        check_node = true;
                    }
                //}

                find_extreme = false;
            }

            // FIND NEXT
            if (find_next && instance_exists(focus_node)) {
                show_debug_message("finding next");
                parent = focus_node.gui_parent;
                list_size = ds_list_size(parent.gui_content);
                shift_stepped = false;

                if (parent.id == frame_manager.id && object_is_ancestor(focus_node.object_index, empty_frame)) {
                    if (focus_node.modal) {
                        //focus_node = ds_list_find_value(parent.gui_content,0);
                        find_extreme = true;
                        shift_stepped = true;
                    }
                }

                if (shift_dir == down && !shift_stepped) {
                    show_debug_message("shift down");
                    if (parent.content_focused + 1 < list_size) {
                        show_debug_message("success");
                        new_focus_node = ds_list_find_value(parent.gui_content, parent.content_focused + 1);

                        if (!is_undefined(new_focus_node)) {
                            if (instance_exists(new_focus_node)) {
                                parent.content_focused += 1;
                                focus_node = ds_list_find_value(parent.gui_content, parent.content_focused);
                                check_node = true;
                            }
                            else {
                                ds_list_delete(parent.gui_content, parent.content_focused + 1);

                                if (!parent.modal) {
                                    gui_clear_focus(focus_node);
                                    focus_node = parent;
                                    find_next = true;
                                }
                                else {
                                    focus_node.shift_stop_dir = shift_dir;
                                    check_node = true;
                                }
                            }
                        }
                    }
                    else {
                        show_debug_message("fail");
                        if (parent.id == frame_manager.id) {
                            check_node = true;
                            shift_dir = up;
                        }
                        else {
                            with (focus_node) {
                                gui_lose_focus();
                            }

                            focus_node = parent;

                            if (focus_node.modal) {
                                check_node = true;
                            }
                            else {
                                check_parent = true;
                            }
                        }
                    }
                    shift_stepped = true;
                }

                if (shift_dir == up && !shift_stepped) {
                    show_debug_message("shift up");
                    if (parent.content_focused - 1 >= 0) {
                        show_debug_message("success");
                        new_focus_node = parent.gui_content[| parent.content_focused - 1];

                        if (!is_undefined(new_focus_node)) {
                            if (instance_exists(new_focus_node)) {
                                parent.content_focused -= 1;
                                focus_node = parent.gui_content[| parent.content_focused];
                                check_node = true;
                            }
                            else {
                                ds_list_delete(parent.gui_content, parent.content_focused - 1);

                                if (!parent.modal) {
                                    gui_clear_focus(focus_node);
                                    focus_node = parent;
                                    find_next = true;
                                }
                                else {
                                    focus_node.shift_stop_dir = shift_dir;
                                    check_node = true;
                                }
                            }
                        }
                    }
                    else {
                        show_debug_message("fail");
                        if (parent.id == frame_manager.id) {
                            check_node = true;
                            shift_dir = down;
                        }
                        else {
                            //debugger - changed order 
                            with (focus_node) {
                                gui_lose_focus();
                            }

                            focus_node = parent;

                            if (focus_node.modal) {
                                check_node = true;
                            }
                            else {
                                check_parent = true;
                            }
                        }
                    }
                    shift_stepped = true;
                }

                if (shift_dir == right && !shift_stepped) {
                    show_debug_message("shift right");

                    if (instance_exists(focus_node.right_hand_object)) {
                        if (focus_node.right_hand_object.enabled && focus_node.right_hand_object.visible) {
                            focus_node = focus_node.right_hand_object;
                        }
                    }
                    done = true;
                    refocus = true;
                    shift_stepped = true;
                }

                if (shift_dir == left && !shift_stepped) {
                    show_debug_message("shift left");

                    if (instance_exists(focus_node.left_hand_object)) {
                        if (focus_node.left_hand_object.enabled && focus_node.left_hand_object.visible) {
                            focus_node = focus_node.left_hand_object;
                        }
                    }
                    done = true;
                    refocus = true;
                    shift_stepped = true;
                    /*
                    shift_found = false;
                    for (i = parent.content_focused - 1; i >= 0 && !shift_found; i += 1) {
                        object = ds_list_find_value(parent.gui_content, i);
                        if (abs(object.y - orig_focus_node.y) < hor_shift_tolerance && object.want_focus && object.enabled && object.visible) {
                            focus_node = object;
                            shift_found = true;
                        }
                    }

                    if (shift_found) {
                        check_node = true;
                    }
                    else {
                        show_debug_message("fail");
                        if (object_is_ancestor(parent.object_index, empty_frame)) {
                            check_node = true;
                            shift_dir = right;
                        }
                        else {
                            focus_node = parent;
                            with (focus_node) {
                                gui_lose_focus();
                            }
                            check_parent = true;
                        }
                    }
                    */
                }

                find_next = false;
            }
        }

        show_debug_message("done: " + string(done) + " refocus: " + string(refocus));

        if (done && refocus && instance_exists(focus_node)) {
            with (focus_node) {
                gui_get_focus();
            }
        }
    }
}
