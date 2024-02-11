public var icoP1:HealthIcon;
public var icoP2:HealthIcon;
var iconBop:Bool = true;

function create() {
	importScript("data/scripts/Note Skin Change");
}

function postCreate() {
    icoP1 = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", true);
    icoP2 = new HealthIcon(dad != null ? dad.getIcon() : "face", false);
    for(ico in [icoP1, icoP2]) {
        ico.y = healthBar.y - (ico.height / 2);
        ico.cameras = [camHUD];
        insert(members.indexOf(healthBar) + 2, ico);
    }

    for (i in [iconP1, iconP2]) remove(i); // fuck you og icons

    changePlayerSkin("fever");
    changeCPUSkin("robofever");
}

function psychBoundTo(value:Float,min:Float,max:Float) {
    return Math.max(min, Math.min(max, value));
}

function update(elapsed:Float){
    icoP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0)) - 26);
	icoP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0))) - (icoP2.width - 26);

    icoP1.health = healthBar.percent / 100;
    icoP2.health = 1 - (healthBar.percent / 100);

    for(ico in [icoP1, icoP2]) {
        if(iconBop){
            var multX:Float = FlxMath.lerp(1, ico.scale.x, psychBoundTo(1 - (elapsed * 9), 0, 1));
            var multY:Float = FlxMath.lerp(1, ico.scale.y, psychBoundTo(1 - (elapsed * 9), 0, 1));
            var multA:Float = FlxMath.lerp(0, ico.angle, psychBoundTo(1 - (elapsed * 9), 0, 1));
            ico.scale.set(multX, multY);
            ico.angle = multA;
            ico.updateHitbox();
        }
    }

    if(camZooming){
        FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, psychBoundTo(1 - (elapsed * 9), 0, 1));
        camHUD.zoom = FlxMath.lerp(defaultHudZoom, camHUD.zoom, psychBoundTo(1 - (elapsed * 9), 0, 1));
    }

    var multBG:Float = FlxMath.lerp(FlxG.height * 0.9, healthBarBG.y, psychBoundTo(1 - (elapsed * 9), 0, 1));
    healthBarBG.y = multBG;
    var mult:Float = FlxMath.lerp(FlxG.height * 0.9, healthBarBG.y + 4, psychBoundTo(1 - (elapsed * 9), 0, 1));
    healthBar.y = mult;
}

var isRight:Bool = false;

function beatHit(){
    isRight = !isRight;
    if(iconBop){
        for(ico in [icoP1, icoP2]) {
            ico.scale.set(2, .3);
            ico.updateHitbox();
            if(isRight)
                ico.angle = 20;
            else
                ico.angle = -20;
        }
        healthBarBG.y -= 25;
        healthBar.y -= 25;
    }
    icoP2.origin.set(150, 75);
    if(Options.camZoomOnBeat && camZooming && FlxG.camera.zoom < maxCamZoom && curBeat % camZoomingInterval == 0){
        FlxG.camera.zoom += .015 * camZoomingStrength;
        camHUD.zoom += .03 * camZoomingStrength;
    }
}

function onPostNoteCreation(event) {  
    var splashes = event.note;
	splashes.splash = "fever";
}