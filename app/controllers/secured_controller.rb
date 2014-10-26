class SecuredController < ApplicationController
	puts "xxxxxxx SecuredController  before_filter action xxxxxxx"
	before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
end