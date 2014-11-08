require 'wiringpi2'
require "colorable"

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

    @gpios = [7,0,4,3]
    def self.color
      io = WiringPi::GPIO.new

      @gpios.each{|gpio| io.soft_pwm_create(gpio, 0, 255)}

      color_name_to_flash(io, 'Blue')
      color_name_to_flash(io, 'Green')
      color_name_to_flash(io, 'Yellow')
      color_name_to_flash(io, 'Red')
      color_name_to_flash(io, 'Brown')
      color_name_to_flash(io, 'Purple')
      color_name_to_flash(io, 'Orange')
      @gpios.each{|gpio| io.soft_pwm_write(gpio, 0)}
    end

    def self.color_name_to_flash(io, color_name)
      c = color_name.to_color.rgb
      (0..2).each do |i|
        io.soft_pwm_write(@gpios[i], c[i])
      end
      sleep 1

    end
  end
end
