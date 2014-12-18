# coding: utf-8
# require "patlite/version"

require 'sinatra'
require 'sinatra/reloader'
require 'haml'
require './patlite/led'
require './patlite/jsay'
require './patlite/input'
require 'thread'

set :environment, :production
set :port, 80

before do
  @colors = []
  c = Color.new :alice_blue
  100.times do
    @colors << c.name
    c = c.next
  end
end

get '/' do
  haml :index
end

get '/say' do
  if params[:voice] == "show"
    Patlite::Jsay.say_show params[:message]
  else
    Patlite::Jsay.say params[:message]
  end
  haml :index
end

get '/alert' do
  t1 = Thread.new do
    while
      Patlite::Led.rotate(4, 0.05)
    end
  end

  t2 = Thread.new do
    begin
        command = <<-"EOS"
          for i in \`seq 3\`
          do
          aplay ./patlite/Siren_Noise.wav
          done
        EOS

        `#{command}`

        if params[:voice] == "show"
          Patlite::Jsay.say_show params[:message]
        else
          Patlite::Jsay.say params[:message]
        end
    ensure
      t1.kill
    end
  end

  t3 = Thread.new do
    Patlite::Input.wait_input([t2])
  end

  t2.join
  t3.kill
  Patlite::Led.all_off
  haml :index

end

get '/light' do
  begin
    Patlite::Led.light params[:color]
  rescue => e

  end
  haml :index
end

get '/flash' do
  t1 = Thread.new do
    Patlite::Led.rotate
  end
  t2 = Thread.new do
    Patlite::Input.wait_input([t1])
  end
  t1.join
  t2.kill
  Patlite::Led.all_off
  haml :index
end

get '/check' do
  Patlite::Led.check
  haml :index
end

get '/all_on' do
  Patlite::Led.all_on
  haml :index
end

get '/all_off' do
  Patlite::Led.all_off
  haml :index
end

