class HomeController < ApplicationController
	before_action :authenticate_user!

	def dashboard_page	
		# This the dashboard page. It varies according to the type of user.
		# If it is an admin, student, teacher.
	end

end