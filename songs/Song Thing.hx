//CUSTOMIZE
var isPlayerIcon:Bool = false;
var songTextFont:String = "vcr.ttf";
var songTextSize:Int = 18;
var songTextColor:String = "#FFFFFF";
var songTextBorderColor:String = "#000000";
var songTextBorderQuality:Int = 2;
var songTextBorderSize:Int = 2;
//ACTUAL CODE
var icon:HealthIcon;
var coolSongText:FlxText;
function create(){
    if(!isPlayerIcon)
        icon = new HealthIcon(dad != null ? dad.getIcon() : "face", false);
    else
        icon = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", false);
    coolSongText = new FlxText(0,0,FlxG.width,"DIE DIE DIE DIE",songTextSize);
    coolSongText.setFormat(Paths.font(songTextFont),songTextSize,FlxColor.fromString(songTextColor),"left","outline",FlxColor.fromString(songTextBorderColor));
    coolSongText.borderQuality = songTextBorderQuality;
    coolSongText.borderSize = songTextBorderSize;
    add(coolSongText);
    add(icon);
    icon.camera = camHUD;
    coolSongText.camera = camHUD;
}