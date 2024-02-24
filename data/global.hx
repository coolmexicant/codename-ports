// //https://github.com/TIPSnASK/fnf-free-download/blob/main/data/global.hx

// import funkin.backend.MusicBeatState;
// import funkin.menus.MainMenuState;

// static var redirectStates:Map<FlxState, String> = [MainMenuState => 'menus/MainMenu'];
// static var fdInitialized:Bool = false;

// function preStateSwitch() {
//     if (!fdInitialized) {
// 		fdInitialized = true;
// 		MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
// 	}

//     for (stupid => smart in redirectStates)
// 		if (FlxG.game._requestedState is stupid) {
// 			FlxG.game._requestedState = new ModState(smart);
// 		break;
// 	    }
// }

function update(elapsed:Float)
    if (FlxG.keys.justPressed.F5) FlxG.resetState();

// function postStateSwitch() {
// 	for (cam in FlxG.cameras.list)
// 		cam.antialiasing = false;
// }

// function destroy() {
// 	fdInitialized = false;
// }