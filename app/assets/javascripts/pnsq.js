// Tutoriales sacados de
// http://www.html5rocks.com/en/tutorials/getusermedia/intro/
// http://chimera.labs.oreilly.com/books/1234000001552/ch01.html#s01_2
// http://mozilla.github.io/

// Comprueba si el navegador soporta GetUserMedia()
function hasGetUserMedia() {
  return !!(navigator.getUserMedia || navigator.webkitGetUserMedia ||
            navigator.mozGetUserMedia || navigator.msGetUserMedia);
  }

if (hasGetUserMedia()) {

} else {
    alert('getUserMedia() is not supported in your browser');
}

// Funcion general para guardar el audio
function record_audio() {
  if (!!navigator.mozGetUserMedia) {
    record_audio_moz();
  } else if (!!navigator.mozGetUserMedia) {
    record_audio_webkit();
  }
}

 var onFailSoHard = function(e) {
    console.log('Reeeejected!', e);
  }; 


// ------------------------- FIREFOX -------------------------
  // Funcion para guardar audio (MOZ)
  
  function record_audio_moz() {
    try {
      window.navigator.mozGetUserMedia({audio: true}, function(stream) {
        message.innerHTML = "<p>Success!</p>";
        content.appendChild(audio);
        audio.mozSrcObject = stream;
        audio.play();

      }, function(err) {
        message.innerHTML = "<p class='error'>" + err + "</p>";
        stopMedia();
      });
    } catch(e) {
      message.innerHTML = "<p class='error'>" + e + "</p>";
      stopMedia();
    }
  }

// ------------------------- WEBKIT -------------------------
  // Funcion para guardar audio (WEBKIT)
  var context = new window.webkitAudioContext();
  function record_audio_webkit() {
    navigator.webkitGetUserMedia({audio: true}, function(stream) {
      var microphone = context.createMediaStreamSource(stream);
      var filter = context.createBiquadFilter();

      // microphone -> filter -> destination.
      microphone.connect(filter);
      filter.connect(context.destination);
    }, onFailSoHard);
  }
