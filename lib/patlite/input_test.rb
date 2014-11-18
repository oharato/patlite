require 'wiringpi2'

# def p_hoge
#   p 'hoge'
# end

input_gpio = 2

io = WiringPi::GPIO.new
# http://www.rubydoc.info/gems/wiringpi2/2.0.1/WiringPi/GPIO#pull_up_dn_control-instance_method
io.pin_mode(input_gpio, WiringPi::INPUT)
io.pull_up_dn_control(input_gpio, WiringPi::PUD_UP)

# f = Proc.new {p "hoge"}
while true
  p 'hoge' if io.digital_read(input_gpio) == WiringPi::LOW
  sleep 0.1
  # io.wiringpi_isr(input_gpio, 1, f)
  # sleep 100
end

