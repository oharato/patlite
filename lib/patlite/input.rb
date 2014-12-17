require 'wiringpi2'

module Patlite
  class Input
    @input_gpio = 11

    def self.wait_input(array_thread)
      io = WiringPi::GPIO.new
# http://www.rubydoc.info/gems/wiringpi2/2.0.1/WiringPi/GPIO#pull_up_dn_control-instance_method
      io.pin_mode(@input_gpio, WiringPi::INPUT)
      io.pull_up_dn_control(@input_gpio, WiringPi::PUD_UP)

      while true
        if io.digital_read(@input_gpio) == WiringPi::LOW
          array_thread.each(&:kill)
          break
        end
        sleep 0.2
        if array_thread.all?(&:stop?)
          break
        end
      end

    end

  end
end
