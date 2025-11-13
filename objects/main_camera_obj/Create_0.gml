event_inherited();

self.guy_hor_dist = 128;
self.guy_ver_dist = 128;
self.view = 0;
self.only_cam = true;
self.on = true;
self.draw_debug = false;
self.gui_fix_applied = false;

self.player_view_list = ds_list_create();
self.cameras = ds_map_create();
self.playerCamCount = 0;
self.last_view = 0;

self.bg_xoffset = 0;
self.bg_yoffset = 0;
self.bg_hspeed = -0.2;
self.bg_vspeed = 0;

self.autoTogglePlayerCameras = gamemode_obj.player_count == 2;
self.autoToggleDelay = 5 * 60;
self.lastAutoToggleStep = 0;

self.offZoneOffsets = {
    top: 320,
    "left": 160,
    bottom: 160,
    "right": 160,
}

/// @param {Id.Instance} player_camera
function add_player_camera(player_camera) {
    ds_list_add(self.player_view_list, player_camera.view);
    self.cameras[? player_camera.view] = player_camera.id;

    self.playerCamCount = ds_list_size(self.player_view_list);

    if (player_camera.view > self.last_view) {
        self.last_view = player_camera.view;
    }
}

function playerCameraToggling() {
    if (!self.autoTogglePlayerCameras) {
        return;
    }

    var currentPositionsInOnZone = 0;
    var predictedPositionsInOnZone = 0;
    var currentPositionsInOffZone = 0;
    var predictedPositionsInOffZone = 0;

    var viewCamera = view_get_camera(self.view);
    var viewX = camera_get_view_x(viewCamera);
    var viewY = camera_get_view_y(viewCamera);
    var viewWidth = camera_get_view_width(viewCamera);
    var viewHeight = camera_get_view_height(viewCamera);

    var viewWidthFraction = viewWidth / 8;
    var viewHeightFraction = viewHeight / 8;
    var predictionSteps = 10;

    var offZone = {
        x1: viewX + self.offZoneOffsets."left",
        y1: viewY + self.offZoneOffsets.top,
        x2: viewX + viewWidth - self.offZoneOffsets."right",
        y2: viewY + viewHeight - self.offZoneOffsets.bottom
    };

    var onZone = {
        x1: self.x - viewWidthFraction,
        y1: self.y - viewHeightFraction,
        x2: self.x + viewWidthFraction,
        y2: self.y + viewHeightFraction
    };

    for (var viewIndex = 0; viewIndex < self.playerCamCount; viewIndex++) {
        var player_view = self.player_view_list[| viewIndex];
        var cam = self.cameras[? player_view];
        var guy = cam.my_guy;

        var currentPosition = {
            x: guy.x,
            y: guy.y
        };

        var predictedPosition = {
            x: guy.x + guy.hspeed * predictionSteps,
            y: guy.y + guy.vspeed * predictionSteps
        };

        if (currentPosition.x < offZone.x1 ||
            currentPosition.x > offZone.x2 ||
            currentPosition.y < offZone.y1 ||
            currentPosition.y > offZone.y2) {
            currentPositionsInOffZone++;
        }
        else if (currentPosition.x > onZone.x1 &&
            currentPosition.x < onZone.x2 &&
            currentPosition.y > onZone.y1 &&
            currentPosition.y < onZone.y2) {
            currentPositionsInOnZone++;
        }

        if (predictedPosition.x < offZone.x1 ||
            predictedPosition.x > offZone.x2 ||
            predictedPosition.y < offZone.y1 ||
            predictedPosition.y > offZone.y2) {
            predictedPositionsInOffZone++;
        }
        else if (predictedPosition.x > onZone.x1 &&
            predictedPosition.x < onZone.x2 &&
            predictedPosition.y > onZone.y1 &&
            predictedPosition.y < onZone.y2) {
            predictedPositionsInOnZone++;
        }
    }

    var timeSinceLastToggle = singleton_obj.step_count - self.lastAutoToggleStep;

    if (currentPositionsInOffZone > 0) { //  || predictedPositionsInOffZone > 0
        if (self.on) {
            self.lastAutoToggleStep = singleton_obj.step_count;
        }

        self.on = false;
    }
    else if (timeSinceLastToggle > self.autoToggleDelay &&
        currentPositionsInOnZone == self.playerCamCount &&
        predictedPositionsInOnZone == self.playerCamCount) {
        if (!self.on) {
            self.lastAutoToggleStep = singleton_obj.step_count;
        }

        self.on = true;
    }
}
