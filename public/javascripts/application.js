// inFieldLabel requirement
$(document).ready(function(){
  //required for in field label
  $(".in_field_label label").inFieldLabels();
  //dashboard form
  $("input#item_title").click(function(){
    $("#item_description_fields").show()
  })
});