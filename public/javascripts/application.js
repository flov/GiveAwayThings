// inFieldLabel requirement
$(document).ready(function(){
  //required for in field label
  $(".in_field_label label").inFieldLabels();
  
  $("input#item_title").click(function(){
    $("#item_description_fields").slideDown()
  })
  $("textarea#item_description").blur(function(){
    $("#item_description_fields").slideUp();
  })

  $("input#search_items").click(function(){
    $("#search_select_items").slideDown()
  })
});