class GeneralController < ApplicationController
	def landing_page
		# This page gives the general information of the entire service.
		# And this acts as a landing page and one can view all the features available.
		# Customers can also view the pricing plans
		# To view this site, there is no need for the user to login

		if current_user
			@logged_in = true
		else
			@logged_in = false
		end

	end
end