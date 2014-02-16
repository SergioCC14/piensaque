// Tutoriales sacados de
// // http://www.html5rocks.com/en/tutorials/getusermedia/intro/
// // http://chimera.labs.oreilly.com/books/1234000001552/ch01.html#s01_2
// // http://mozilla.github.io/ (mozilla)
// // http://webaudiodemos.appspot.com/AudioRecorder/index.html (webkit)
// // PARA WEBKIT: http://webaudiodemos.appspot.com/AudioRecorder/index.html

// // Obj MediaStream: https://developer.mozilla.org/es/docs/WebRTC/MediaStream_API

// Comprueba si el navegador soporta GetUserMedia()
function hasGetUserMedia() {
  return !!(navigator.getUserMedia || navigator.webkitGetUserMedia ||
            navigator.mozGetUserMedia || navigator.msGetUserMedia);
  }

// ------------------------- Generales -------------------------
// START
function start_record_audio() {
  if (!!navigator.mozGetUserMedia) {
    start_record_audio_moz();
  } else if (!!navigator.webkitGetUserMedia) {
    start_record_audio_webkit();
  }
}

// PAUSE
function pause_record_audio() {
  if (!!navigator.mozGetUserMedia) {
    pause_record_audio_moz();
  } else if (!!navigator.mozGetUserMedia) {
    pause_record_audio_webkit();
  }
}

// STOP
function stop_record_audio() {
  if (!!navigator.mozGetUserMedia) {
    stop_record_audio_moz();
  } else if (!!navigator.mozGetUserMedia) {
    stop_record_audio_webkit();
  }
}

// ----------------- FIREFOX ------------------

  var pnsq = document.createElement("audio");
  


  // Funcion para guardar audio (MOZ - START)
  function start_record_audio_moz() {

    context = new window.AudioContext();

    navigator.mozGetUserMedia({audio: true}, function(stream) {
      var microphone = context.createMediaStreamSource(stream);
      var filter = context.createBiquadFilter();

      // microphone -> filter -> destination.
      microphone.connect(filter);
      filter.connect(context.destination);

    }, onFailSoHard);
  }

// MOZ - PAUSE
function pause_record_audio_moz() {
   if (saved_stream) {
    pnsq.play();
  } else {
    pnsq.pause();
    
    
  }
}

// MOZ - STOP
function stop_record_audio_moz() {
  audio_status = false;
  
  saved_stream = null;

}

// ------------------------- WEBKIT -------------------------
  
  // En caso de fallo
  var onFailSoHard = function(e) {
    console.log('Reeeejected!', e);
  };

  var context_webkit = new window.webkitAudioContext();

// Funcion para guardar audio (WEBKIT - START) sin terminar
function start_record_audio_webkit() {
  navigator.webkitGetUserMedia({audio: true}, function(stream) {
    var microphone = context_webkit.createMediaStreamSource(stream);
    var filter = context_webkit.createBiquadFilter();

    // microphone -> filter -> destination.
    microphone.connect(filter);
    filter.connect(context_webkit.destination);

  }, onFailSoHard);
}

  
// Funcion para guardar audio (WEBKIT - STOP) no hecho
function stop_record_audio_webkit() {
  context_webkit.stop();

}
