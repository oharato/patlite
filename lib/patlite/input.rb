require 'wiringpi2'

module Patlite
  class Input
    input_gpio = 2

    def self.wait_input
      io = WiringPi::GPIO.new
# http://www.rubydoc.info/gems/wiringpi2/2.0.1/WiringPi/GPIO#pull_up_dn_control-instance_method
      io.pin_mode(input_gpio, WiringPi::INPUT)}
      io.pull_up_dn_control(input_gpio, WiringPi::PUD_DOWN)

      while io.read(4) == WiringPi::LOW
      end

      $is_flash = false

    end

  end
end
