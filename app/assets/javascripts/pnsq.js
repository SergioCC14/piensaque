// Tutoriales sacados de
// // http://www.html5rocks.com/en/tutorials/getusermedia/intro/
// // http://chimera.labs.oreilly.com/books/1234000001552/ch01.html#s01_2
// // http://webaudiodemos.appspot.com/AudioRecorder/index.html (webkit)

// // Guardar el Audio -> http://webaudiodemos.appspot.com/AudioRecorder/index.html

// // Obj MediaStream: https://developer.mozilla.org/es/docs/WebRTC/MediaStream_API

// // File API (para blob) -> http://www.w3.org/TR/FileAPI/

// // Blob -> https://developer.mozilla.org/en-US/docs/Web/API/Blob

// // Para subir un fichero Blob por JS -> http://stackoverflow.com/questions/15795678/upload-audio-recorded-in-browser-using-html5


var pnsq_audio;

// Comprueba si el navegador soporta GetUserMedia()
function hasGetUserMedia() {
  return !!(navigator.getUserMedia || navigator.webkitGetUserMedia ||
            navigator.mozGetUserMedia || navigator.msGetUserMedia);
  }

function init_record_audio() {
  window.AudioContext = window.AudioContext || window.webkitAudioContext;

  audioContext = new AudioContext();
  audioInput = null;
  inputPoint = null
  audioRecorder = null;
  recIndex = 0;
  realAudioInput = null;

  if (!navigator.getUserMedia)
      navigator.getUserMedia = navigator.webkitGetUserMedia || navigator.mozGetUserMedia;

  if (!navigator.cancelAnimationFrame)
      navigator.cancelAnimationFrame = navigator.webkitCancelAnimationFrame || navigator.mozCancelAnimationFrame;

  if (!navigator.requestAnimationFrame)
      navigator.requestAnimationFrame = navigator.webkitRequestAnimationFrame || navigator.mozRequestAnimationFrame;


  navigator.getUserMedia({audio:true}, gotStream, function(e) {
      alert('Por favor, habilite la toma de audio de su navegador.');
      console.log(e);
  });
}

// START
function start_record_audio() {
  audioRecorder.clear();
  audioRecorder.record();
}

// STOP: Se le pasa el ID del formulario que va a ser mandado
function stop_record_audio(form_id, user_id) {
  audioRecorder.stop();
  saveAudio();
  
  setTimeout(
      function() {
        uploadForm(form_id, user_id)
      }, 50);
}

// Pnsq Audio Blob (GET y SET)
function setPnsq_audio(blob) {
  pnsq_audio = blob;
}

function getPnsq_audio() {
  return pnsq_audio;
}

// Sacadas de: http://webaudiodemos.appspot.com/AudioRecorder/index.html
// Thanks you: Chris & Matt
function gotStream(stream) {
  inputPoint = audioContext.createGain();

  // Create an AudioNode from the stream.
  realAudioInput = audioContext.createMediaStreamSource(stream);
  audioInput = realAudioInput;
  audioInput.connect(inputPoint);

  audioRecorder = new Recorder( inputPoint );

  zeroGain = audioContext.createGain();
  zeroGain.gain.value = 0.0;
  inputPoint.connect( zeroGain );
  zeroGain.connect( audioContext.destination );
}

function saveAudio() {
    audioRecorder.exportWAV( doneEncoding );
}

function doneEncoding( blob ) {
    Recorder.setupDownload( blob, "psnq" + ((recIndex<10)?"0":"") + recIndex + ".wav" );
    recIndex++;
}

// Para la subida del fichero
function uploadForm(form_id, user_id) {
  var form = new FormData(document.getElementById(form_id));
  form.append("pnsq[audio]", getPnsq_audio(), "pnsq_" + user_id + "_" + Date.now() + ".wav");

  var request = new XMLHttpRequest();
  var async = true;
  request.open("POST", "/pnsqs.js", async);
  request.responseType = 'text/javascript'

  if (async) {
      request.onreadystatechange = function() {
          if (request.readyState == 4 && request.status == 200) {
              var response = null;
              try {
                  setTimeout(request.responseText, 5);
              } catch (e) {
                  console.log(e);
              }
          }
      }
  }
  request.send(form);
}

// Comprobamos si el usuario ha acceptado los permisos
function check_if_can_record() {
  if (typeof(audioRecorder) !== 'undefined' && audioRecorder == null) {
    return false
  } else {
    return true
  }
}

