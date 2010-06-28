module ItemsHelper
  def image_of_item(item)
    link_to(image_tag(item.photo.url(:medium)), item.photo.url) unless item.photo.url.include? "missing.png"
  end

  def edit_link_if_logged_in(item)
    link_to '(edit)', edit_item_path(item) if logged_in? and item.person == current_person
  end

  def send_request(request, item)
    if !logged_in? && !item.taken? && !item.accepted? && item.person != current_person
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
