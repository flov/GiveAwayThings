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
end
