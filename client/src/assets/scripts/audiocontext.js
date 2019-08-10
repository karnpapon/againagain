import Tone from "tone";

const Audio = {
  __hasInput: false,
  ctx: null,

  start(audioSource) {
    if( Audio.__hasInput === false ) {
      Audio.ctx = new AudioContext()
      Audio.createInput().then( input => {
        Audio.createFFT(audioSource)
        // console.log("window.audioPlayer.buffer", window.audioPlayer.buffer._buffer)
        // Tone.AudioNode.connect( Audio.FFT )
        Audio.interval = setInterval( Audio.fftCallback(audioSource), 1000/60 )
        //window.FFT = Audio.FFT
      })
    }
    Audio.__hasInput = true
  },

  createInput() {
    const p = new Promise( resolve => {
      console.log( 'start?' )
      navigator.mediaDevices.getUserMedia({ audio:true, video:false })
        .then( stream => {
          console.log( 'audio input connected' )
          Audio.input = Audio.ctx.createBufferSource()
          // Audio.input.buffer = window.audioPlayer.buffer._buffer
          Audio.__hasInput = true
          resolve( Audio.input )
        })
        .catch( err => { 
          console.log( 'error opening audio input:', err )
        })
    })
    return p
  },

  createFFT(source) {
    Audio.FFT = Audio.ctx.createAnalyser()

    let __windowSize = 512
    Object.defineProperty( Audio, 'windowSize', {
      get() { return __windowSize },
      set(v){
        __windowSize = v
        Audio.FFT.fftSize = v 
        Audio.FFT.values = new Uint8Array( source._buffer )
        console.log("afjd", source)
      }
    })

    Audio.windowSize = 512
  },

  fftCallback(audioAnalyzer) {
    
    Audio.FFT.getByteFrequencyData( Audio.FFT.values )
    
    let lowSum, midSum, highSum, lowCount, midCount, highCount
    lowSum = midSum = highSum = lowCount = midCount = highCount = 0

    let frequencyCounter = 0
  

    // does this start at 0Hz? ack... can't remember... does it include DC offset?
    const hzPerBin = (Audio.ctx.sampleRate / 2) / audioAnalyzer.size
    const lowRange = 150, midRange = 1400, highRange = Audio.ctx.sampleRate / 2
 
    for( let i = 1; i < audioAnalyzer.size; i++ ) {
      if( frequencyCounter < lowRange ) {
        lowSum += audioAnalyzer._buffer[ i ]
        lowCount++
      }else if( frequencyCounter < midRange ) {
        midSum += audioAnalyzer._buffer[ i ]
        midCount++
      }else{
        highSum += audioAnalyzer._buffer[ i ]
        highCount++
      }

      frequencyCounter += hzPerBin
    }

    Audio.low = (lowSum / lowCount) / 255
    Audio.mid = (midSum / midCount) / 255 || 0
    Audio.high = (highSum / highCount) / 255
  }
}

export default Audio;