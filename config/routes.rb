Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # root 'paper_wallets#template'
  root 'paper_wallets#qr'
  
  resources :paper_wallets
end
