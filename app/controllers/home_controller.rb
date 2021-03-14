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

	def question_paper_edit_page
		# Page for editing question papers
		@questionpaper = Questionpaper.find(params[:questionpaper_id])
	end

	########## Functions ###########

	def create_question_paper
		# This posts the question paper into the table
		@questionpaper = Questionpaper.new(params.require(:create_question_paper).permit(:name).merge(user_id: current_user.id))
		if @questionpaper.save
			redirect_to home_question_paper_edit_page_path(@questionpaper.id)
		else
			respond_to do |format|
			    format.js
		  	end
		end			
	end

	def delete_question_paper
		# One can delete question papers
		@questionpaper = Questionpaper.find(params[:questionpaper_id])
		@questionpaper.destroy
		respond_to do |format|
		    format.js
	  	end
	end

	def edit_name_question_paper
		# For changing the name into a editable form 
		@questionpaper = Questionpaper.find(params[:questionpaper_id])
		respond_to do |format|
		    format.js
	  	end
	end

	def edit_name_question_paper_submit
		# To submit the name and changing the form to text 
		@questionpaper = Questionpaper.find(params[:questionpaper_id])
		@questionpaper.update(params.require(:edit_name_question_paper_submit).permit(:name))
		
		respond_to do |format|
		    format.js
	  	end
	end

	def create_question
		# To create a question
		@questionpaper = Questionpaper.find(params[:questionpaper_id])
		question_number = Question.where(questionpaper_id: @questionpaper.id).count + 1
		default_marks = 2
		@question = Question.create(questionpaper_id: @questionpaper.id, question_number: question_number, marks: default_marks)

		respond_to do |format|
		    format.js
	  	end
	end

end