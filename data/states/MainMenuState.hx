import funkin.menus.MainMenuState;
import funkin.backend.assets.Paths;
// function create() {
// }
function postCreate() {
    for(i in [magenta, menuItems])
        remove(i);
    bg.loadGraphic(Paths.image('menus/mainmenu/subway_bg'));
}