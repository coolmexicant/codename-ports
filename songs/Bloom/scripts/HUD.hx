public var icoP1:HealthIcon;
public var icoP2:HealthIcon;
var iconBop:Bool = true;

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

function changePlayerSkin(skin) {
	frames = Paths.getSparrowAtlas("game/notes/" + skin);

	for (strum in playerStrums) {
		strum.frames = frames;
		strum.antialiasing = true;
		strum.setGraphicSize(Std.int(frames.width * 0.7));
		var animPrefix = playerStrums.strumAnimPrefix[strum.ID % playerStrums.strumAnimPrefix.length];
		strum.animation.addByPrefix("static", "arrow" + animPrefix.toUpperCase());
		strum.animation.addByPrefix("pressed", animPrefix + " press", 24, false);
		strum.animation.addByPrefix("confirm", animPrefix + " confirm", 24, false);
		strum.updateHitbox();
		strum.playAnim("static");
	}

	for (note in playerStrums.notes) {
		note.frames = frames;

		switch (note.noteData % 4) {
			case 0:
				note.animation.addByPrefix("scroll", "purple0");
				note.animation.addByPrefix("hold", "purple hold piece");
				note.animation.addByPrefix("holdend", "pruple end hold");
			case 1:
				note.animation.addByPrefix("scroll", "blue0");
				note.animation.addByPrefix("hold", "blue hold piece");
				note.animation.addByPrefix("holdend", "blue hold end");
			case 2:
				note.animation.addByPrefix("scroll", "green0");
				note.animation.addByPrefix("hold", "green hold piece");
				note.animation.addByPrefix("holdend", "green hold end");
			case 3:
				note.animation.addByPrefix("scroll", "red0");
				note.animation.addByPrefix("hold", "red hold piece");
				note.animation.addByPrefix("holdend", "red hold end");
		}

		note.scale.set(0.7, 0.7);
		note.antialiasing = true;
		note.updateHitbox();

		if (note.isSustainNote) {
			note.animation.play("holdend");
			note.updateHitbox();

			if (note.nextSustain != null)
				note.animation.play('hold');
		} else
			note.animation.play("scroll");
	}
}

function changeCPUSkin(skin) {
	frames = Paths.getSparrowAtlas("game/notes/" + skin);

	for (strum in cpuStrums) {
		strum.frames = frames;
		strum.antialiasing = true;
		strum.setGraphicSize(Std.int(frames.width * 0.7));
		var animPrefix = cpuStrums.strumAnimPrefix[strum.ID % cpuStrums.strumAnimPrefix.length];
		strum.animation.addByPrefix("static", "arrow" + animPrefix.toUpperCase());
		strum.animation.addByPrefix("pressed", animPrefix + " press", 24, false);
		strum.animation.addByPrefix("confirm", animPrefix + " confirm", 24, false);
		strum.updateHitbox();
		strum.playAnim("static");
	}

	for (note in cpuStrums.notes) {
		note.frames = frames;

		switch (note.noteData % 4) {
			case 0:
				note.animation.addByPrefix("scroll", "purple0");
				note.animation.addByPrefix("hold", "purple hold piece");
				note.animation.addByPrefix("holdend", "pruple end hold");
			case 1:
				note.animation.addByPrefix("scroll", "blue0");
				note.animation.addByPrefix("hold", "blue hold piece");
				note.animation.addByPrefix("holdend", "blue hold end");
			case 2:
				note.animation.addByPrefix("scroll", "green0");
				note.animation.addByPrefix("hold", "green hold piece");
				note.animation.addByPrefix("holdend", "green hold end");
			case 3:
				note.animation.addByPrefix("scroll", "red0");
				note.animation.addByPrefix("hold", "red hold piece");
				note.animation.addByPrefix("holdend", "red hold end");
		}

		note.scale.set(0.7, 0.7);
		note.antialiasing = true;
		note.updateHitbox();

		if (note.isSustainNote) {
			note.animation.play("holdend");
			note.updateHitbox();

			if (note.nextSustain != null)
				note.animation.play('hold');
		} else
			note.animation.play("scroll");
	}
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