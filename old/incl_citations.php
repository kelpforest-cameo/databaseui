<script>

// callback for when we change the format type on a citation when
// submitting a new citation  (e.g. when selecting Journal, Book, etc.)
function onFormatSelectChange( sel) {
	var val= sel.options[sel.selectedIndex].value;
	$("#new_citation_dialog_pages_div").remove();
	$("#new_citation_dialog_publisher_div").remove();

	if (val == "Book") {
		var pub=  '<div class="divpad" id="new_citation_dialog_publisher_div"><label for="new_citation_dialog_publisher">Publisher: </label>';
		pub += '<input type="text"  name="new_citation_dialog_publisher" id="new_citation_dialog_publisher" /></div>';
		$(pub).insertAfter('#new_citation_dialog_format_title_div');
	}	

	if (val != "Web Site") {
	  var pages=  '<div class="divpad" id="new_citation_dialog_pages_div"><label for="new_citation_dialog_pages">Pages: </label>';
  	pages += '<input type="text" class="medium" name="new_citation_dialog_pages" id="new_citation_dialog_pages" /></div>';
		$(pages).insertAfter('#new_citation_dialog_format_title_div');
	}

	if (val == "Journal") {
	  var volume=  '<div class="divpad" id="new_citation_dialog_volume_div"><label for="new_citation_dialog_volume">Volume: </label>';
  	volume += '<input type="text"  name="new_citation_dialog_volume" id="new_citation_dialog_volume" /></div>';
		var numb = '<div class="divpad" id="new_citation_dialog_number_div"><label for="new_citation_dialog_number">Number: </label>';
		numb += '<input type="text" class="medium" name="new_citation_dialog_number" id="new_citation_dialog_number" /></div>';
		$(volume + numb).insertAfter('#new_citation_dialog_format_title_div');
	} else { 
		$("#new_citation_dialog_volume_div").remove();
		$("#new_citation_dialog_number_div").remove();
	}

	$("#new_citation_dialog_format_title_label").html( val + " title:");
}

// in the citation dialog, there is a div that holds author information.
// use this function to remove that div	
function removeAuthorFromCitationDialog( author_id ) {
	$("#author_"+author_id).remove();
	var a_ids = $("#new_citation_dialog_authors").data("author_ids");
	for(var i in a_ids) {
		if(a_ids[i] == author_id) {
			a_ids.splice(i, 1);
			break;
		}
	}
}

// we set up an array of vars that can be sent to the query.php
// the addNewCitedVars function of query.php will go through each
// of these and add them to the DB
// array looks like this:
// {"cite_id":"1","node_id":"1","table":"node_max_age","fields":["max_age"],"values":["23"]}
// cite_id is the citation id
// node_id (or stage_id) is the id of the node or stage that is being cited
// table is the table name that is being cited
// fields is an array of fields that are to be inserted in the table named above
// values are the values of each respective field
function buildCitationObj( cite_id, foreign_table, foreign_id, label, varprefix ) {
	var obj = new Object();
	obj['cite_id'] = cite_id;
	if (foreign_table == "node") {
		obj['node_id'] = foreign_id;
	} else if ( foreign_table == "stage" ) {
		obj['stage_id'] = foreign_id;
	}
	if (label.slice(0,5) == "range") { 
		// this is a node range value
		obj['table'] =  "node_range";
		obj['fields'] =  Array();
		obj['values'] = Array( );
		// get the location id's from the dropdown
		var location_n_id =  $("#"+ varprefix +"_range_N").val();
		var location_s_id =  $("#"+ varprefix +"_range_S").val();

		if (location_n_id!=null && location_s_id !=null) {
			obj['fields'].push("location_n_id");
			obj['values'].push(location_n_id);
			obj['fields'].push("location_s_id");
			obj['values'].push(location_s_id);
		}
	} else if(label.slice(0,7) == "length_") { 
		// this is a stage length_weight or length_fecundity value
		obj['table'] =  foreign_table +'_'+label;
		obj['fields'] = Array( label, 'a', 'b') ;
		obj['values'] = Array( $("#"+ varprefix +"_" + label).val(), $("#"+ varprefix +"_" + label + "_a").val(), $("#"+ varprefix +"_" + label + "_b").val());
	} else {  
		obj['table'] =  foreign_table +'_'+label;
		obj['fields'] = Array( label) ;
		obj['values'] = Array( $("#"+ varprefix +"_" + label).val() );
	}
	return obj;
}

