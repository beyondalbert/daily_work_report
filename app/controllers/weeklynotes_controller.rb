class WeeklynotesController < ApplicationController
  before_filter :find_weeklynotes, :only => [:create]
  before_filter :find_weeklynote, :only => [:update, :start_date_change]
  
  def index
  end

  def create
    weeklynote = Weeklynote.new(:start_date => params[:start_date], 
      :end_date => Date.parse(params[:start_date]) + 7, 
      :note => params[:weeklynote], 
      :user_id => current_user.id)
    if weeklynote.save
      @weeklynotes.insert(0, weeklynote)
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'weeklynotes_list', :partial => 'weeklynotes_list', :locals => {:weeklynotes => @weeklynotes}
          end
        end
      end
    else
      flash.now[:alert] = weeklynote.errors[:start_date] unless weeklynote.errors[:start_date].nil?
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'notice_and_alert', :partial => 'common/notice_and_alert'
          end
        end
      end
    end
  end
  
  def update
    @weeklynote.note = params[:weeklynote]
    if @weeklynote.save
      find_weeklynotes
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'weeklynotes_list', :partial => 'weeklynotes_list', :locals => {:weeklynotes => @weeklynotes}
          end
        end
      end
    end
  end
  
  def start_date_change
    if @weeklynote.nil?
      end_date = Date.parse(params[:start_date]) + 6
    else
      end_date = @weeklynote.end_date.strftime('%Y-%m-%d')
    end
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'weekly_note_content', :partial => 'weeklynotes/weekly_note_content', 
            :locals => {:note => (@weeklynote.nil? ? nil : @weeklynote.note)}
          page.replace_html 'end_date_span',  :partial => 'end_date_span', :locals => {:end_date => end_date} 
        end
      end
    end
  end
  
  private
  def find_weeklynotes
    @weeklynotes = Weeklynote.find(:all, :conditions => {:user_id => current_user.id}, :order => "start_date DESC", :limit => 2)
  end
  
  def find_weeklynote
    @weeklynote = Weeklynote.find(:first, :conditions => {:start_date => params[:start_date], :user_id => current_user.id})
  end
end
