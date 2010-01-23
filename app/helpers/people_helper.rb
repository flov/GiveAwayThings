module PeopleHelper
  def select_countries(countries)
    collection_select :search, :address_city_country_iso_equals, countries, :iso, :name, {:include_blank => "Country"} if countries
  end
  def select_categories
    collection_select :search, :category_id_equals, Category.all, :id, :name, {:include_blank => "Category"}
  end
end