// add a citation <option> element to the citation dialog
function addCiteToCitationDialogSelect( cite ) {
	var ret = false;	
	$('#citation_dialog_select').children().each(function(i, option){ 
			if (cite.id == $(option).val()) {
				$(option).attr("selected","selected");	
				ret =true;
			} 
	});
	if (ret) return;
	authors="";
	for (var j=0;j< cite.authors.length;j++) {
		if (j != 0) authors+=",&nbsp;";
		authors+=cite.authors[j].last_name;
	}
	var label = authors + ' - \'' +  cite.title + '\',' +  cite.year;
	var tmp = '<option selected value="'+ cite.id +'">' + label +'</option>';	
	$("#citation_dialog_select").append(tmp);	
	$("#new_interaction_observation_dialog_select").append(tmp);	
}

// call the DB to get citation info for a particular id
// appends the returned data to the global citation array
function getCitationInfo( cite_id) {
	// first check to see if we have it globally already
	for (var i in citations ) {
		if ( citations[i].id == cite_id) {
			log("Requesting cite info, already cached: " + cite_id);
			return citations[i];
		}
	}	
	var postdata = Object() ;
	postdata.functionName = "getCitationInfo";
	postdata.cite_id = cite_id;
	log("Requesting cite info for id: " + cite_id);
	$.ajax( { async:false, type:"GET", dataType:"json",
			data: postdata, 
			url: "query.php", 
			success: function(data, t, x) {	
			if (data == null) {
			  alert("Error : data is null" );
			} else if (data.error != undefined ) {
				alert("Error: " + data.error);
			} else {
				postdata.response = data;
				// add to global citations array
				citations.push(data);
				addCiteToCitationDialogSelect(data);
				log("Found cite info for id: " + cite_id);
			}
		}
	});
	return postdata.response;
}

// use this to append cited variables to the node dialogue (node or stage part)
// it will get an array of objects such as
// [{cite_id:1, node_id:3, table: node_max_age, fields:[max_age], values[23]}, ... ]
// the fields and values are arrays that can hold more than one field/value pair
function appendCitedVars( cite_array, varprefix ) {
	for (var i in cite_array) {
		var cite = cite_array[i];
		if (cite.error != undefined) {
			alert("Error on " + cite.table + ":" + cite.error);
		} else {
			// there were no errors
			// we need to deal with range info separately
			if (cite.table != "node_range" ) {
				if (cite.table.slice(0,4) == "node") {
					// deal with node info
					var name = cite.fields[0];
					var val_text = cite.values[0];
					var tmp2 = makeCiteSpan(cite.cite_id, val_text, "node_" + name, cite.node_id, "node");
					$("#view_"+ varprefix +"_"+name).append(tmp2);
				} else if ( cite.table.slice(0,5) == "stage") {
					var name = cite.fields[0];
					var val_text = cite.values[0];
					// some cited vars (such as length_weight) are arrays with more field:values, let's show these
					// be careful to show only useful information.  length_weight=none means there is no A/B constant. don't show it.
					if (cite.fields[0].slice(0,7) == "length_" && 
							 cite.values[0] != "none exists - constant fecundity" && 
							 cite.values[0] != "none exists - constant weight") {
						val_text = cite.values[0] + " - A:" + cite.values[1] + " B:" + cite.values[2];
					}
					for (var j in display_options.stage_names) {
						var stage_name = display_options.stage_names[j];
						// GLOBAL NODE
						if ( node.stages[stage_name] != undefined && node.stages[stage_name].id == cite.stage_id) {
							var tmp2 = makeCiteSpan(cite.cite_id, val_text, "stage_" +name, cite.stage_id, "stage");
							$("#view_"+varprefix+"_" +name).append(tmp2);
						}
					}
				}
			} else {// we range data, let's do ranges below
				//alert(JSON.stringify(cite));
				var location_n_id=null;
				var location_s_id=null;
				for (var j in cite.fields ) {
					if (cite.fields[j] == "location_n_id") 
						location_n_id = cite.values[j];
					if (cite.fields[j] == "location_s_id") 
						location_s_id = cite.values[j];
				}
				var hmm="";
				if ( location_n_id!=null && location_s_id !=null) {		
					hmm += "<div>" + getLocationNameFromId(location_n_id) + ' N </div>' +
						"<div>" + getLocationNameFromId( location_s_id ) + ' S</div>';
				}
				var tmp2 = makeCiteSpan(cite.cite_id, hmm, "node_range", cite.node_id, "node");
				$("#view_"+ varprefix +"_range").append(tmp2);
			} 
		} 
	}
}




