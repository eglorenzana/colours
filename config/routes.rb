Rails.application.routes.draw do
  resources :white_bases
  resources :tints
  resources :pigments
  resources :mixtures
  resources :colors , controller: :physical_colors do

  end

  post '/compare', controller: :utilities, action: :compare_colors
  post '/convert', controller: :utilities, action: :convert_color

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
