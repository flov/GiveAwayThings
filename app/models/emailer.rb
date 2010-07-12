class Emailer < ActionMailer::Base

include ActionController::UrlWriter # Allows us to generate URLs
include ActionView::Helpers::TextHelper
  
  def confirm_email(person)
    defaults
    recipients    person.email
    from          'GiveAwayThings'
    subject       'Get started with GiveAwayThings!'
    body          :person => person, :login_link => confirm_email_person_url(person.username, :token => person.login_token[0..3])
  end

  def request_email(request)
    defaults
    recipients    request.owner.email
    subject       "[GAT] new request for '#{request.item.title}'"
    body          :request => request
  end
  
  private  
  def defaults
    content_type  'text/html'
    sent_on       Time.now
    from          'GiveAwayThings.org'
  end

end