// build and open a citation dialog window with variables
function buildCitationDialog( labels, title, node, stage_name){

	var node_or_stage = stage_name == null ? "node" : "stage";	// are we dealing with a node or a stage
	var dlog_name = makeDlogName(node); 												// the full ID path name prefix for node DOM object
	var varprefix ='';																					// the full ID path name prefix for DOM object (node or stage var)
	if (node_or_stage == "node") 
		varprefix = dlog_name;
	else
		varprefix = dlog_name + "_stages_" + stage_name;

	// maybe we should check for empty and suitable vars here
	for(var i in labels) {
		if (labels[i] != "range") { // range is our exception
			var val = $( "#"+varprefix + '_' + labels[i] ).val();
			if( val == null || val==undefined || val == "") {
				alert("One or more values is not defined. Please check your input.");
				return;
			}
		}
		// check for length_weight and length_fecundity A and B
		if (labels[i].slice(0,7) == "length_" && 
				val != "none exists - constant fecundity" && 
				val != "none exists - constant weight") {
			//if ( labels[i].slice(0,7) == "length_" && val != "none exists - constant fecundity") { 
			var a = $( "#"+varprefix + '_' + labels[i] + "_a" ).val();
			var b = $( "#"+varprefix + '_' + labels[i] + "_b" ).val();
			if (a == null || a==undefined || a == "" || b == null || b==undefined || b == "") {
				alert("Need to define 'A' and 'B' constants for the equation. Please check your input.");
				return;
			}
		}
		// check for range 
		if (labels[i].slice(0,5) == "range" ) {
			var n = $( "#"+varprefix + '_' + labels[i] + "_N" ).val();
			var s = $( "#"+varprefix + '_' + labels[i] + "_S" ).val();
			if (n == null || n==undefined || n == "" || s == null || s==undefined || s == "") {
				alert("Need to define both a Northern and Southern range. Please check your input.");
				return;
			}
		}

	}	

	$("#citation_dialog_info_div").html( "" );
	for(var i in labels) {
		// check for exceptions like range and length_weight
		if (labels[i].slice(0,5) == "range") { 
			var loc_n_id =  $("#"+ varprefix +"_range_N").val();
			var loc_s_id =  $("#"+ varprefix +"_range_S").val();
			tmp ="";
			if (loc_n_id!=undefined && loc_s_id !=undefined) {
				var location_n = getLocationNameFromId( loc_n_id); 
				var location_s = getLocationNameFromId( loc_s_id); 
				tmp += "<div>"+ labels[i] + " N : " + loc_n_id + "(" + location_n + ") </div>";
				tmp += "<div>"+ labels[i] + " S : " + loc_s_id + "(" + location_s + ") </div>";
			}
		} else {
			tmp = "<div>"+ labels[i] + ": " + $( "#"+varprefix + '_' + labels[i] ).val() +"</div>";
		}
		$("#citation_dialog_info_div").append( tmp );
	}
  $( "#citation_dialog" ).data("labels", labels);
  $( "#citation_dialog" ).data("node", node);
  $( "#citation_dialog" ).data("stage_name", stage_name);
  $( "#citation_dialog" ).data("varprefix", varprefix);
	$( "#citation_dialog" ).data("error", ""); 
	var func = Object();
	func[title] = function() { 
		var cite_id = $("#citation_dialog_select").val();
		if (cite_id == null ) {
			alert("You must choose a citation");
			return;
		}
  	var labels = $( "#citation_dialog" ).data("labels");
  	var node = $( "#citation_dialog" ).data("node");
  	var stage_name = $( "#citation_dialog" ).data("stage_name");
  	var varprefix = $( "#citation_dialog" ).data("varprefix");
		//alert("node is:\n" + JSON.stringify(node));
		if (stage_name != null && node.stages[stage_name] == undefined) {
			// THERE IS NO STAGE for this node
			// we need to create a stage for this node
			var postdata =Object();
			postdata.functionName = "addNewStage";
			postdata.stage_name = stage_name;
			postdata.node_id = node.id;
			$.ajax( { async:false,type:"GET", dataType:"json", 
					data: postdata,
					url: "query.php", 
					success: function(data, t, x) { 	
						if (data == null) {
							alert("Return value is null, this usually means a problem on the server.");	
						} else if (data.error == undefined ) {
							log("Created new stage '" +postdata.stage_name + "' for node:" + node.id);
							node.stages[postdata.stage_name] = data[postdata.stage_name];
							//alert("Created new stage, node is now\n" + JSON.stringify(node));
						} else {
							alert(data.error);
						}
					}
			} );
		}
		var f_table='';
		if (stage_name != null) {
			f_table = "stage"; 
			f_id=node.stages[stage_name].id;
		} else { 
			f_table = "node";
			f_id = node.id;
		}
		var objects = Array();
		for ( var l in labels) {
			var obj=	buildCitationObj( cite_id, f_table, f_id, labels[l], varprefix   )
			objects.push(obj);
		}	
		// set the values on them
		var postdata = Object();
		postdata.functionName = "addNewCitedVars";
		postdata.json = objects ;
		//alert("About to set variables:\n" + JSON.stringify(postdata));
		$.ajax( { async:false, type:"GET", dataType:"json",
			data: postdata, 
			url: "query.php", 
			success: function(data, t, x) {	
				if (data == null) {
				  alert("Error : data is null" );
					$( "#citation_dialog" ).data("error", ""); 
				} else if (  data.error != undefined) {
				  $( "#citation_dialog" ).data("error", data.error);
				  alert("Error inserting citation value: " + data.error );
				} else {
					// if there are no errors, everything is okay
					appendCitedVars(data, varprefix);
					// clear the vars too?
					var oldlabels = $( "#citation_dialog" ).data("labels");
					var vpfx = $( "#citation_dialog" ).data("varprefix");
					for (var n in oldlabels) {
						if ( oldlabels[n].slice(0,7) == "length_") {
						 $("#" + vpfx + "_" + oldlabels[n]).val('');
						 $("#" + vpfx + "_" + oldlabels[n] + "_a").val('');
						 $("#" + vpfx + "_" + oldlabels[n] + "_b").val('');
						} else {
						 $("#" + vpfx + "_" + oldlabels[n]).val('');
						}
					}
					//alert(JSON.stringify(oldlabels));
					//alert(JSON.stringify(vpfx));
			  }
		  }
		} );
		if ( $( "#citation_dialog" ).data("error") == "") { 
		  $( this ).dialog( "close" );   
		} else {
			$( "#citation_dialog" ).data("error", "");
		}
	};
	func['Cancel'] = function() { $( this ).dialog( "close" ); };
	$( "#citation_dialog" ).dialog("option","buttons", func );
	$( "#citation_dialog" ).dialog("option","title", title + " for '" + $("#citation_dialog").data("node").working_name + "'" );
	$( "#citation_dialog" ).dialog( "open" );
}



