require 'wiringpi2'

gpio = 10
io = WiringPi::GPIO.new
io.pin_mode(gpio, WiringPi::OUTPUT)

10.times do
  io.digital_write(gpio, 1)
  sleep 0.5
  io.digital_write(gpio, 0)
  sleep 0.5
end