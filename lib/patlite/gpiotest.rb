require 'wiringpi'

gpios = [7,0,4,3]
io = WiringPi::GPIO.new

gpios.each{|gpio| io.mode(gpio, OUTPUT)}

10.times do
  gpios.each do |gpio|
    io.write(gpio, 1)
    sleep 0.05
    io.write(gpio, 0)
    sleep 0.05
  end
end