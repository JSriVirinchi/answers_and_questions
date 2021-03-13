class HomeController < ApplicationController
	before_action :authenticate_user!

	############# Pages ################

	def dashboard_page	
		# This the dashboard page. It varies according to the type of user.
		# If it is an admin, student, teacher.
		# It shows the interaction between different roles.	
	end

	def question_paper_page
		# This is question paper page. The list of question papers can be seen here.
		# One can create, edit, view, delete papers here.
		# It is available for teacher role.

	end

	########## Functions ###########

	def create_question_paper
		# This posts the question paper into the table
		@questionpaper = Questionpaper.create(params.require(:create_question_paper).permit(:name))
		respond_to do |format|
    		format.js
	  	end 
	end

end