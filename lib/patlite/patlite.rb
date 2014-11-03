require 'sinatra'
require './patlite/led'
require './patlite/jsay'

  get '/' do
    'hoge'
  end

  get '/flash' do
    Patlite::Led.flash
  end

  get '/say' do
    p params
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
