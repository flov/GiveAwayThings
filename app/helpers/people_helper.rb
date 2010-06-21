module PeopleHelper
  def select_countries(countries)
    collection_select :search, :address_city_country_id_equals, countries, :id, :name, {:include_blank => "Country"} if countries
  end

  def select_categories
    collection_select :search, :category_id_equals, Category.all, :id, :name, {:include_blank => "Category"}
  end

  def person_fields(f,person,options)
    options ||= {}
    render :partial => 'people/fields', 
      :locals => { 
        :f => f,
        :person => person,
        :options => options }
  end

  def print_given_items(given_items)
    result=[]
    given_items.each{|item| result << link_to(truncate(item.title), item_path(item))}
    result.join(', ')
  end
  
  def requests(person)
    if person.requests_from_x.count != 0
      link_to("#{person.requests_from_x.count}R", requests_person_path(person), :class => 'requests_flag')
    end
  end
  
  def your_requests
    if logged_in? && current_person == @person && current_person.has_opened_requests?
      #!@requests_from_x.zip(@requests_accepted_by_x, @requests_you_accepted, @requests_by_you).empty?
      render :partial => 'people/your_requests'
    end
  end
  
  def accepted_requests(person)
    unless person.requests_x_accepted.count == 0
      link_to(person.requests_x_accepted.count, requests_person_path(person), :class => 'accepted_flag')
    end
  end

  def unread_messages(person)
    link_to("#{person.unread_messages.count} new", inbox_path, :class => 'messages_flag')
  end

  def show_profile_title
    if logged_in? and current_person == @person
      title " &rarr; Your Profile"
    else
      title "&rarr; #{h(@person.username.capitalize)}"
    end
  end

  def print_items(given_items)
    result=[]
    given_items.each{|item| result << link_to(truncate(item.title), item_path(item))}
    result.join(', ')
  end
  
  def avatar_picture(person, options={})
    if person.facebook_user?
      if options[:size] == 'large'
        "<img src='http://graph.facebook.com/#{person.facebook_uid}/picture?type=large'/>"
      else
        "<img src='https://graph.facebook.com/#{person.facebook_uid}/picture'/>"
      end
    else
      if options[:size] == 'large'
        link_to gravatar_for(person, :size => 100, :class => 'gravatar'),person_path(person.username)
      else
        link_to gravatar_for(person, :size => 36, :class => 'gravatar'), person_path(person.username)
      end
    end
  end
  
  def facebook_picture(person, options={})
    if options[:size] == 'large'
      "<img src='http://graph.facebook.com/#{person.facebook_uid}/picture?type=large'/>"
    else
      "<img src='https://graph.facebook.com/#{person.facebook_uid}/picture'/>"
    end
  end
end
