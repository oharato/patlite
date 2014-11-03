require 'wiringpi2'

module Patlite
  class Led
    def self.flash
      gpios = [7,0,4,3]
      io = WiringPi::GPIO.new

      gpios.each{|gpio| io.pin_mode(gpio, WiringPi::OUTPUT)}
      # gpios.each{|gpio| io.soft_pwm_create(gpio, 0, 100)}

      3.times do
        gpios.each do |gpio|
         io.digital_write(gpio, 1)
         sleep 0.05
         io.digital_write(gpio, 0)
         sleep 0.05
          # (0..100).each do |x|
          #   io.soft_pwm_write(gpio, x)
          #   sleep(0.005)
          # end
          # (0..100).each do |x|
          #   io.soft_pwm_write(gpio,(100 -x))
          #   sleep(0.005)
          # end

        end
      end
    end
  end
end