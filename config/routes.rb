Rails.application.routes.draw do
  devise_for :users
  # home pages
  root 'home#dashboard_page'

  # General pages
  get 'general/landing_page', to: 'general#landing_page', as: 'general_landing_page'
end
