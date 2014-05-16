class HomeController < ApplicationController
  CITIES = {
    'Vilnius' => 'Vilniuje',
    'Kaunas' => 'Kaune',
    'Klaipėda' => 'Klaipėdoje',
    'Šiauliai' => 'Šiauliuose',
    'Panevėžys' => 'Panevėžyje',
    'Raseiniai' => 'Raseiniuose'
  }

  def index
    @cities = CITIES
  end

  def redirect
    session[:access_token] = Koala::Facebook::OAuth.new(oauth_redirect_url).get_access_token(params[:code]) if params[:code]
    binding.pry
    @graph = Koala::Facebook::API.new(session[:access_token])
    @graph.put_connections("me", "feed", message: 'yo') rescue failure_path
    redirect_to session[:access_token] ? success_path : failure_path
  end
end
