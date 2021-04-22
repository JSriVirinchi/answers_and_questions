class SettingsController < ApplicationController
	before_action :authenticate_user!

	# Pages

	def profile_page
		# Shows profile page where analytics, profile, settings aare there
	end

	# Functions

	def profile_page_right_pane_view
		# changes the right pane view - analytics, profile, settings 
		@right_pane_view = params[:right_pane_view]
		respond_to do |format|
		    format.js
	  	end
	end

	def edit_profile_details
		# link to show the form of editing profile details
		respond_to do |format|
		    format.js
	  	end
	end

	def profile_details_submit_form
		# Submits the profile details form to update user information
		custom_current_user_id = current_user.id
		custom_current_user = User.find(custom_current_user_id)
		custom_current_user.update(params.require(:profile_details_submit_form).permit(:first_name, :last_name))

		respond_to do |format|
		    format.js
	  	end
	end

	def edit_profile_details_school_details
		# link to show the form of editing school details
		respond_to do |format|
		    format.js
	  	end
	end

	def profile_details_school_details_submit_form
		# Submits the school details form to update user information
		school = School.find(current_user.school_id)
		school.update(params.require(:profile_details_school_details_submit_form).permit(:name, :address, :description, :phone))
		
		respond_to do |format|
		    format.js
	  	end
	end
end
