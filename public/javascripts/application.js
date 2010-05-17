// inFieldLabel requirement
$(document).ready(function(){
  //Elastic
  $('textarea').elastic();
  
  //Tablesorter
	$("#show_items").tablesorter();
	$("#show_items tbody tr:odd").addClass("odd")
	$("#show_items tbody tr").hover(function(){
		$(this).addClass("hover");
	},function(){
		$(this).removeClass("hover");
	})

	//Tipsy
	$(function() {
  	$('a[rel=tipsy]').tipsy({fade: true, gravity: 'e'})
  })
	
	//Drop Down in Welcome Menu
	//Label of item
  $("input#item_title").focus(function(){
    $("#slidedown_fields").slideDown()

    var title_text1 = "Type in item."
    var title_text2 = "Come on. Think of something to give away..."
    if(this.value==title_text2 || this.value==title_text1 )$(this).val("")
	  $(this).blur(function(){
	    if(this.value=='')$(this).val(title_text2)
	  })
  })

  //Label of Description
  $("textarea#item_description").focus(function(){
    $("#hidden_search_options").slideDown()
    
    var description_text = "Description (optional)"
    if(this.value == description_text)$(this).val("")
    $(this).blur(function(){
      if(this.value==''){
        $(this).val(description_text)
      }
    })  
  })

  //Label of Searchfield
  var search_text = "Type in city."
  $("input#search_title_like").focus(function(){
    if(this.value == search_text)$(this).val("")
  })	
  
  //Submit search field with empty query string if input == search_text
  $('#search_item').submit(function() {
    if($("input#search_title_like").val()==search_text){
      $("input#search_title_like").val('')
    }
  });

})