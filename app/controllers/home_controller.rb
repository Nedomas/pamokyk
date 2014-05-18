class HomeController < ApplicationController
  CITIES = {
    'Vilnius' => 'Vilniuje',
    'Kaunas' => 'Kaune',
    'Klaipėda' => 'Klaipėdoje',
    'Šiauliai' => 'Šiauliuose',
    'Panevėžys' => 'Panevėžyje',
    'Alytus' => 'Alytuje',
    'Marijampolė' => 'Marijampolėje',
    'Raseiniai' => 'Raseiniuose'
  }

  def index
    @cities = CITIES
    @posts = Post.all
  end

  def save
    Post.create({
      name: params[:resp]['name'],
      facebook_id: params[:resp]['id'],
      facebook_link: params[:resp]['link'],
      teach: params[:inputs]['teach'],
      learn: params[:inputs]['learn'],
      where: params[:inputs]['where']
    })

    render json: true
  end

  # def redirect
  #   session[:access_token] = Koala::Facebook::OAuth.new(oauth_redirect_url).get_access_token(params[:code]) if params[:code]
  #   @graph = Koala::Facebook::API.new(session[:access_token])
  #   @graph.put_connections("me", "feed", message: 'yo') rescue failure_path
  #   redirect_to session[:access_token] ? success_path : failure_path
  # end
end
