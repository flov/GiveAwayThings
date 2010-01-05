# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def footer
    render :partial => 'shared/footer'
  end

  def javascripts
    render :partial => 'shared/javascripts'
  end

  def ie_sensitivity
    render :partial => 'shared/ie_sensitivity'
  end
end
