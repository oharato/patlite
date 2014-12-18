require "io/console"

thread1 = Thread.new do
  begin
    loop do
      p "thread1"
      sleep 0.5
    end
  ensure
    p "thread1 killed"
  end
end

thread2 = Thread.new do
  begin
    5.times do
      p "thread2"
      sleep 1
    end
  ensure
    thread1.kill
  end
end

input_thread = Thread.new do
  begin
    while STDIN.getch != "q"; end
      puts
      thread2.kill
  ensure
    p "input_thread killed"
  end
end

p input_thread.status

thread2.join
p input_thread.status
input_thread.kill
# thread1.kill
p "end"
wait_thread = Thread.new do
  thread2.join
  input_thread.join
end
wait_thread.join
p Thread.list

while
  p "hoge"
  sleep 1
end
