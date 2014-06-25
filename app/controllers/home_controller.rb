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
    @posts = Post.all.order('created_at DESC')
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

  def privacy
    render layout: false
  end
end
