# coding: utf-8
require 'shellwords'
module Patlite
  class Jsay

    def self.say(message)
      command = "/home/pi/jsay.sh #{message.shellescape}"
      `#{command}`
    end

    def self.say_show(message)
      command = <<"EOS"
curl "https://api.voicetext.jp/v1/tts" \
 -u "dzywbs4umvr3uw60:" \
 -d "text=#{message}" \
 -d "speaker=show" | aplay -
EOS
      `#{command}`
    end
  end
end