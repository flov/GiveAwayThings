module ItemsHelper
  def image_of_item(item)
    link_to(image_tag(item.photo.url(:medium)), item.photo.url) unless item.photo.url.include? "missing.png"
  end
  
  def send_request(request, item)
    if logged_in? and not item.person == current_person and not item.taken? and not item.accepted?
      render :partial => 'items/send_request', :locals => {:request => request, :item => item} 
    end
  end
  
  def item_taken_or_accepted(item)
    if @item.taken?
      item_has_been_taken(@item) 
    elsif @item.accepted?
      item_has_been_accepted(@item) if @item.accepted?
    end
  end
  
  def item_has_been_taken(item)
    if item.taken?
      render :partial => 'items/taken_by', :locals => {:item => item} 
    end
  end
  
  def item_has_been_accepted(item)
    if item.accepted?
      render :partial => 'items/accepted', :locals => {:item => item} 
    end
  end
end
