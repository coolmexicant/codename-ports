var isRight:Bool = false;
var die:Bool = true;
var isFly:Bool = false;
var __timer:Float = 0;

function psychBoundTo(value:Float,min:Float,max:Float) {
    return Math.max(min, Math.min(max, value));
}

function postUpdate(elapsed) {
    if(!die){
        FlxG.camera.zoom = 1;
        camHUD.zoom = 1;
    }
    if(isFly){
        strumLines.members[0].characters[0].x += Math.cos((Conductor.songPosition / 1000) + (Conductor.bpm / 60) * 0.25);
        strumLines.members[1].characters[0].x -= Math.cos((Conductor.songPosition / 1000) + (Conductor.bpm / 60) * 0.25);
        strumLines.members[0].characters[0].y += Math.sin((Conductor.songPosition / 1000) + (Conductor.bpm / 60) * 0.25);
        strumLines.members[1].characters[0].y -= Math.sin((Conductor.songPosition / 1000) + (Conductor.bpm / 60) * 0.25);
        window.x = FlxMath.lerp(320, window.x, psychBoundTo(1 - (elapsed * 9), 0, 1));
        window.y = FlxMath.lerp(180, window.y, psychBoundTo(1 - (elapsed * 9), 0, 1));
    }else{
        strumLines.members[0].characters[0].x = -450;
        strumLines.members[1].characters[0].x = 1100;
        strumLines.members[0].characters[0].y = -250;
        strumLines.members[1].characters[0].y = -20;
        window.x = 320;
        window.y = 180;
    }
}

function beatHit(curBeat) {
    if(!die){
        FlxG.camera.zoom = 1;
        camHUD.zoom = 1;
    }
    if(isFly){
        window.x = strumLines.members[0].characters[0].x / 4;
        window.y = strumLines.members[0].characters[0].y / 4;
    }
}

function stepHit(curStep) {
    switch(curStep){
        case 256:
            isFly = true;
        case 767:
            die = false;
            isFly = false;
            FlxG.camera.followLerp = Math.pow(50,50);
        case 1025:
            die = true;
            isFly = true;
            FlxG.camera.followLerp = 0.05;
    }
}