# coding: utf-8
# require "patlite/version"

require 'sinatra'
require 'sinatra/reloader'
require 'haml'
require './patlite/led'
require './patlite/jsay'
require './patlite/input'
require 'thread'

$is_flash = false

  get '/' do
    haml :index
  end

  get '/flash' do
    t1 = Thread.new do
      $is_flash = true
      Patlite::Led.flash
    end
    t2 = Thread.new do
      Patlite::Input.wait_input
    end
    t1.join
    t2.join
    haml :index
  end

  get '/colorful' do
    Patlite::Led.colorful
    haml :index
  end

  get '/light' do
    Patlite::Led.light params[:color]
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
      $is_flash = true
      Patlite::Led.flash
    end
    t2 = Thread.new do
      3.times do
        Patlite::Jsay.say "危険です！"
      end
    end
    t1.join
    t2.join
    haml :index
  end

  # after do
  #   haml :index
  # end
