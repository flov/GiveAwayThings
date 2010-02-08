class Emailer < ActionMailer::Base

  def gmail_message
    subject    'Message via gmail'
    recipients 'florian.vallen@gmail.com'
    from       'florian@giveawaythings.org'
    sent_on    Time.now
    body       :greeting => 'Hello!'
  end
  
  def confirm_email(user)
    defaults
    recipients    user.email
    subject       'Get started with GiveAwayThings!'
    body          :user => user, :login_link => confirm_email_user_url(user, :token => user.login_token)
  end

end