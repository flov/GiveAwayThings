// inFieldLabel requirement
$(document).ready(function(){
  //required for in field label
  $(".in_field_label label").inFieldLabels();


  $("textarea#item_description").blur(function(){
    $("tr#item_description_fields").hide();
  })

  //dashboard form
  $("input#item_title").click(function(){
    $("#item_description_fields").show()
  })
});