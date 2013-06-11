$(document).ready(function(){
	// For author_cites creating new citations	
	
	var myAuthors = new Array();
		
	 addAuthor = function(){
		var myString="";
		var names = new Array();
		var flag = 0;
		value = ($('#author_cites_author_id').val());
		jQuery.each(myAuthors, function(i) {
			if(myAuthors[i]==value){
		  flag = 1;
			}
		});
		
		if(flag == 1){
		alert("Author has already been added");
		
		}
		else if(value ==""){
			alert("Please select valid author to add");
		}
		
		else if(value != ""){
			myAuthors.push(value);
			jQuery.each(myAuthors, function(i) {
		
				$.ajax({
					type: "get",
					url: "authors/full_name",
					dataType: 'json',
					data: {id: myAuthors[i]},
					success: function(data) {
						console.log(data);
						myString+= data + "<br />";
						$('#current').html(myString);
					},
					error: function(){
					console.log("ajax:error");
					}
				});
			});
			document.getElementById('auts').value = myAuthors.join();
		myString="";}
		
	}// End function addAuthor

    // For generating form based on selection for citations
    $("#citation_format").change(function(){
    	if($('#citation_format').val() == "Journal"){
    		$("#journal_title").show();
    		$("#doc").show();
    		$("#vol").show();
    		$("#pages").show();
    		$("#num").show();
    		$("#ab").show();
    		$("#format_area").show()
    		$("#pages_area").show()
    		$("#vol_area").show()
    		$("#num_area").show()
    	
    		$("#book_title").hide();
    		$("#book_select_title").hide();
    		$("#report_title").hide();
    		$("#thesis_title").hide();
    		$("#website_title").hide();
    		$("#other_title").hide();
    		$("#personal_title").hide();
    		$("#unpublished_title").hide();
    		$("#inst_doc").hide();
    		$("#pub").hide();
    		$("#email").hide();
    		$("#address").hide();
    		$("#phonenum").hide();
    		$("#com").hide();
    		$("#pub_area").hide()
    	}
    	else if ($('#citation_format').val() == "Book"){
    		$("#book_title").show();
    		$("#doc").show();
    		$("#pub").show();
    		$("#pages").show();
    		$("#ab").show();
    		$("#format_area").show()
    		$("#pages_area").show()
    		$("#pub_area").show()
    		
    		$("#journal_title").hide();
    		$("#book_select_title").hide();
    		$("#report_title").hide();
    		$("#thesis_title").hide();
    		$("#website_title").hide();
    		$("#other_title").hide();
    		$("#personal_title").hide();
    		$("#unpublished_title").hide();
    		$("#inst_doc").hide();
    		$("#email").hide();
    		$("#vol").hide();
    		$("#address").hide();
    		$("#num").hide();
    		$("#phonenum").hide();
    		$("#com").hide();
    		$("#num_area").hide()
    		$("#vol_area").hide()
    	}
    	else if($('#citation_format').val() == "Book_Section"){
    		$("#book_select_title").show();
    		$("#doc").show();
    		$("#pages").show();
    		$("#ab").show();
    		$("#format_area").show()
    		$("#pages_area").show()
    		
    		$("#journal_title").hide();
    		$("#book_title").hide();
    		$("#report_title").hide();
    		$("#thesis_title").hide();
    		$("#website_title").hide();
    		$("#other_title").hide();
    		$("#personal_title").hide();
    		$("#unpublished_title").hide();
    		$("#inst_doc").hide();
    		$("#pub").hide();
    		$("#email").hide();
    		$("#vol").hide();
    		$("#address").hide();
    		$("#num").hide();
    		$("#phonenum").hide();
    		$("#com").hide();
    		$("#pub_area").hide()
    		$("#num_area").hide()
    		$("#vol_area").hide()
    	}
    	else if($('#citation_format').val() == "Report"){
    		$("#report_title").show();
    		$("#doc").show();
    		$("#pages").show();
    		$("#ab").show();
    		$("#format_area").show()
    		$("#pages_area").show()
    		
    		$("#journal_title").hide();
    		$("#book_title").hide();
    		$("#book_select_title").hide();
    		$("#thesis_title").hide();
    		$("#website_title").hide();
    		$("#other_title").hide();
    		$("#personal_title").hide();
    		$("#unpublished_title").hide();
    		$("#inst_doc").hide();
    		$("#pub").hide();
    		$("#email").hide();
    		$("#vol").hide();
    		$("#address").hide();
    		$("#num").hide();
    		$("#phonenum").hide();
    		$("#com").hide();
    		$("#pub_area").hide()
    		$("#num_area").hide()
    		$("#vol_area").hide()
    	}
    	else if($('#citation_format').val() == "Thesis"){
    		$("#thesis_title").show();
    		$("#doc").show();
    		$("#pages").show();
    		$("#ab").show();
    		$("#format_area").show()
    		$("#pages_area").show()
    		
    		$("#journal_title").hide();
    		$("#book_title").hide();
    		$("#book_select_title").hide();
    		$("#report_title").hide();
    		$("#website_title").hide();
    		$("#other_title").hide();
    		$("#personal_title").hide();
    		$("#unpublished_title").hide();
    		$("#inst_doc").hide();
    		$("#pub").hide();
    		$("#email").hide();
    		$("#vol").hide();
    		$("#address").hide();
    		$("#num").hide();
    		$("#phonenum").hide();
    		$("#com").hide();
    		$("#pub_area").hide()
    		$("#num_area").hide()
    		$("#vol_area").hide()
    	}
    	else if($('#citation_format').val() == "Website"){
    		$("#website_title").show();
    		$("#doc").show();
    		$("#ab").show();
    		$("#format_area").show()
    		
    		$("#journal_title").hide();
    		$("#book_title").hide();
    		$("#book_select_title").hide();
    		$("#report_title").hide();
    		$("#thesis_title").hide();
    		$("#other_title").hide();
    		$("#personal_title").hide();
    		$("#unpublished_title").hide();
    		$("#inst_doc").hide();
    		$("#pub").hide();
    		$("#email").hide();
    		$("#vol").hide();
    		$("#address").hide();
    		$("#pages").hide();
    		$("#num").hide();
    		$("#phonenum").hide();
    		$("#com").hide();
    		$("#pages_area").hide()
    		$("#pub_area").hide()
    		$("#num_area").hide()
    		$("#vol_area").hide()
    	}
    	else if($('#citation_format').val() == "Other"){
    		$("#other_title").show();
    		$("#doc").show();
    		$("#ab").show();
    		$("#format_area").show()
    		
    		$("#journal_title").hide();
    		$("#book_title").hide();
    		$("#book_select_title").hide();
    		$("#report_title").hide();
    		$("#thesis_title").hide();
    		$("#website_title").hide();
    		$("#personal_title").hide();
    		$("#unpublished_title").hide();
    		$("#inst_doc").hide();
    		$("#pub").hide();
    		$("#email").hide();
    		$("#vol").hide();
    		$("#address").hide();
    		$("#pages").hide();
    		$("#num").hide();
    		$("#phonenum").hide();
    		$("#com").hide();
    		$("#pages_area").hide()
    		$("#pub_area").hide()
    		$("#num_area").hide()
    		$("#vol_area").hide()
    	}
    	else if($('#citation_format').val() == "Personal_Observation"){
    		$("#personal_title").show();
    		$("#inst_doc").show();
    		$("#email").show();
    		$("#address").show();
    		$("#phonenum").show();
    		$("#com").show();
    		$("#format_area").show()
    		$("#pages_area").show()
    		$("#pub_area").show()
    		$("#num_area").show()
    		
    		$("#journal_title").hide();
    		$("#book_title").hide();
    		$("#book_select_title").hide();
    		$("#report_title").hide();
    		$("#thesis_title").hide();
    		$("#website_title").hide();
    		$("#other_title").hide();
    		$("#unpublished_title").hide();
    		$("#doc").hide();
    		$("#pub").hide();
    		$("#vol").hide();
    		$("#pages").hide();
    		$("#num").hide();
    		$("#ab").hide();
    		$("#vol_area").hide()

    	}
    	else if($('#citation_format').val() == "Unpublished_Data"){
    		$("#unpublished_title").show();
    		$("#inst_doc").show();
    		$("#email").show();
    		$("#address").show();
    		$("#phonenum").show();
    		$("#com").show();
    		$("#format_area").show()
    		$("#pages_area").show()
    		$("#pub_area").show()
    		$("#num_area").show()
    		
    		$("#journal_title").hide();
    		$("#book_title").hide();
    		$("#book_select_title").hide();
    		$("#report_title").hide();
    		$("#thesis_title").hide();
    		$("#other_title").hide();
    		$("#personal_title").hide();
    		$("#doc").hide();
    		$("#pub").hide();
    		$("#vol").hide();
    		$("#pages").hide();
    		$("#num").hide();
    		$("#ab").hide();
    		$("#vol_area").hide()
    	}
    });
    
    //hide fields for citations
  	$('#reset_new_cite').on('click', function (e) {
			$("#journal_title").hide();
    	$("#book_title").hide();
    	$("#book_select_title").hide();
    	$("#report_title").hide();
    	$("#thesis_title").hide();
    	$("#other_title").hide();
    	$("#personal_title").hide();
    	$("#unpublished_title").hide();
    	$("#inst_doc").hide();
    	$("#pub").hide();
    	$("#email").hide();
    	$("#vol").hide();
    	$("#address").hide();
    	$("#pages").hide();
    	$("#num").hide();
    	$("#phonenum").hide();
    	$("#com").hide();
    	$("#pages_area").hide()
    	$("#pub_area").hide()
    	$("#num_area").hide()
    	$("#vol_area").hide()
    	$("#website_title").hide();
    	$("#format_area").hide();
    	$("#ab").show();
    	myAuthors = new Array();
    	var myString="";
    	jQuery.each(myAuthors, function(i) {
			myString+= myAuthors[i] + "<br />";
			});
			$('#current').html(myString);
			myString="";
	});
	

});
