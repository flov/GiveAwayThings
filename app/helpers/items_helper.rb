module ItemsHelper
  def request_fields(f)
    render :partial => 'requests/fields', :locals => {:f => f}
  end  
end
