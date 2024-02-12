import flixel.text.FlxText.FlxTextAlign;

var sorry:FlxText;
function create() {
    sorry = new FlxText(0,0,FlxG.width,"Sorry this menu is in the works, going back to the main menu in 3 seconds.", 20);
    sorry.setFormat(Paths.font("pixel.otf"), 20, FlxColor.WHITE, FlxTextAlign.CENTER);
    sorry.screenCenter(FlxAxes.XY);
    add(sorry);
    new FlxTimer().start(3, function(timer)FlxG.game._requestedState = new ModState("menus/MainMenu"));
}