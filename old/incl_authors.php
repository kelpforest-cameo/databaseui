<script>

function openNewAuthorDialog() {
	$('#new_author_dialog_first_name').val('');
	$('#new_author_dialog_last_name').val('');
	$('#new_author_dialog').dialog('open');
}


</script>	
<!-- |||||||||||||||||add new author dialog||||||||||||||||||||| 
	you get here from the citation dialogue 
	this dialogue will allow you to add authors 
-->
<div id="new_author_dialog" title="Add New Author">
	  <div class="divpad"><label for="new_author_dialog_first_name">First Name: </label>
  	<input type="text" class="medium"  name="new_author_dialog_first_name" id="new_author_dialog_first_name" />
		</div>
	  <div class="divpad"><label for="new_author_dialog_last_name">Last Name: </label>
  	<input type="text" class="medium" name="new_author_dialog_last_name" id="new_author_dialog_last_name" />
		</div>
</div>

<script>
		$( "#new_author_dialog" ).dialog({
			autoOpen: false,
			height: 180,
			width: 340,
			modal: true,
			buttons: {
				"Add New Author": function() {
						var author = new Object();
						author.first_name = jQuery.trim( $( "#new_author_dialog_first_name" ).val() );
						author.last_name = jQuery.trim( $( "#new_author_dialog_last_name" ).val() );
						var postdata = new Object();
						postdata.author = author;
						postdata.functionName = "addNewAuthor";
						if( author.first_name != ""  && author.last_name != "" ) {
							$.ajax( { async:false, type:"GET", dataType:"json",
		 						data: postdata, 
		 						url: "query.php", 
		 						success: function(data, t, x) {	
									if (data.error == undefined ) {
										log("Added new author with id=" +  data.id + ", name=" + data.last_name +", " +data.first_name);
										makeAuthorCiteSpan( data.id, data.last_name +", " +data.first_name) ; 
						   		  $( "#new_author_dialog").dialog( "close" );
									} else {
										alert(data.error);
									}	
								}
							});
						} else {
							alert("Please enter a first and last name");
						}
				},
				"Close": function() {
					$( this ).dialog( "close" );
				}
			}
		});

</script>	
