class UserMailer < ActionMailer::Base
  def registration_confirmation(person)
    recipients  person.email
    from        "webmaster@giveawaythings.org"
    subject     "Thank you for registering"
    sent_on       Time.now
    body        :person => person
  end
end
