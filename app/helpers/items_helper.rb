module ItemsHelper
  def request_fields(f, item)
    render :partial => 'requests/fields', :locals => {:f => f, :item => item}
  end  
end
