Rails.application.routes.draw do
  devise_for :users
  # Pages
  # home pages
  root 'home#dashboard_page'
  get 'home/question_paper_page', to: 'home#question_paper_page', as: 'home_question_paper_page'
  get 'home/question_paper_edit_page/:questionpaper_id', to: 'home#question_paper_edit_page', as: 'home_question_paper_edit_page'

  # General pages
  get 'general/landing_page', to: 'general#landing_page', as: 'general_landing_page'

  # Functions
  # home functions
  # questionpaper
  post 'home/create_question_paper', to: 'home#create_question_paper', as: 'home_create_question_paper'
  delete 'home/delete_question_paper/:questionpaper_id', to: 'home#delete_question_paper', as: 'home_delete_question_paper'
  get 'home/edit_name_question_paper/:questionpaper_id', to: 'home#edit_name_question_paper', as: 'home_edit_name_question_paper'
  put 'home/edit_name_question_paper_submit/:questionpaper_id', to: 'home#edit_name_question_paper_submit', as: 'home_edit_name_question_paper_submit'

  # question
  post 'home/create_question/:questionpaper_id', to: 'home#create_question', as: 'home_create_question'
end
