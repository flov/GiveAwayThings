class Person
  def facebook_user?
    not self.app_links.provider_equals('facebook').empty?
  end
  
  def facebook_uid
    self.app_links.provider_equals('facebook').first.app_user_id
  end
end