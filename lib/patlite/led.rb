require 'wiringpi2'
require 'colorable'
include Colorable

module Patlite
  class Led
    @led1 = [8,9,7]
    @led2 = [0,2,3]
    @led3 = [12,13,14]
    @led4 = [4,5,6]
    @leds = [@led1, @led2, @led3, @led4]

    def self.light(color)
      io = WiringPi::GPIO.new
      @leds.flatten.each{|gpio| io.soft_pwm_create(gpio, 0, 255)}
      3.times do
        @leds.each do |led|
          color_name_to_flash(io, led, color)
        end
        sleep 1
        @leds.each do |led|
          color_name_to_flash(io, led, 'black')
        end
        sleep 1
      end
      @leds.flatten.each{|gpio| io.soft_pwm_write(gpio, 0)}
    end


    def self.color_name_to_flash(io, led, color_name)
      c = color_name.to_color.rgb
      (0..2).each do |i|
        io.soft_pwm_write(led[i], c[i])
      end
    end

    def self.rotate(rotate_num = 20, duration = 0.025)
      io = WiringPi::GPIO.new
      @leds.each do |led|
        led.each{|gpio| io.soft_pwm_create(gpio, 0, 255)}
      end
      rotate_num.times do
        @leds.each do |led|
          color_name_to_flash(io, led, 'Red')
          sleep duration
          color_name_to_flash(io, led, 'Black')
        end
      end
    end

    def self.colorful
      io = WiringPi::GPIO.new
      @leds.each do |gpios|
        gpios.each{|gpio| io.soft_pwm_create(gpio, 0, 255)}
      end

      color_name_to_flash(io, @led1, 'Blue')
      sleep 1
      color_name_to_flash(io, @led1, 'Green')
      sleep 1
      color_name_to_flash(io, @led1, 'Yellow')
      sleep 1
      color_name_to_flash(io, @led1, 'Red')
      sleep 1
      color_name_to_flash(io, @led1, 'Brown')
      sleep 1
      color_name_to_flash(io, @led1, 'Purple')
      sleep 1
      color_name_to_flash(io, @led1, 'Orange')
      sleep 1

      @leds.each do |gpios|
        gpios.each{|gpio| io.soft_pwm_write(gpio, 0)}
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

    def self.all_on
      io = WiringPi::GPIO.new
      @leds.flatten.each do |gpio|
        io.pin_mode(gpio, WiringPi::OUTPUT)
        io.digital_write(gpio, 1)
      end
    end

    def self.all_off
      io = WiringPi::GPIO.new
      @leds.each do |led|
        led.each{|gpio| io.soft_pwm_create(gpio, 0, 255)}
        color_name_to_flash(io, led, 'Black')
      end
      @leds.flatten.each do |gpio|
        io.pin_mode(gpio, WiringPi::OUTPUT)
        io.digital_write(gpio, 0)
      end
    end

  end
end
