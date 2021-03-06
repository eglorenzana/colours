Rails.application.routes.draw do
  resources :white_bases
  resources :tints
  resources :pigments
  resources :mixtures
  resources :colors , controller: :physical_colors do
    
  end
  resources :utilities, only: [:index] do
    collection do
      post 'converters/:from_space/:to_space', action: 'convert_color' #, constraints: {from_space: /[a-z]/, to_space: /[a-z]/}
      post 'comparators/:comparator', action: 'compare_colors' 
    end
  end  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
