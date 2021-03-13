Rails.application.routes.draw do
  devise_for :users
  # home pages
  root 'home#dashboard_page'
  get 'home/question_paper_page', to: 'home#question_paper_page', as: 'home_question_paper_page'

  # home functions
  post 'home/create_question_paper', to: 'home#create_question_paper', as: 'home_create_question_paper'

  # General pages
  get 'general/landing_page', to: 'general#landing_page', as: 'general_landing_page'
end
