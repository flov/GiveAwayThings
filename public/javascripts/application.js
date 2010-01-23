// inFieldLabel requirement
$(document).ready(function(){
  //required for in field label
  $(".in_field_label label").inFieldLabels();
	//
	
  //tablesorter
	$("#show_items").tablesorter();
	$("#show_items tbody tr:odd").addClass("odd")
	$("#show_items tbody tr").hover(function(){
		$(this).addClass("hover");
	},function(){
		$(this).removeClass("hover");
	});
	//
	
	//Drop Down in Welcome Menu
  $("input#item_title").click(function(){
    $("#item_description_fields").slideDown()
  })
  $("input#search_title_like").click(function(){
    $("#search_select_items").slideDown()
  })
	//
	
});