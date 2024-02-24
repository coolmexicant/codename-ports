var cammove = 90; // how much the camera will move
var angleMoveSpeed = 0.3; // the speed of the camera rotating
var angleVar = 2; // how much it will rotate
function postUpdate() {
    switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
        case "singLEFT": 
            camFollow.x -= cammove;
            camGame.angle = (lerp(camGame.angle, -angleVar, angleMoveSpeed));
        case "singDOWN": 
            camFollow.y += cammove;
            camGame.angle = (lerp(camGame.angle, 0, angleMoveSpeed));
        case "singUP": 
            camFollow.y -= cammove;
            camGame.angle = (lerp(camGame.angle, 0, angleMoveSpeed));
        case "singRIGHT": 
            camFollow.x += cammove;
            camGame.angle = (lerp(camGame.angle, angleVar, angleMoveSpeed));
        case "idle", "hey":
            camGame.angle = (lerp(camGame.angle, 0, angleMoveSpeed));
    }
}