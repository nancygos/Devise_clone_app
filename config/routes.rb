Rails.application.routes.draw do
  root 'account#login'

  get 'account/signup'
  post'account/signup'

  get 'account/login'
  post 'account/login'

  get 'account/forget_password'
  post 'account/forget_password'

  get 'account/reset_password'
  post 'account/reset_password'

  get 'account/edit_profile'
  post 'account/edit_profile'

  get 'account/dashboard'
  get 'account/logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