function listAllCitations() {
	$( "#list_all_citations_dialog" ).dialog("option","title", 'List of all Citations' );
	$( "#list_all_citations_dialog" ).html( "retrieving info..." );
	$( "#list_all_citations_dialog" ).dialog( "open" );
	var postdata = Object();
	postdata.functionName = "listAllCitations";
	$("#list_all_citations_dialog").css("background", "#ffffff url('css/ui-anim_basic_16x16.gif') right top no-repeat");
	$.ajax( { async:true, type:"GET", dataType:"json",
		data: postdata, 
		url: "query.php", 
		success: function(data, t, x) {	
			if (data == null || data == undefined) {
			  alert("Error on listAllCitations, no response from server." );
			} else {			
				var tmp="";
				for (var i in data) {
					var a = data[i];
					tmp += a.last_name + "," + a.first_name + "<br>";
					for (var j in a.citations) {
						var c = a.citations[j];
					 	tmp += "&nbsp;&nbsp;&nbsp;" + c.title + " " + c.year + "<br>";
					}
				}	
				$("#list_all_citations_dialog").html( tmp);
				$("#list_all_citations_dialog").css("background", "#ffffff");
			}
		}
	});
}

function openNewCitationDialog() {
	// clear new_citation_dialog
	$( "#new_citation_dialog_authors").html("");
	$( "#new_citation_dialog_authors").data("author_ids", Array() );

	$( "#new_citation_dialog_title").val("");
	$( "#new_citation_dialog_document").val("");
	$( "#new_citation_dialog_year").val("");
	$( "#new_citation_dialog_abstract").val("");
	$( "#new_citation_dialog_format_title").val("");
	$( "#new_citation_dialog_volume").val("");
	$( "#new_citation_dialog_publisher").val("");
	$( "#new_citation_dialog_number").val("");
	$( "#new_citation_dialog_pages").val("");

	$( '#new_citation_dialog' ).dialog( 'open' );

}

