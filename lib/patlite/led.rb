require 'wiringpi2'
require 'colorable'

module Patlite
  class Led
    @gpios = [7,0,1]
    led1 = [8,9,7]
    led2 = [0,2,3]
    led3 = [12,13,14]
    led4 = [15,16,1]
    @leds = [led1, led2, led3, led4]

    def self.flash
      io = WiringPi::GPIO.new

      @gpios.each{|gpio| io.pin_mode(gpio, WiringPi::OUTPUT)}

      10.times do
        break unless $is_flash
        @gpios.each do |gpio|
         io.digital_write(gpio, 1)
         sleep 0.5
         io.digital_write(gpio, 0)
         sleep 0.5
        end
      end
    end

    def self.colorful
      io = WiringPi::GPIO.new
      @leds.each do |gpios|
        gpios.each{|gpio| io.soft_pwm_create(gpio, 0, 255)}
      end

      color_name_to_flash(io, 'Blue')
      sleep 1
      color_name_to_flash(io, 'Green')
      sleep 1
      color_name_to_flash(io, 'Yellow')
      sleep 1
      color_name_to_flash(io, 'Red')
      sleep 1
      color_name_to_flash(io, 'Brown')
      sleep 1
      color_name_to_flash(io, 'Purple')
      sleep 1
      color_name_to_flash(io, 'Orange')
      sleep 1

      @leds.each do |gpios|
        gpios.each{|gpio| io.soft_pwm_write(gpio, 0)}
      end
    end

    def self.light(color)
      io = WiringPi::GPIO.new
      @gpios.each{|gpio| io.soft_pwm_create(gpio, 0, 255)}
      color_name_to_flash(io, color)
      sleep 3
      @gpios.each{|gpio| io.soft_pwm_write(gpio, 0)}
    end


    def self.color_name_to_flash(io, color_name)
      c = color_name.to_color.rgb
      @leds.each do |gpios|
        (0..2).each do |i|
          io.soft_pwm_write(gpios[i], c[i])
        end
      end
    end

    def self.check
      io = WiringPi::GPIO.new
      gpios = @leds.flatten
      gpios.each do |gpio|
        io.pin_mode(gpio, WiringPi::OUTPUT)
        io.digital_write(gpio, 1)
      end
      sleep 3
      gpios.each do |gpio|
        io.digital_write(gpio, 0)
      end
      gpios.each do |gpio|
        io.digital_write(gpio, 1)
        sleep 1
        io.digital_write(gpio, 0)
      end
    end

  end
end
