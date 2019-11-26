const Audio = {
  __hasInput: false,
  ctx: null,

  start(c) {
    if (Audio.__hasInput === false) {
      Audio.ctx = new AudioContext()
      Audio.createInput().then(input => {
        Audio.createFFT()
        // input.connect(Audio.FFT)

        Audio.interval = setInterval(Audio.fftCallback(c), 1000 / 60)
        //window.FFT = Audio.FFT
      })
    }
    Audio.__hasInput = true
  },

  createInput() {
    console.log('connecting audio input...')

    const p = new Promise(resolve => {
      console.log('start?')
      navigator.mediaDevices.getUserMedia({ audio: true, video: false })
        .then(stream => {
          console.log('audio input connected')
          Audio.input = Audio.ctx.createMediaStreamSource(stream)
          //Audio.mediaStreamSource.connect( Gibberish.node )
          Audio.__hasInput = true
          resolve(Audio.input)
        })
        .catch(err => {
          console.log('error opening audio input:', err)
        })
    })
    return p
  },

  createFFT() {
    Audio.FFT = Audio.ctx.createAnalyser()

    let __windowSize = 512
    Object.defineProperty(Audio, 'windowSize', {
      get() { return __windowSize },
      set(v) {
        __windowSize = v
        Audio.FFT.fftSize = v
        Audio.FFT.values = new Uint8Array(Audio.FFT.frequencyBinCount)
      }
    })

    Audio.windowSize = 512
  },

  fftCallback(c) {
    // Audio.FFT.getByteFrequencyData(new Uint8Array(c))
    console.log("c", c)

    let lowSum, midSum, highSum, lowCount, midCount, highCount
    lowSum = midSum = highSum = lowCount = midCount = highCount = 0

    let frequencyCounter = 0

    // does this start at 0Hz? ack... can't remember... does it include DC offset?
    const hzPerBin = (Audio.ctx.sampleRate / 2) / Audio.FFT.frequencyBinCount
    const lowRange = 150, midRange = 1400, highRange = Audio.ctx.sampleRate / 2

    for (let i = 1; i < c._analyser._buffer; i++) {
      if (frequencyCounter < lowRange) {
        lowSum += c._analyser[i]
        lowCount++
      } else if (frequencyCounter < midRange) {
        midSum += c._analyser[i]
        midCount++
      } else {
        highSum += c._analyser[i]
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