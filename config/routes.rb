Rails.application.routes.draw do
  devise_for :users
  root 'general#landing_page'
end
