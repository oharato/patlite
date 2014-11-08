# require "patlite/version"

require 'sinatra'
require 'sinatra/reloader'
require 'haml'
require './patlite/led'
require './patlite/jsay'

  get '/' do
    haml :index
  end

  get '/flash' do
    Patlite::Led.flash
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
    # Patlite::Led.flash
    Patlite::Jsay.say params[:message]
    # Patlite::Led.flash
    haml :index
  end

  # after do
  #   haml :index
  # end
