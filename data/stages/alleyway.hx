import openfl.filters.ShaderFilter;
import funkin.backend.shaders.WiggleEffect;

var wiggleEffect:WiggleEffect;
var isFly:Bool = false;

function create() {
    dad.color = 0xFFA569BC;
    boyfriend.color = 0xFFA569BC;
    defaultCamZoom = 0.7;

    wiggleEffect = new WiggleEffect();
    wiggleEffect.shader.effectType.value = [4];
    wiggleEffect.waveAmplitude = 0.02;
    wiggleEffect.waveFrequency = 3;
    wiggleEffect.waveSpeed = 0.71;

    clocks.shader = wiggleEffect.shader;
}

function stepHit(curStep) {
    switch(curStep){
        case 256:
            dad.color = boyfriend.color = FlxColor.WHITE;
            defaultCamZoom = 0.53;
            camHUD.flash(FlxColor.WHITE, 0.5);
            whittyBG.visible = false;  
            isFly = true;
        case 767:
            isFly = false;
        case 1025:
            isFly = true;
    }
}

function postUpdate(elapsed) {
	if (wiggleEffect != null)
		wiggleEffect.update(elapsed);
    if(isFly){
        clockScar.y += Math.sin((Conductor.songPosition / 1000) + (Conductor.bpm / 60) * 0.25);
        clockFever.y -= Math.sin((Conductor.songPosition / 1000) + (Conductor.bpm / 60) * 0.25);
        clockScar.x += Math.cos((Conductor.songPosition / 1000) + (Conductor.bpm / 60) * 0.25);
        clockFever.x -= Math.cos((Conductor.songPosition / 1000) + (Conductor.bpm / 60) * 0.25);
    }else{
        clockScar.x = -190;
        clockFever.x = 990;
        clockScar.y = 680;
        clockFever.y = 695;
    }
}