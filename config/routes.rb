Rails.application.routes.draw do
  root  to: 'static#index'
  get 'about' => 'static#about'
end