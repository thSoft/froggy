function translateTouchEventsToMouseEvents() {
  function touchHandler(event) {
    var touches = event.changedTouches;
    var first = touches[0];
    var type;
    switch (event.type) {
      case "touchstart":
        type = "mousedown";
        break;
      case "touchmove":
        type = "mousemove";
        break;    
      case "touchend":
        type = "mouseup";
        break;
      default:
        return;
    }
    var simulatedEvent = document.createEvent("MouseEvent");
    simulatedEvent.initMouseEvent(type, true, true, window, 1, first.screenX, first.screenY, first.clientX, first.clientY, false, false, false, false, 0, null);
    first.target.dispatchEvent(simulatedEvent);
  }

  document.addEventListener("touchstart", touchHandler, true);
  document.addEventListener("touchmove", touchHandler, true);
  document.addEventListener("touchend", touchHandler, true);
  document.addEventListener("touchcancel", touchHandler, true);
}

function initializeElm() {
  var module = Elm.Froggy.Main;
  return Elm.fullscreen(module, {
    loadedGame: null,
    fontName: fontName
  });
}

var fontName = "Boogaloo";

function loadFonts() {
  WebFont.load({
    google: {
      families: [fontName]
    }
  });
}

function loadImages(callback) {
  var loadedImagesCount = 0;
  images.forEach(function (imagePath) {
    image = new Image();
    image.src = imagePath;
    image.onload = function() {
      loadedImagesCount++;
      if (loadedImagesCount >= images.length) {
        callback();
      }
    }
  });
}

function loadGame(component) {
  var storageKey = 'froggy';
  var loadedJson = localStorage.getItem(storageKey);
  var loadedState = loadedJson ? JSON.parse(loadedJson) : null;
  try {
    component.ports.loadedGame.send(loadedState);
  } catch (e) {
    console.log("The game state can't be loaded because the internal model changed. Trying to start a new game." + e);
    component.ports.loadedGame.send(null);
  }
  component.ports.savedGame.subscribe(function(state) {
    localStorage.setItem(storageKey, JSON.stringify(state));
  });
}