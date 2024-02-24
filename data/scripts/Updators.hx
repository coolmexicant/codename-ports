function create(){importScript("data/scripts/Extra Functions");}
public function updateHealthIconScale(icon:HealthIcon, lerp:Float, playBack:Float = 1){
    icon.setGraphicSize(Std.int(FlxMath.lerp(icon.width, icon.width, lerp * playBack)));
    icon.updateHitbox();
    icon.setGraphicSize(Std.int(CoolUtil.boundTo(iconP1.width, 0, iconP1.startWidth + 30)));
    icon.updateHitbox();
}
public function iconBump(icon:HealthIcon, playBack:Float = 1){
    iconP1.setGraphicSize(Std.int(iconP1.width + (30 / (songMultiplier < 1 ? 1 : songMultiplier))));
    iconP2.setGraphicSize(Std.int(iconP2.width + (30 / (songMultiplier < 1 ? 1 : songMultiplier))));

    iconP1.updateHitbox();
    iconP2.updateHitbox();

    iconP1.setGraphicSize(Std.int(CoolUtil.boundTo(iconP1.width, 0, iconP1.startWidth + 30)));
    iconP2.setGraphicSize(Std.int(CoolUtil.boundTo(iconP2.width, 0, iconP2.startWidth + 30)));

    iconP1.updateHitbox();
    iconP2.updateHitbox();

}