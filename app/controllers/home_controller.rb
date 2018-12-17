class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
		@developers = Developer.all
		@projects = Project.all
	end
end
