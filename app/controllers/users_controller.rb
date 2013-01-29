class UsersController < ApplicationController
  layout 'base'
  before_filter :authenticate_user!
  
  def index
  end

  def edit
    respond_to do |format|
      format.js do
        render :update do |page|         
          page.replace_html 'user_info', :partial => 'edit' 
        end
      end
    end
  end
  
  def update
    current_user.lastname = params[:lastname] unless params[:lastname].nil?
    current_user.firstname = params[:firstname] unless params[:firstname].nil?
    if current_user.save
      respond_to do |format|
        format.js do
          render :update do |page|         
            page.replace_html 'user_info', :partial => 'user_info' 
          end
        end
      end
    end
  end
end
