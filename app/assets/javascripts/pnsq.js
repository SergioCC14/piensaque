// Tutoriales sacados de
// // http://www.html5rocks.com/en/tutorials/getusermedia/intro/
// // http://chimera.labs.oreilly.com/books/1234000001552/ch01.html#s01_2
// // http://mozilla.github.io/ (mozilla)
// // http://webaudiodemos.appspot.com/AudioRecorder/index.html (webkit)
// // PARA WEBKIT: http://webaudiodemos.appspot.com/AudioRecorder/index.html

// // Guardar el Audio -> http://webaudiodemos.appspot.com/AudioRecorder/index.html

// // Obj MediaStream: https://developer.mozilla.org/es/docs/WebRTC/MediaStream_API

// Comprueba si el navegador soporta GetUserMedia()
function hasGetUserMedia() {
  return !!(navigator.getUserMedia || navigator.webkitGetUserMedia ||
            navigator.mozGetUserMedia || navigator.msGetUserMedia);
  }

// START
function start_record_audio() {

  window.AudioContext = window.AudioContext || window.webkitAudioContext;

  audioContext = new AudioContext();
  audioInput = null;
  //     realAudioInput = null,
  inputPoint = null
  audioRecorder = null;
  // var rafID = null;
  // var recIndex = 0;

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

// PAUSE
function pause_record_audio() {

}

// STOP
function stop_record_audio() {

}


// Sacadas de: http://webaudiodemos.appspot.com/AudioRecorder/index.html
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
