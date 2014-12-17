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

get '/' do
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

get '/colorful' do
  Patlite::Led.colorful
  haml :index
end

get '/light' do
  begin
    Patlite::Led.light params[:color]
  rescue => e

  end
  haml :index
end

get '/stop' do
  $is_flash = false
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
      Patlite::Led.rotate(1, 0.05)
    end
  end
  t2 = Thread.new do
    3.times do
      system 'aplay ./patlite/Siren_Noise.wav'
      if params[:voice] == "show"
        Patlite::Jsay.say_show params[:message]
      else
        Patlite::Jsay.say params[:message]
      end
    end
    t1.kill
  end
  t3 = Thread.new do
    Patlite::Input.wait_input([t1, t2])
  end
  t2.join
  t3.kill
  Patlite::Led.all_off
  haml :index

end

