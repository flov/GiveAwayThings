class Person
  def facebook_user?
    not Person.last.app_links.provider_equals('facebook').empty?
  end
end