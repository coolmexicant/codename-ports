var isRight:Bool = false;
var die:Bool = true;
var isFly:Bool = false;
var __timer:Float = 0;
var mirror:CustomShader = null;

function create() {
    mirror = new CustomShader("MirrorRepeatEffect");
    camGame.addShader(mirror);
    camHUD.addShader(mirror);
    mirror.zoom = 1;
    window.x = 320;
    window.y = 180;
}

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
        if(window.x > 640 || window.x < 0)
            window.x = 0;
        else
            window.x += 1;
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
}

function stepHit(curStep) {
    switch(curStep){
        case 256:
            isFly = true;
        case 767:
            die = false;
            isFly = false;
            FlxG.camera.followLerp = Math.pow(50,50);
        case 800:
            mirror.zoom = 1.4;
        case 832:
            mirror.zoom = 1.8;
        case 864:
            mirror.zoom = 2;
        case 896:
            mirror.zoom = 2.4;
        case 912:
            mirror.zoom = 2.8;
        case 928:
            mirror.zoom = 3;
        case 944:
            mirror.zoom = 3.4;
        case 960:
            mirror.zoom = 3.8;
        case 976:
            mirror.zoom = 4;
        case 992:
            mirror.zoom = 4.4;
        case 1000:
            mirror.zoom = 4.8;
        case 1025:
            die = true;
            isFly = true;
            FlxG.camera.followLerp = 0.05;
            FlxTween.num(4.8, 1, 2, {ease: FlxEase.sineOut}, function(a) mirror.zoom = a);
    }
}