# coding: utf-8
require 'shellwords'
module Patlite
  class Jsay

    def self.say(message, speaker)
      if speaker.nil?
        command = "./patlite/jsay.sh #{message}"
        `#{command}`
      else
        command = <<"EOS"
curl "https://api.voicetext.jp/v1/tts" \
 -u "dzywbs4umvr3uw60:" \
 -d "text=#{message}" \
 -d "speaker=#{speaker}" | aplay -
EOS
        `#{command}`
      end
    end

  end
end