require 'text2voice'

voice = TextToVoice.new("dzywbs4umvr3uw60")

voice.speak("test test")
     .speaker("haruka")
     #.emotion(emotion: :happiness, level: :high)

voice.save_as("test.wav")