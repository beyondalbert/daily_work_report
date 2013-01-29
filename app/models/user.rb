class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :confirmable, :lockable, :timeoutable and :activatable
  devise :registerable, :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  has_many :receivers, :dependent => :delete_all
  has_many :dailynotes, :dependent => :delete_all
  has_many :weeklynotes, :dependent => :delete_all
  
  def self.current
    
  end
  
  def name
    if self.lastname.nil? || self.firstname.nil?
    else
      self.lastname + self.firstname
    end  
  end
  
  def to
    mails_addr_to = []
    receivers.find(:all, :conditions => {:contact_type => 1}).each do |r|
      mails_addr_to << r.email
    end
    mails_addr_to
  end
  
  def cc
    mails_addr_cc = []
    receivers.find(:all, :conditions => {:contact_type => 2}).each do |r|
      mails_addr_cc << r.email
    end
    mails_addr_cc
  end
end
