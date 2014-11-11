# require "patlite/version"

require 'sinatra'
require 'sinatra/reloader'
require 'haml'
require './patlite/led'
require './patlite/jsay'
require 'thread'

$is_flash = false

  get '/' do
    haml :index
  end

  get '/flash' do
    $is_flash = true
    Patlite::Led.flash
    haml :index
  end

  get '/stop' do
    $is_flash = false
    haml :index
  end

  get '/color' do
    Patlite::Led.color
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
      Patlite::Led.flash
    end
    t2 = Thread.new do

    end
    t1.join
    t2.join
    haml :index
  end

  # after do
  #   haml :index
  # end