</script>
<!-- |||||||||||||||||||||Citations dialog||||||||||||||||||||| 
	you get here from the main menu on top
	this dialogue will allow you to add new citations
-->
<div id="new_citation_dialog">
	  <div class="divpad"><label for="new_citation_dialog_author_search">Author Search: </label>
  	<input type="text"  name="new_citation_dialog_author_search" id="new_citation_dialog_author_search"></input>
		</div>
		
		<div class="divpad">
  		<div id="add_new_author" onclick="openNewAuthorDialog();"  
			style="cursor:pointer;cursor:hand;color:magenta;padding-left:135px;" >Add New Author</div>
		</div>

	  <div class="divpad"><label for="new_citation_dialog_authors">Authors: </label>
  	<div id="new_citation_dialog_authors" style="min-height:30px;display:inline-block;"></div>
		</div>

	  <div class="divpad"><label for="new_citation_dialog_title">Title: </label>
  	<input type="text"  name="new_citation_dialog_title" id="new_citation_dialog_title" ></input>
		</div>

	  <div class="divpad"><label for="new_citation_dialog_document">Document(url or DOI): </label>
  	<input type="text"  name="new_citation_dialog_document" id="new_citation_dialog_document" ></input>
		</div>

	  <div class="divpad"><label for="new_citation_dialog_year">Year: </label>
  	<input type="text"  name="new_citation_dialog_year" id="new_citation_dialog_year" ></input>
		</div>

	  <div class="divpad"><label for="new_citation_dialog_format">Published format: </label>
  	<select class="medium" name="new_citation_dialog_format" id="new_citation_dialog_format" onchange="onFormatSelectChange(this);" >
		</select>
		</div>

		<div class="divpad" id="new_citation_dialog_format_title_div"><label 
			for="new_citation_dialog_format_title" id="new_citation_dialog_format_title_label">Journal title: </label>
  	<input type="text"  name="new_citation_dialog_format_title" id="new_citation_dialog_format_title" ></input>
		</div>

	  <div class="divpad" id="new_citation_dialog_volume_div"><label for="new_citation_dialog_volume">Volume: </label>
  	<input type="text"  name="new_citation_dialog_volume" id="new_citation_dialog_volume" />
		</div>

	  <div class="divpad" id="new_citation_dialog_number_div"><label for="new_citation_dialog_number">Number: </label>
  	<input type="text" class="medium" name="new_citation_dialog_number" id="new_citation_dialog_number" ></input>
		</div>

	  <div class="divpad" id="new_citation_dialog_pages_div"><label for="new_citation_dialog_pages">Pages: </label>
  	<input type="text" class="medium" name="new_citation_dialog_pages" id="new_citation_dialog_pages" ></input>
		</div>

	  <div class="divpad"><label for="new_citation_dialog_abstract">Abstract: </label>
  	<textarea  rows="5"  name="new_citation_dialog_abstract" id="new_citation_dialog_abstract" ></textarea>
		</div>

