import openfl.display.FPS;

public var icoP1:HealthIcon;
public var icoP2:HealthIcon;
var iconBop:Bool = true;
var startWidth = 1;

function create() {
	importScript("data/scripts/Note Skin Change");
    importScript("data/scripts/Extra Functions");
    importScript("data/scripts/Updators");
}

function postCreate() {
    icoP1 = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", true);
    icoP2 = new HealthIcon(dad != null ? dad.getIcon() : "face", false);
    for(ico in [icoP1, icoP2]) {
        startWidth = ico.width;
        ico.y = healthBar.y - (ico.height / 2);
        ico.cameras = [camHUD];
        insert(members.indexOf(healthBar) + 2, ico);
    }

    for (i in [iconP1, iconP2]) remove(i); // fuck you og icons

    changePlayerSkin("fever");
    changeCPUSkin("robofever");
}

function update(elapsed:Float){
    var aww = 0.045;
    aww = 0.09 / (FPS.currentFPS / 60);
    icoP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0)) - 26);
	icoP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0))) - (icoP2.width - 26);

    icoP1.health = healthBar.percent / 100;
    icoP2.health = 1 - (healthBar.percent / 100);

    for(ico in [icoP1, icoP2]) {
        if(iconBop){
            var multA:Float = robloxLerp(0, ico.angle, psychBoundTo(1 - (elapsed * 9), 0, 1));
            ico.angle = multA;
            icon.setGraphicSize(Std.int(FlxMath.lerp(ico.width, startWidth, aww * inst.pitch)));
            icon.updateHitbox();
            icon.setGraphicSize(Std.int(leatherBoundTo(ico.width, 0, startWidth + 30)));
            icon.updateHitbox();
        }
    }
}

var isRight:Bool = false;

function beatHit(){
    isRight = !isRight;
    if(iconBop){
        for(ico in [icoP1, icoP2]) {
            ico.setGraphicSize(Std.int(ico.width + (30 / (inst.pitch < 1 ? 1 : inst.pitch))));
            ico.updateHitbox();
            ico.setGraphicSize(Std.int(leatherBoundTo(ico.width, 0, ico.width + 30)));
            ico.updateHitbox();
            if(isRight)
                ico.angle = 20;
            else
                ico.angle = -20;
        }
    }
    icoP2.origin.set(150, 75);
    if(Options.camZoomOnBeat && camZooming && FlxG.camera.zoom < maxCamZoom && curBeat % camZoomingInterval == 0){
        FlxG.camera.zoom += .03 * camZoomingStrength;
        camHUD.zoom += .06 * camZoomingStrength;
    }
}

function onPostNoteCreation(event) {  
    var splashes = event.note;
	splashes.splash = "fever";
}