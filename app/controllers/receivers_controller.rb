class ReceiversController < ApplicationController
  layout 'base'
  before_filter :authenticate_user!
  before_filter :find_contacts, :only => [:index, :create]
  
  def index
   
  end

  def new
    @contact_type = params[:contact_type]
    respond_to do |format|
      format.js do
        render :update do |page|
          if @contact_type == 'to'
            page.replace_html 'new_recipient', :partial => 'new' 
          else
            page.replace_html 'new_cc_recipient', :partial => 'new' 
          end
        end
      end
    end
  end
  
  def create
    receiver = Receiver.new(:name => params[:name], :email => params[:email_address], :user_id => current_user.id)
    if params[:contact_type] == 'to'
      receiver.contact_type = TO
    else
      receiver.contact_type = CC
    end
    if receiver.save
      if params[:contact_type] == 'to'
        @recipients << receiver
      else
        @cc_recipients << receiver
      end
      respond_to do |format|
        format.js do
          render :update do |page|
            if params[:contact_type] == 'to'
              page.replace_html 'recipients_list', :partial => 'contact_list', :locals => {:contact_type => 'to'}
            else
              page.replace_html 'cc_recipients_list', :partial => 'contact_list', :locals => {:contact_type => 'cc'}
            end
          end
        end
      end
    else
      flash.now[:error] = "联系人保存出错！请重新保存"
    end
  end
  
  def delete
    contact_to_delete = Receiver.find(params[:id])
    @contact_type = contact_to_delete.contact_type
    contact_to_delete.destroy
    
    find_contacts
    respond_to do |format|
      format.js do
        render :update do |page|
          if @contact_type == TO
            page.replace_html 'recipients_list', :partial => 'contact_list', :locals => {:contact_type => 'to'}
          else
            page.replace_html 'cc_recipients_list', :partial => 'contact_list', :locals => {:contact_type => 'cc'}
          end
        end
      end
    end
  end
  
  def edit
    @contact = Receiver.find(params[:id])
    render(:partial => 'edit')
  end
  
  def edit_save
    @contact = Receiver.find(params[:id])
    @contact.name = params[:name]
    @contact.email = params[:email_address]
    if @contact.save
      render(:partial => 'contact_item')
    end
  end
  
  def switch
    contact = Receiver.find(params[:id])
    contact.contact_type == TO ? contact.contact_type = CC : contact.contact_type = TO
    if contact.save
      find_contacts
      respond_to do |format|
        format.js do
          render :update do |page|         
            page.replace_html 'recipients_list', :partial => 'contact_list', :locals => {:contact_type => 'to'}      
            page.replace_html 'cc_recipients_list', :partial => 'contact_list', :locals => {:contact_type => 'cc'}   
          end
        end
      end
    end
  end
  
  private
  def find_contacts
    @recipients = Receiver.find(:all, :conditions => {:user_id => current_user.id, :contact_type => TO})
    @cc_recipients = Receiver.find(:all, :conditions => {:user_id => current_user.id, :contact_type => CC})   
  end
  
end
