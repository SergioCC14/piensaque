// Tutoriales sacados de
// // http://www.html5rocks.com/en/tutorials/getusermedia/intro/
// // http://chimera.labs.oreilly.com/books/1234000001552/ch01.html#s01_2
// // http://webaudiodemos.appspot.com/AudioRecorder/index.html (webkit)

// // Guardar el Audio -> http://webaudiodemos.appspot.com/AudioRecorder/index.html

// // Obj MediaStream: https://developer.mozilla.org/es/docs/WebRTC/MediaStream_API

// // File API (para blob) -> http://www.w3.org/TR/FileAPI/

// // Blob -> https://developer.mozilla.org/en-US/docs/Web/API/Blob

// // Para subir un fichero Blob por JS -> http://stackoverflow.com/questions/15795678/upload-audio-recorded-in-browser-using-html5


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
      alert('Error getting audio');
      console.log(e);
  });
}

// START
function start_record_audio() {
  audioRecorder.clear();
  audioRecorder.record();
}

// PAUSE
function pause_record_audio() {

}

// STOP
function stop_record_audio() {
  audioRecorder.stop();
  saveAudio();
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
    Recorder.setupDownload( blob, "myRecording" + ((recIndex<10)?"0":"") + recIndex + ".wav" );
    recIndex++;
}

window.addEventListener('load', init_record_audio );
