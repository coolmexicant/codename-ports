import funkin.backend.utils.CoolUtil;
import funkin.backend.utils.CoolUtil.CoolSfx;

var subway_bg:FunkinSprite;
var story:FlxSprite;
var backsubway:FunkinSprite;
var options:FlxSprite;
var freeplay:FlxSprite;
var storyMouse:FlxSprite;
var optionsMouse:FlxSprite;
var freeplayMouse:FlxSprite;

var secretWord:Array<String> = ["S", "H", "A", "D", "O", "W"];
var maxLetters:Int = 5; //Since is from 1 - 6, haxe uses 0 as the start
var curLetter:Int = 0;

function create() {
    FlxG.mouse.visible = true;
    story= new FlxSprite(150, 130);
    story.frames = Paths.getSparrowAtlas('menus/mainmenu/trainmenu');
    story.animation.addByPrefix('come', 'Train come', 24, false);
    story.animation.addByPrefix('nonselect', 'Train notselected', 24);
    story.animation.addByPrefix('select', 'Train selected', 24, false);
    story.animation.addByPrefix('confirm', 'Train confirm', 24, false);
    story.scale.set(1.25, 1.25);
    story.updateHitbox();
    options= new FlxSprite(650, 580);
    options.frames = Paths.getSparrowAtlas('menus/mainmenu/options');
    options.animation.addByPrefix('nonselect', 'options notselected', 24);
    options.animation.addByPrefix('select', 'options selected', 24, false);
    options.animation.addByPrefix('confirm', 'options confirm', 24, false);
    options.animation.addByPrefix('nonselect', 'options notselected', 24);
    freeplay= new FlxSprite(820, 25);
    freeplay.frames = Paths.getSparrowAtlas('menus/mainmenu/freeplay');
    freeplay.animation.addByPrefix('nonselect', 'Freeplay not selected', 24);
    freeplay.animation.addByPrefix('select', 'Freeplay selected', 24, false);
    freeplay.animation.addByPrefix('confirm', 'Freeplay confirm', 24, false);
    freeplay.angle = 6;
    subway_bg = new FunkinSprite().loadGraphic(Paths.image('menus/mainmenu/subway_bg'));
    backsubway = new FunkinSprite().loadGraphic(Paths.image('menus/mainmenu/subway_bg_2'));
    storyMouse = new FlxSprite(470,260).makeGraphic(150, 250, FlxColor.BLACK);
    optionsMouse = new FlxSprite(800,570).makeGraphic(100, 100, FlxColor.BLACK);
    freeplayMouse = new FlxSprite(1100,300).makeGraphic(100, 100, FlxColor.BLACK);
    //amazing layering
    add(backsubway);
    add(story);
    add(subway_bg);
    add(options);
    add(freeplay);
    add(storyMouse);
    add(optionsMouse);
    add(freeplayMouse);
}
function postCreate() {
    story.animation.play('come');
    options.animation.play('nonselect');
    freeplay.animation.play('nonselect');
}
function update(elapsed:Float) {
    if(FlxG.mouse.overlaps(storyMouse)){
        story.animation.play('select');
        story.y = 100;
        if(FlxG.mouse.justPressed){
            story.animation.play('confirm');
            CoolUtil.playMenuSFX(CoolSfx.CONFIRM, 1.25);
            new FlxTimer().start(0.5, function(timer)FlxG.game._requestedState = new ModState("menus/Sorry"));
        }
    }else{
        story.animation.play('nonselect');
        story.y = 140;
    }
    if(FlxG.mouse.overlaps(optionsMouse)){
        options.animation.play('select');
        options.y = 550;
        if(FlxG.mouse.justPressed){
            options.animation.play('confirm');
            CoolUtil.playMenuSFX(CoolSfx.CONFIRM, 1.25);
            new FlxTimer().start(0.5, function(timer)FlxG.game._requestedState = new ModState("menus/Sorry"));
        }
    }else{
        options.animation.play('nonselect');
        options.y = 580;
    }
    if(FlxG.mouse.overlaps(freeplayMouse)){
        freeplay.animation.play('select');
        freeplay.y = 25;
        freeplay.x = 820;
        if(FlxG.mouse.justPressed){
            freeplay.animation.play('confirm');
            CoolUtil.playMenuSFX(CoolSfx.CONFIRM, 1.25);
            new FlxTimer().start(0.5, function(timer)FlxG.game._requestedState = new ModState("menus/Sorry"));
        }
    }else{
        freeplay.animation.play('nonselect');
        freeplay.y = 220;
        freeplay.x = 1050;
    }
}