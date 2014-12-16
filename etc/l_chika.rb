require 'wiringpi2'

gpio = 10
io = WiringPi::GPIO.new
io.mode(gpio, OUTPUT)

10.times do
  io.write(gpio, 1)
  sleep 0.5
  io.write(gpio, 0)
  sleep 0.5
end