# require "patlite/version"

require 'sinatra'
require 'haml'
require './patlite/led'
require './patlite/jsay'

  get '/' do
    # haml :index
  end

  get '/flash' do
    Patlite::Led.flash
  end

  get '/say' do
    if params[:voice] == "show"
      Patlite::Jsay.say_show params[:message]
    else
      Patlite::Jsay.say params[:message]
    end
  end

  get '/alert' do
    Patlite::Led.flash
    Patlite::Jsay.say params[:message]
    Patlite::Led.flash
  end

  after do
    haml :index
  end
