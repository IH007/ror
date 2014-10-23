class SecuredController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
end