</div>


<!-- ||||||||||||||||||||| list all citations||||||||||||||||||||| 
	you get here from the main menu on top
	this dialogue will allow you to look at all citations 
-->
<div id="list_all_citations_dialog">
</div>

<script>

		$( "#new_citation_dialog_author_search" ).autocomplete({
			minLength: 3,
			select: function( event, ui) {
				var author_id = ui.item.id;
				makeAuthorCiteSpan(author_id, ui.item.label);
				$(this).val('');
				return false;
			},
			source: makeAutocompleteFunc( "citation_author_search.php" )
		});

		$( "#citation_dialog" ).dialog({
			autoOpen: false,
			height: 300,
			width: 500,
			modal: true,
			buttons: {
				"Set": function() {
						$( this ).dialog( "close" );
				},
				"Close": function() {
					$( this ).dialog( "close" );
				}
			}
		});


		$("#new_citation_dialog_authors").data("author_ids", Array());


		// add the format types to the select input field for new_citation_dialog_format
		for(var i=0;i<display_options.citation_format.length;i++) {
			var tmp = display_options.citation_format[i];
			$("#new_citation_dialog_format").append("<option value='"+ tmp  +"'>"+ tmp +"</option>");
		}	

	// create the dialog window for NEW citations
		$( "#new_citation_dialog" ).dialog({
			autoOpen: false,
			title: "Add New Citation",
			height: 500,
			width: 600,
			modal: true,
			buttons: {
				"Add New Citation": function() {
					 var postdata = Object();
					 postdata.functionName = "addNewCitation";
					 postdata.author_ids = $("#new_citation_dialog_authors").data("author_ids"); 
					 if ( postdata.author_ids==undefined || postdata.author_ids.length == 0) {
							alert("Please enter an Author");
							return;
					 }
					 postdata.title = $("#new_citation_dialog_title").val();
					 postdata.document = $("#new_citation_dialog_document").val();
					 postdata.year = $("#new_citation_dialog_year").val();
					 postdata.abstract = $("#new_citation_dialog_abstract").val();
					 postdata.format = $("#new_citation_dialog_format").val();
					 postdata.format_title = $("#new_citation_dialog_format_title").val();
					 postdata.volume = $("#new_citation_dialog_volume").val();
					 postdata.publisher = $("#new_citation_dialog_publisher").val();
					 postdata.number = $("#new_citation_dialog_number").val();
					 postdata.pages = $("#new_citation_dialog_pages").val();
					 if (postdata.title == "") { alert("Please enter title information."); return;}
					 if (postdata.year == "") { alert("Please enter year."); return;}
					 $.ajax( { async:false, type:"GET", dataType:"json",
		 					data: postdata, 
		 					url: "query.php", 
		 					success: function(data, t, x) {	
								if (data.error == undefined ) {
									//alert(JSON.stringify(data));
									// we should get citation info here just like 
								  var label =  data.title + '\',' +  data.year;
									log("Added new citation:" + label); 
									addCiteToCitationDialogSelect(data);
					   		  $( "#new_citation_dialog").dialog( "close" );
								} else {
									alert(data.error + " - " + data.sql);
								}	
							}
						});
				},
				"Close": function() {
					$( this ).dialog( "close" );
				}
			}
		});


		$( "#list_all_citations_dialog" ).dialog({
			autoOpen: false,
			height: 650,
			width: 780,
			modal: false,
			buttons: {
				"Close": function() {
								$( this ).dialog( "close" );
							}
			}
		});


	
</script>


