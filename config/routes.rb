Rails.application.routes.draw do
  devise_for :users
  # Pages
  # home pages
  root 'home#dashboard_page'
  get 'home/question_paper_page', to: 'home#question_paper_page', as: 'home_question_paper_page'
  get 'home/question_paper_edit_page/:questionpaper_id', to: 'home#question_paper_edit_page', as: 'home_question_paper_edit_page'
  get 'settings/profile_page', to: 'settings#profile_page', as:'settings_profile_page'

  # General pages
  get 'general/landing_page', to: 'general#landing_page', as: 'general_landing_page'

  # Functions
  # home functions
  # questionpaper
  post 'home/create_question_paper', to: 'home#create_question_paper', as: 'home_create_question_paper'
  delete 'home/delete_question_paper/:questionpaper_id', to: 'home#delete_question_paper', as: 'home_delete_question_paper'
  get 'home/edit_name_question_paper/:questionpaper_id', to: 'home#edit_name_question_paper', as: 'home_edit_name_question_paper'
  put 'home/edit_name_question_paper_submit/:questionpaper_id', to: 'home#edit_name_question_paper_submit', as: 'home_edit_name_question_paper_submit'
  get 'home/home_page/right_pane/:right_pane_view', to: 'home#home_page_right_pane_view', as: 'home_page_right_pane_view'

  # question
  post 'home/create_question/:questionpaper_id', to: 'home#create_question', as: 'home_create_question'
  delete 'home/delete_question/:question_id', to: 'home#delete_question', as: 'home_delete_question'
  get 'home/question/right_pane/:question_id', to:'home#question_question_right_pane', as: 'home_question_question_right_pane'
  post 'home/question/change_marks_for_question/:question_id', to: 'home#change_marks_for_question', as: 'home_change_marks_for_question'
  post 'home/question/enter_the_question/:question_id', to:'home#enter_the_question', as: 'home_enter_the_question'
  post 'home/solution/enter_the_solution/:question_id', to:'home#enter_the_solution', as: 'home_enter_the_solution'
  post 'home/question/question_paper_settings/:questionpaper_id', to: 'home#question_paper_settings', as: 'home_question_paper_settings'
  post 'home/solution/add_new_option/:question_id', to: 'home#add_new_option', as: 'home_add_new_option'
  delete 'home/solution/delete_option/:option_id', to: 'home#delete_option', as: 'home_delete_option'
  get 'home/solution/edit_mcqs_option/:option_id', to: 'home#edit_mcqs_option', as: 'home_edit_mcqs_option'
  put 'home/solution/edit_mcqs_option_submit/:option_id', to: 'home#edit_mcqs_option_submit', as: 'home_edit_mcqs_option_submit'

  # settings functions
  # profile page
  get 'settings/profile_page/right_pane/:right_pane_view', to: 'settings#profile_page_right_pane_view', as: 'settings_profile_page_right_pane_view'
  get 'settings/profile_page/edit_profile_details', to: 'settings#edit_profile_details', as: 'settings_edit_profile_details'
  post 'settings/profile_page/profile_details_submit_form', to: 'settings#profile_details_submit_form', as: 'settings_profile_details_submit_form'
  get 'settings/profile_page/edit_profile_details_school_details', to: 'settings#edit_profile_details_school_details', as: 'settings_edit_profile_details_school_details'
  post 'settings/profile_page/profile_details_school_details_submit_form', to: 'settings#profile_details_school_details_submit_form', as: 'settings_profile_details_school_details_submit_form'
  
end
