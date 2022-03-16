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
		@number_of_questions_per_page = 7 #The number can be changed to view number of questions per page
		@pagination_questions = Questionpaper.where(user_id: current_user.id).paginate(page: params[:page], per_page: @number_of_questions_per_page)
	end

	def question_paper_edit_page
		# Page for editing question papers
		@questionpaper = Questionpaper.find(params[:questionpaper_id])
	end

	########## Functions ###########

	# questionpaper
	def create_question_paper
		# This posts the question paper into the table
		@questionpaper = Questionpaper.new(params.require(:create_question_paper).permit(:name, :default_marks).merge(user_id: current_user.id, number_of_questions: 0, total_marks: 0))

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
		@number_of_questions_per_page = 7 #The number can be changed to view number of questions per page
		@pagination_questions = Questionpaper.where(user_id: current_user.id)
		
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
		default_marks = @questionpaper.default_marks
		@question = Question.create(questionpaper_id: @questionpaper.id, question_number: question_number, marks: default_marks)
		@question_id = @question.id

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
		@question_id = @question.id

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

	def question_question_right_pane
		# This changes the right pane view based on the question selected
		@question = Question.find(params[:question_id])
		@questionpaper = Questionpaper.find(@question.questionpaper_id)
		@question_id = @question.id

		respond_to do |format|
		    format.js
	  	end
	end

	def change_marks_for_question
		# This changes the marks for the individual question.
		# And accordingly the total marks also change

		@question = Question.find(params[:question_id])
		@questionpaper = Questionpaper.find(@question.questionpaper_id)
		@question_id = @question.id
		if @question.update(params.require(:change_marks_for_question).permit(:marks))
			@updated = true

			# fixing the total marks		
			@questionpaper = Questionpaper.find(@question.questionpaper_id)
			total_marks = 0 

			for i in Question.where(questionpaper_id: @questionpaper.id)
				total_marks = total_marks + i.marks 
			end
			@questionpaper.update(total_marks: total_marks)

		else
			@updated = false
		end	

		respond_to do |format|
		    format.js
	  	end
	end

	def enter_the_question
		# User can enter the question in a text area and it stores in database
		@question = Question.find(params[:question_id])
		@question.update(params.require(:enter_the_question).permit(:question))
	end

	def enter_the_solution
		# User can enter the solution in a text area and it stores in database
		@question = Question.find(params[:question_id])
		@question.update(params.require(:enter_the_solution).permit(:solution))
	end

	def question_paper_settings
		# Submitting for modifying the question paper settings like default marks.
		@questionpaper = Questionpaper.find(params[:questionpaper_id])
		if @questionpaper.update(params.require(:question_paper_settings).permit(:default_marks))
			@updated = true
		else
			@updated = false
		end		

		respond_to do |format|
		    format.js
	  	end
	end

	def home_page_right_pane_view
		# Changing the right pane view of the home page
		@right_pane_view = params[:right_pane_view]
		respond_to do |format|
		    format.js
	  	end
	end

	def add_new_option
		# Add a new option to the mcqs
		@question = Question.find(params[:question_id])
		@question_id = @question.id
		Option.create(option: "New option", answer: false, question_id: @question.id)

		respond_to do |format|
		    format.js
	  	end
	end

	def delete_option
		# Delete the selected option in the mcqs
		@option = Option.find(params[:option_id])
		@question_id = @option.question_id
		@option.destroy

		respond_to do |format|
		    format.js
	  	end
	end

	def edit_mcqs_option
		# Edit the content of the mcqs - getting the text field
		@option = Option.find(params[:option_id])
		@question_id = @option.question_id

		respond_to do |format|
		    format.js
	  	end
	end

	def edit_mcqs_option_submit
		# Submitting the edited mcq option - and closing the text field
		@option = Option.find(params[:option_id])
		@question_id = @option.question_id
		@option.update(params.require(:edit_mcqs_option_submit).permit(:option))

		respond_to do |format|
		    format.js
	  	end
	end
end
