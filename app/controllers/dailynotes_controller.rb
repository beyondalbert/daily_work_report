class DailynotesController < ApplicationController
  layout 'base'
  before_filter :authenticate_user!
  before_filter :find_dailynotes, :only => [:index, :create, :update]
  before_filter :find_weeklynotes, :only => [:index]
  before_filter :find_weeklynote_to_belong, :only => [:create, :update, :preview]
  
  def index

  end

  def create
    if @weeklynote_to_belong.nil?
      flash.now[:alert] = "你还没有新建周计划，请到新建工作周报中新建！"
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'notice_and_alert', :partial => 'common/notice_and_alert'
          end
        end
      end
    else
      dailynote = Dailynote.new(:date => params[:date], 
        :note => params[:dailynote], 
        :user_id => current_user.id,
        :weeklynote_id => @weeklynote_to_belong.id)
      if dailynote.save
        @dailynotes.insert(0, dailynote)
        if params[:send_dailynote]
          @week_notes = find_week_notes(dailynote.date)
          Mailer.deliver_dailynote(dailynote.date, @week_notes, @weeklynote_to_belong, current_user)
        end
        respond_to do |format|
          format.js do
            render :update do |page|
              page.replace_html 'dailynotes_list', :partial => 'dailynotes_list', :locals => {:dailynotes => @dailynotes} 
            end
          end
        end
      end
    end
  end
  
  def update
    dailynote = Dailynote.find(:first, :conditions => {:date => params[:date], :user_id => current_user.id})
    dailynote.note = params[:dailynote]
    if dailynote.save
      if params[:send_dailynote]
        @week_notes = find_week_notes(dailynote.date)
        Mailer.deliver_dailynote(dailynote.date, @week_notes, @weeklynote_to_belong, current_user)
      end
      find_dailynotes
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'dailynotes_list', :partial => 'dailynotes_list', :locals => {:dailynotes => @dailynotes} 
          end
        end
      end
    end
  end
  
  def date_change
    dailynote = Dailynote.find(:first, :conditions => {:date => params[:date], :user_id => current_user.id})
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'daily_note_content', :partial => 'daily_note_content', 
            :locals => {:note => (dailynote.nil? ? nil : dailynote.note)} 
        end
      end
    end
  end
  
  def preview
    dailynote = Dailynote.find(:first, :conditions => {:date => params[:date], :user_id => current_user.id})
    if dailynote.nil?
      dailynote = Dailynote.create(:date => params[:date], :note => params[:dailynote], :user_id => current_user.id)
    end
    @week_notes = find_week_notes(dailynote.date)
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'weekly_mail_preview', :partial => 'preview', 
            :locals => {:date => dailynote.date} 
        end
      end
    end
  end
  
  private
  def find_dailynotes
    @dailynotes = Dailynote.find(:all, :conditions => {:user_id => current_user.id}, :order => "date DESC", :limit => 7)
  end
  
  def find_weeklynotes
    @weeklynotes = Weeklynote.find(:all, :conditions => {:user_id => current_user.id}, :order => "start_date DESC", :limit => 2)
  end
  
  def find_week_notes(date)
    week_days = []
    week_index = date.wday
    if week_index == 0
      week_index = 7
    end
    date_plan = date + 86400
    1.upto(week_index) do |i|
      week_days << date
      date = date - 86400   #一天的秒数
    end
    week_days << date_plan
    Dailynote.find(:all, :conditions => {:user_id => current_user.id, :date => week_days}, :order => 'date')   
  end

  def find_weeklynote_to_belong
    week_index = Date.parse(params[:date]).wday
    if week_index == 0
      week_index = 7
    end
    monday = Date.parse(params[:date]) - (week_index - 1)
    @weeklynote_to_belong = Weeklynote.find(:first, 
      :conditions => {:user_id => current_user.id, :start_date => monday})    
  end
end
