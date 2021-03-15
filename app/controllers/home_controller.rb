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

	# questionpaper
	def create_question_paper
		# This posts the question paper into the table
		@questionpaper = Questionpaper.new(params.require(:create_question_paper).permit(:name).merge(user_id: current_user.id, number_of_questions: 0, total_marks: 0))
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

	# questions
	def create_question
		# To create a question
		# Changes the number of questions in question paper accordingly
		# Modifies the total marks accordingly
		@questionpaper = Questionpaper.find(params[:questionpaper_id])
		question_number = Question.where(questionpaper_id: @questionpaper.id).count + 1
		default_marks = 2
		@question = Question.create(questionpaper_id: @questionpaper.id, question_number: question_number, marks: default_marks)

		number_of_questions = @questionpaper.number_of_questions
		number_of_questions = number_of_questions + 1
		@questionpaper.update(number_of_questions: number_of_questions)

		total_marks = 0 
		for i in Question.where(questionpaper_id: @questionpaper.id)
			total_marks = total_marks + i.marks 
		end

		@questionpaper.update(total_marks: total_marks)

		respond_to do |format|
		    format.js
	  	end
	end

	def delete_question
		# delete question from the table
		# Changes the number of questions in question paper accordingly
		# Adjusts the question number such that they will be continuous.
		# Modifies the total marks accordingly

		@question = Question.find(params[:question_id])
		@questionpaper = Questionpaper.find(@question.questionpaper_id)

		# fixing the continuous question number
		deleting_question_number = @question.question_number

		for i in Question.where(questionpaper_id: @questionpaper.id)
			if i.question_number > deleting_question_number
				new_question_number = i.question_number - 1
				i.update(question_number: new_question_number)
			end
		end

		# fixing number of questions
		number_of_questions = @questionpaper.number_of_questions
		number_of_questions = number_of_questions - 1
		@questionpaper.update(number_of_questions: number_of_questions)

		# deleting the question
		@question.destroy

		# fixing the total marks
		total_marks = 0 
		for i in Question.where(questionpaper_id: @questionpaper.id)
			total_marks = total_marks + i.marks 
		end

		@questionpaper.update(total_marks: total_marks)

		# ajax
		respond_to do |format|
		    format.js
	  	end
	end
end