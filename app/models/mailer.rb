class Mailer < ActionMailer::Base
 
  def dailynote(date, week_notes, weeklynote, user, sent_at = Time.now)
    subject    "#{user.name}_#{date.strftime('%y-%m-%d')}_工作日报"
    recipients user.to
    cc user.cc
    from       user.email
    sent_on    sent_at
    
    body       :greeting => 'Hi,', :week_notes => week_notes, :date => date, :weeklynote => weeklynote
  end

end
