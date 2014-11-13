var fontName = "Bubblegum Sans";

function loadFonts() {
  WebFont.load({
    google: {
      families: [fontName]
    }
  });
}

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
  var storageKey = 'froggy';

  var storedState = localStorage.getItem(storageKey);
  var startingState = storedState ? JSON.parse(storedState) : null;
  var component = Elm.fullscreen(module, {
    load: startingState,
    fontName: fontName
  });
  component.ports.save.subscribe(function(state) {
    localStorage.setItem(storageKey, JSON.stringify(state));
  });
}
