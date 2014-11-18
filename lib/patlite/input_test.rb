require 'wiringpi2'

input_gpio = 2

io = WiringPi::GPIO.new
# http://www.rubydoc.info/gems/wiringpi2/2.0.1/WiringPi/GPIO#pull_up_dn_control-instance_method
io.pin_mode(input_gpio, WiringPi::INPUT)
io.pull_up_dn_control(input_gpio, WiringPi::PUD_UP)

while true
  p 'hoge' if io.digital_read(input_gpio) == WiringPi::LOW
  sleep 0.1
end
