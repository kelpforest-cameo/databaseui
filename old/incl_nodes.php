<script>
// make a row with an <hr> element.  Currently not used
function makeRowLine() {
	var tmp = '<tr><td>&nbsp;</td></td><td colspan="2"><hr style="color:#d0dcd0;background-color:#d0dcd0;height:1px;border:none;" /></td></tr>'; 
	return tmp;
}

// delete any cited variable whether for stage or node
// cite_id - citation id
// compare_field - field name to be compared for deletions ("node_id" or "stage_id")
// compare_id - the ID number of the node_id or stage_id to be deleted
// table_name - full name of table (node_max_age, stage_residency, etc.)
// example -> deleteCitedVar( 23, "node_id", 43, "node_max_age"); 
function deleteCitedVar( cite_id, compare_field, compare_id, table_name) {
	//if (!confirm("Delete this cited variable for " + table_name  + "?\n" + cite_id +","+ compare_field +","+ compare_id +","+table_name ) ) {
	if (!confirm("Delete this cited variable for " + table_name  + "?" ) ) {
		return;
	}
 var postdata = Object();
 postdata.functionName = "deleteCitations";
 var obj = Object();
 obj['table'] = table_name;
 obj['cite_id'] = cite_id;
 obj[compare_field] = compare_id;
 postdata.json = Array( obj ) ;
 $.ajax( { async:true, type:"GET", dataType:"json",
		 data: postdata, 
		 url: "query.php", 
		 success: function(data, t, x) {	
				if (data == null || data == undefined) {
				  alert("Error : data is null" );
				} else if (  data.error != undefined) {
				  alert("Error deleting citation value: " + data.error );
				} else {
					// everything went okay, we want to remove that one
				  //alert( JSON.stringify( data ));
					for (var i in data) {
					  var d = data[i];	
						log ("Deleted from " + d['table'] + " with citation id:" + d['cite_id']);
					  var spanid="#" + d['table'] + '_'+ d['cite_id'];
					  if ( d['node_id'] != undefined) {
					    spanid += '_' + d['node_id'];
					  } else {
					    spanid += '_' + d['stage_id'];
						}
					  //alert( spanid + "  --> " + $(spanid).html() );
					  $(spanid).remove();
					}
			  }
		  }
		} );
}
// make a string that consists of a <span> html entity with the cited variable
// information in it.  This is used in the node dialogue widget to show variables
// that have already been cited.  Can be used for stage or node variables.
function makeCiteSpan(cite_id, var_text, table_name, id, node_or_stage) {
	var authors="";
	var cite = getCitationInfo(cite_id);
	var field = node_or_stage + "_id";
	if (cite.authors != undefined) {
		for (var j=0;j< cite.authors.length;j++) {
			if (j != 0) authors+=",&nbsp;";
			authors+=cite.authors[j].last_name;
		}
		var spanid = table_name + '_' + cite_id + '_' + id;
		var  tmp = '<span id="' + spanid  +'" class="cited">' +  var_text.replace(/ /g, "&nbsp;")  + '&nbsp;-&nbsp;[' + authors + '&nbsp;-&nbsp;' + cite.year +']';
		tmp +=  '&nbsp;&nbsp;[<span style="cursor:pointer;cursor:hand;color:magenta;padding:4px;" ';
		tmp += 'onclick="deleteCitedVar(' + cite.id + ',\'' +field+'\','+id+',\'' +table_name +'\');">X</span>';
		tmp += ']</span> ';
		return tmp;
	} else {
		return "none";
	}
}
// used in interaction observations.  It makes an input or select widget for entering
// information.  The observations dialogue uses label: input pairs instead of an 
// html <table>.  This could be changed and instead use the same thing as the node
// dialog
function makeValueInputDiv( idname, displayname, options, tooltips ) {
	var tmp ='<div class="divpad"><label for="'+ idname + '">' + displayname.replace(/ /g, "&nbsp;")  + ':  </label>';
	tmp+=makeValueInputS( idname, options, tooltips);
	tmp+='</div>';
	return tmp;
}

// makes a generic input widget 
// idname - html DOM id of select or input 
// options - if null, make <input> widget, else use options array to create a <select> 
// tooltip - what info to display on mouseover
function makeValueInputS( idname, options, tooltip ) {
	var tmp ='';
	if ( options != null  && options != undefined && options.length > 0 ) {
		tmp+='<select  name="'+  idname +'" id="'+ idname +'" class="medium" title="'+ tooltip +'" ><option value=""></option>';
		for (var i=0;i<options.length;i++) {	
			var opt = options[i];
			if (typeof ( opt ) == "object") {
				// this is for display_options.locations and display_options.functional_groups
				// for locations, we want to make the spaces on the front of the names have a
				// mandatory space.  normally, the space doesn't show up in the drop down 
				// list without the &nbsp; in the  <option>
				tmp+='<option value="'+ opt.id +'">'+ opt.name.replace("     ", " &nbsp; ") +'</option>';
			} else {
				tmp+='<option value="'+ opt +'">'+ opt +'</option>';
			}
		}
		tmp+='</select>';
	} else {
		tmp+='<input class="medium" type="text" name="'+ idname +'" id="'+ idname +'" title="'+ tooltip +'" />';
	}
	if (idname == "location_id") 
		tmp+= '<a href="BiogeographicRegions.jpg" target="_new">[map]</a>';
	return tmp;
}

// keydown func for range widgets
function rangeKeydown ( e ) {  
	var keynum;
	var keychar;
	var numcheck;

	if( window.event) { // IE
		keynum = e.keyCode
	} else if(e.which) { // Netscape/Firefox/Opera
		keynum = e.which
	}
	keychar = String.fromCharCode(keynum)
	if( keynum==13 ) {  
		var labels = Array( "range" );
		var title = "Set Range" ;
		var node = $(this).data("node");
		//var id = $(this).attr('id');
		buildCitationDialog( labels, title, node, null); 
	}
}

// bind keydown event to all range inputs
function bindRangeInput( varprefix, node  ) {
	$("#" + varprefix  +"_range_N").data('node', node);
	$("#" + varprefix  +"_range_S").data('node', node);
	$("#" +varprefix +"_range_N").bind('keydown', rangeKeydown); 
	$("#" +varprefix +"_range_S").bind('keydown', rangeKeydown); 
}

// bind generic <input> and <select> widgets to keydown function
// keydown func will open the citation dialog with this widget's
// name and value. 
function bindValueInput( varprefix, label, node, stage_name  ) {
	$("#" +varprefix +"_" + label).data("label", label);
	$("#" +varprefix +"_" + label).data("node", node);
	$("#" +varprefix +"_" + label).data("stage_name", stage_name);
	$("#" +varprefix +"_" + label).bind('keydown', function ( e ) {  
		if(e.which==13) {  
			var label = $(this).data("label");
			var node = $(this).data("node");
			var stage_name = $(this).data("stage_name");
			var labels = Array( label );
			var title = "Set " + label;
			if (stage_name != null) {
				title += " for " + node.working_name +" on '" + stage_name +"'";
				buildCitationDialog( labels, title, node, stage_name); 
			} else {
				title += " for " + node.working_name;
				buildCitationDialog( labels, title, node, null); 
			}
		}  
	});
}

// keydown function for length_weight and length_fecundity
// input widgets. (note: could be combined with above generic
// keydown func)
function l_keydown(e) {
	if(e.which==13) {  
		var label = $(this).data("label");
		var node = $(this).data("node");
		var stage_name = $(this).data("stage_name");
		var labels = Array( label );
		var title = "Set " + label;
		if (stage_name != null) {
			title += " for " + node.working_name +" on '" + stage_name +"'";
			buildCitationDialog( labels, title, node, stage_name); 
		} else {
			title += " for " + node.working_name;
			buildCitationDialog( labels, title, node, null); 
		}
	}  
}
function bindLengthRelationInput( varprefix, label, node, stage_name  ) {
	$("#" +varprefix +"_" + label).data("label", label);
	$("#" +varprefix +"_" + label).data("node", node);
	$("#" +varprefix +"_" + label).data("stage_name", stage_name);
	$("#" +varprefix +"_" + label).bind('keydown', l_keydown); 

	$("#" +varprefix +"_" + label + "_a").data("label", label); 
	$("#" +varprefix +"_" + label + "_a").data("node", node);
	$("#" +varprefix +"_" + label + "_a").data("stage_name", stage_name); 
	$("#" +varprefix +"_" + label + "_a").bind('keydown', l_keydown); 

	$("#" +varprefix +"_" + label + "_b").data("label", label); 
	$("#" +varprefix +"_" + label + "_b").data("node", node); 
	$("#" +varprefix +"_" + label + "_b").data("stage_name", stage_name); 
	$("#" +varprefix +"_" + label + "_b").bind('keydown', l_keydown); 

}

function makeRangeInput( idprefix, tooltip ) {
	var tmp='<div style="padding-bottom:5px;padding-top:0px;">';
	tmp += makeValueInputS( idprefix +"_range_N", display_options.locations, "Northern limits of species occurrence" );
	tmp += ' N <a href="BiogeographicRegions.jpg" target="_new">[map]</a><br>';
	tmp +=  makeValueInputS( idprefix +"_range_S", display_options.locations, "Southern limits of species occurrence");
	tmp += ' S <a href="BiogeographicRegions.jpg" target="_new">[map]</a></div>';

	return tmp;
}
// take an existing <select> Dom object, clear it, and generate a new
// options list based on the options array.  Set the option with "id" to 
// be the one that shows up as selected in the drop down widget 
function makeSelect( selectid, options, id ) {
	$("#" + selectid).empty();
	for ( var g=0; g < options.length; g++) {
		var item = options[g];
		if (item.id == id ) {
			$("#" + selectid).append('<option selected value="'+ item.id +'">'+ item.name +'</option>');
		} else {
			$("#" +selectid).append('<option value="'+ item.id +'">'+ item.name +'</option>');
		}
	}
}


// make a span html element that contains author info
function makeAuthorCiteSpan( author_id, text ) {
	// first check to see if it is there
	var a_ids = $("#new_citation_dialog_authors").data("author_ids");
	for (var i in a_ids) {
		if (a_ids[i] == author_id)
			return;
	}
	var  tmp = '<span id="author_' + author_id  +'" class="cited">[' + text + ']';
	tmp +=  '&nbsp;&nbsp;[<span style="cursor:pointer;cursor:hand;color:magenta;padding:4px;" ';
	tmp += 'onclick="removeAuthorFromCitationDialog(' +  author_id +' );">X</span>';
	tmp += ']</span> ';
	$("#new_citation_dialog_authors").append(tmp);
	//$("#new_citation_dialog_authors").data("author_ids").push(author_id);
	a_ids.push(author_id);
}


// build a string for the already cited variables on a node 
// (shown on right hand side of the node dialog
function makeNodeVarInfo( node, v ) {
	var tmp='';
	var db_table_name = "node_" + v;
	for (var m in node[ "node_"+v ]) {
		var val = node["node_"+v][m];
		if (v == "range") {
			var hmm="";
			if ( val['location_n_id']!=null && val['location_s_id'] !=null) {		
				hmm += "<span>N: " + getLocationNameFromId(val['location_n_id']) + ',  S: ' +
					 getLocationNameFromId( val['location_s_id']) + '</span>';
			}
			tmp += makeCiteSpan(val.cite_id, hmm , db_table_name, node.id, "node");
		} else {
			tmp += makeCiteSpan(val.cite_id, val[v], db_table_name, node.id, "node");
		}
	}
	return tmp;
}

// build a string with a <tr> element that has 3 <td>'s in it.
// left most is the label of the variable (e.g. max age)
// center is the input widget (text or select drop down)
// right is for the already cited variables
function makeNodeVarInfoRow( node, varprefix, v, displayname, options, tooltip ) {
	var tmp = '<tr><td class="rt">' + displayname.replace(/ /g, '&nbsp;') +': </td>';
	tmp += '</td><td valign="top">';
	if (v == "range") {
		tmp += makeRangeInput( varprefix, tooltip  );
	} else {
		tmp += makeValueInputS( varprefix +"_"+v, options, tooltip   );
	}
	tmp += '</td><td valign="top" class="view" id="view_'+varprefix +'_' + v +'">';
	tmp += makeNodeVarInfo(node, v);
	tmp +='</td></tr>'; 
	return tmp;
}

// build a string for the already cited variables on a stage 
// (shown on right hand side of the node dialog
function makeStageVarInfo( node, stage_name, v ) {
	var tmp='';
	var db_table_name = "stage_" + v;
	if ( node.stages[stage_name] != undefined && node.stages[stage_name].id != undefined) {
		for (var m in node.stages[stage_name][ "stage_"+v ]) {
			var val='';
			val =  node.stages[stage_name][ "stage_"+v ][m];
			if ( v.slice(0,7) == "length_" && val[v] != "none exists - constant fecundity"  && val[v] != "none exists - constant weight") {
				var txt = val[v] + " - A:" + val["a"] + " B:" + val["b"];
				tmp += makeCiteSpan(val.cite_id, txt, db_table_name, node.stages[stage_name].id, "stage");
			} else {
				tmp += makeCiteSpan(val.cite_id, val[v], db_table_name, node.stages[stage_name].id, "stage");
			}
		}
	}
	return tmp;
}

// build a string with a <tr> element that has 3 <td>'s in it.
// left most is the label of the variable (e.g. drymass)
// center is the input widget (text or select drop down)
// right is for the already cited variables
function makeStageVarInfoRow( node,stage_name, tabname, v , displayname, options, tooltip) {
	var tmp = '<tr><td class="rt">' + displayname.replace(/ /g, '&nbsp;') +': </td>';
	tmp += '</td><td valign="top">';
	if( v.slice(0,7) == "length_") {
		// we have either a length_weight or length_fecundity
		tmp += makeValueInputS( tabname +"_"+v, options, tooltip   );
		tmp += '<div style="padding-top:4px;">A: <input type="text" id="'+ tabname + "_" + v + '_a" style="width:30px"/>';
		tmp += ' &nbsp; B: <input type="text" id="'+ tabname + "_" + v + '_b" style="width:30px"/></div>'; 
	} else {
		tmp += makeValueInputS( tabname +"_"+v, options, tooltip   );
	}
	tmp += '</td><td valign="top" class="view" id="view_'+tabname +'_' + v +'">';
	tmp += makeStageVarInfo(node, stage_name, v);
	tmp +='</td></tr>'; 
	return tmp;
}

// make an empty row with 3 <td>'s
function makeStageVarInfoRowSpace() {
	var tmp = '<tr><td class="rt">&nbsp;</td>';
	tmp += '</td><td valign="top"><div class="divpad">&nbsp;</div></td>';
	tmp += '<td>&nbsp;</td></tr>'; 
	return tmp;
}


// generate a unique dialog name for a node.  This is used as a DOM id for
// making and finding particular node dialog as well as their internal variable
// widgets. 
function makeDlogName(node) {
	var dlog_name =  node.working_name + node.id + node.itis_id + "dialog";
	dlog_name = dlog_name.replace(/\s/g, "");; // remove white space
	return dlog_name;
}

// build the main dialog widget
function makeNodeDialog (node, force_recreate) { 

	//alert(JSON.stringify( node.stages ) );
	var dlog_name = makeDlogName(node);

	if($("#" + dlog_name).length != 0){
		// dialog already exists, always build new one
		if (force_recreate) {
			$("#" + dlog_name).remove();
		} else {
			$( "#" + dlog_name ).dialog("open");
			return;
		}
	}

	var tmp = '<div id="' + dlog_name + '" >';
	tmp += '<table><tr><td colspan="2">';
	tmp += '<b>ID:</b> '+ node.id + '<br>';
	tmp += '<b>Working Name:</b> '+ node.working_name + '<br>';
	tmp += '<b>Itis ID:</b> '+ node.itis_id + '<br>';
	tmp += '<b>Itis Common Names:</b> <span id="' +dlog_name + '_common_names">   &nbsp;   &nbsp;  &nbsp; </span><br>';
	tmp += '<b>Itis Scientific Name:</b> <span id="' +dlog_name + '_scientific_name">   &nbsp;   &nbsp;  &nbsp;  </span><br>';
	for (var i in display_options.functional_groups) {
		var fg = display_options.functional_groups[i];
		if ( fg.id ==	node.functional_group_id){
			tmp += '<b>Functional Group:</b> '+ fg.name + '<br>';
			break;
		}
	}
	tmp += '<b>Native Status:</b> '+ node.native_status + '<br>';
	tmp += '<b>Is Assemblage:</b> '+ ((node.is_assemblage == 0 ) ? "no":"yes") + '<br>';
	tmp += '</td></tr></table><br>';
	tmp += '</div>';
	$('body').append(tmp);
	if (node.itis_id != undefined && node.itis_id != null) {
		getItisScientificName( node.itis_id, dlog_name + '_scientific_name', false);
		getItisCommonNames( node.itis_id, dlog_name + '_common_names', false);
	}
	$( "#" + dlog_name ).dialog({ width: 800, closeOnEscape: true, 
			buttons: { "Close": function() { $(this).dialog("close"); $("#" + dlog_name).remove(); } } });;

	// keep a pointer to the node object itself
	$( "#" + dlog_name ).data("node", node);


	// now, make the node variables that are already attributed to this node.
	// we append them to the "_right" side table column
	// all id's will start with "view_" 
	var tmp = '<table cellpadding="4" cellspacing="0" style="border-spacing: 20px 0px;" id="table_'+ dlog_name +'" class="sidediv"><tr><td></td><td>Add Cited Value</td><td>Previously Cited Values</td></tr>';
	tmp += makeNodeVarInfoRow(node, dlog_name, "range", "Range", null, "Northern and Southern limits of species occurrence");
	tmp += makeNodeVarInfoRow(node, dlog_name, "reproductive_strategy", "Reproductive strategy", display_options.reproductive_strategy, "<b>Broadcast-Gametes</b> or offspring are released without care.<br><b>Brooder-Offspring</b> are cared for either inside or outside the body for at least part of their development.<br><b>Parental Care</b> - Offspring are cared for after their development." );
	tmp += makeNodeVarInfoRow(node, dlog_name, "max_age", "Max age", null, "Maximum reported age attained by individual (years)");
	tmp += '<tr><td></td><td><p><label class="button" for="'+dlog_name+'_set_node_options_but"/><button id="';
	tmp += dlog_name +'_set_node_options_but">Set Node Values</button></p></td><td></td><tr>';
	tmp += '</table>';
	$("#"+dlog_name).append(tmp);	
	$("#"+dlog_name + "_range_N").tipTip();	
	$("#"+dlog_name + "_range_S").tipTip();	
	$("#"+dlog_name + "_reproductive_strategy").tipTip();	
	$("#"+dlog_name + "_max_age").tipTip();	
	bindValueInput( dlog_name, "max_age", node, null);
	bindValueInput( dlog_name, "reproductive_strategy", node, null);
	bindRangeInput( dlog_name, node);

	$( "#"+dlog_name+"_set_node_options_but").button();
	$( "#"+dlog_name+"_set_node_options_but").click(function() {
			var xabels = Array( "max_age", "reproductive_strategy");
			var labels = Array();
			for (var i in xabels) {
			 	if ( $("#"+ dlog_name + "_" + xabels[i] ).val() != "" ) {
			    labels.push(xabels[i]) ;
				}
			}
			if ( ( $("#"+ dlog_name + "_range_N" ).val() != "" ) && 
				( $("#"+ dlog_name + "_range_S" ).val() != "" ) ) {
				labels.push("range");
			} 

			if (labels.length ==0) { alert("Please enter some values."  ); return;}
			//alert(JSON.stringify(labels));
			buildCitationDialog( labels, "Set Node Values", node, null);
	});

	// Now, make stages
	var stg = dlog_name + "_stages"
	tmp = '<div id="'+ stg +'_div"><hr><div class="thead">Stages</div>';
	tmp += '<p>If the units provided by the citation differ from those required for the entry, ';
	tmp += 'use <a href="http://www.wolframalpha.com/input/?i=unit+converter" target="_new">';
	tmp += 'http://www.wolframalpha.com/</a> to make the conversion first.<br>\n';
	tmp += 'Mouse-over each field to see description and required units.</p></div>\n';
	$("#"+dlog_name).append(tmp);

	$("#" + stg + "_div").append('<div id="'+ stg +'_tabs">\n<ul id="'+ stg +'_tabs_ul"></ul>\n</div>\n');

	//for( var i=0; i < display_options.stage_names.length; i++ ){
	//	var stage_name = display_options.stage_names[i];
	var stagecount=0;
	for( var stage_name in node.stages ) {
		stagecount++;
		var tabname = stg + '_' + stage_name;
		$("#"+ stg + "_tabs_ul").append('<li><a href="#'+ tabname +'">'+ stage_name +'</a></li>\n');
		tmp = '<div id="'+ tabname +'">';
		tmp += '</div>\n';
		$("#" + stg  + "_tabs").append( tmp );

		tmp = '<table cellpadding="4" cellspacing="0"  style="border-spacing: 20px 0px;" id="table_'+ tabname +'" class="sidediv">';
		tmp +='<tr><td></td><td>Add Cited Value</td><td>Previously Cited Values</td></tr>';

		tmp += makeStageVarInfoRow(node, stage_name, tabname, "population", "Percent of Population", null, "Percentage of population 0-100%");
		tmp += makeStageVarInfoRowSpace();

		tmp += makeStageVarInfoRow(node, stage_name, tabname, "length", "Individual Body Length", null, "Average body length (mm)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "mass", "Individual Body Mass", null, "Average total body weight (g)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "drymass", "Individual Body Drymass", null, "Average dry body weight (g)");
		tmp += makeStageVarInfoRowSpace();
		
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "length_weight", "Length(L)-Weight(W)", 
				display_options["stage_length_weight"], "L-Length (mm);   W-Weight (g)" );
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "length_fecundity", "Length(L)-Fecundity(F)", 
				display_options["stage_length_fecundity"], "L-Length (mm);  F-Fecundity (# of offspring)");
		tmp += makeStageVarInfoRowSpace();

		tmp += makeStageVarInfoRow(node, stage_name, tabname, "lifestyle", "Lifestyle", display_options["stage_lifestyle"], 
				"<b>Non-living</b> - e.g. detritus, bedrock, etc.<br><b>Free-living</b> - e.g. plankton, kelp, sea otter, etc.<br><b>Infectious</b> - e.g., parasite, virus, etc." );
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "duration", "Duration", null, 
				"Average duration of stage (days) ('General' stage would be same as Max Age)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "fecundity", "Fecundity", null, 
				"Offspring produced per female individuals per year");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "consumer_strategy", "Consumer strategy", display_options["stage_consumer_strategy"], "<b>Autotroph</b> - Photosynthesizer (e.g. algae).<br><b>Grazer</b> - Benthic consumer of autotrophs (e.g., limpet, herbivorous fishes).<br><b>Filter feeder</b> - Suspension feeder capturing particles from water column (e.g., barnacle).<br><b>Passive sit</b> - Sit & wait predator (e.g., some fishes).<br><b>Active cursorial</b> - Actively foraging/ hunting predator (e.g., sea otter).<br><b>Detritivore</b> - Consumer of algal detritus (e.g., sea cucumber).<br><b>Scavenger</b> - Consumer of dead animal remains (e.g., some crabs)<br><b>Social predator</b> - hunts in packs (e.g. Orca)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "habitat", "Habitat affiliation", display_options["stage_habitat"], "<b>Rocky substrate</b> - Benthic hard rock.<br><b>Soft bottom</b> - Benthic sand, mud, etc.<br><b>Kelp Water column</b> - Non-benthic but within kelpforest.<br><b>Pelagic</b> - Water column outside of kelp forest" );
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "max_depth", "Max depth", null, "Maximum recorded depth of species' occurrence (meters)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "mobility", "Mobility", display_options["stage_mobility"], "<b>Sessile</b> - e.g., barnacle adult.<br><b>Mobile</b> - e.g., sea otter, fish.<br><b>Drifter</b> - e.g., zooplankton, phytoplankton" );
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "residency", "Residency", display_options["stage_residency"], "<b>Resident</b> - permanent resident within nearshore ecosystem.<br><b>Migrant</b> - temporary resident of nearshore ecosystem, spending some time off-shore");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "residency_time", "Residency time", null, "% of year spent in nearshore ecosystem");
		tmp += makeStageVarInfoRowSpace();

		tmp += makeStageVarInfoRow(node, stage_name, tabname, "biomass_density", "Biomass density", null, "Population biomass per square kilometer (kg/km^2)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "prod_biomass_ratio", "Prod/Biomass ratio", null, "biomass produced per unit of initial biomass per year (units: 1/year)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "prod_consum_ratio", "Prod/Consumtion ratio", null, "biomass produced per unit of biomass consumed (unit-less)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "consum_biomass_ratio", "Consumption biomass ratio", null, "prey biomass eaten per unit of predator biomass per year (units: 1/year)");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "unassimilated_consum_ratio", "Unassimilated consumption ratio", null,"");
		tmp += makeStageVarInfoRow(node, stage_name, tabname, "biomass_change", "Biomass change", null, "biomass gained or lost per year (due to fishing, immigration, emigration, etc.) (kg/km^2)" );

		// add the button
		tmp += '<tr><td></td><td><p><label class="button" for="'+ tabname + '_options_but"/><button id="'+ tabname + '_options_but">';
		tmp += 'Set ' + stage_name.substr(0, 1).toUpperCase() + stage_name.substr(1) + ' Values</button></p></td><td></td></tr>';
		tmp += '</table>';

		$("#"+tabname).append(tmp);	
		$("#"+tabname + "_population").tipTip();	
		$("#"+tabname + "_length").tipTip();	
		$("#"+tabname + "_mass").tipTip();	
		$("#"+tabname + "_drymass").tipTip();	
		$("#"+tabname + "_length_weight").tipTip();	
		$("#"+tabname + "_length_fecundity").tipTip();	
		$("#"+tabname + "_lifestyle").tipTip();	
		$("#"+tabname + "_duration").tipTip();	
		$("#"+tabname + "_fecundity").tipTip();	
		$("#"+tabname + "_consumer_strategy").tipTip();	
		$("#"+tabname + "_habitat").tipTip();	
		$("#"+tabname + "_max_depth").tipTip();	
		$("#"+tabname + "_mobility").tipTip();	
		$("#"+tabname + "_residency").tipTip();	
		$("#"+tabname + "_residency_time").tipTip();	
		$("#"+tabname + "_biomass_density").tipTip();	
		$("#"+tabname + "_prod_biomass_ratio").tipTip();	
		$("#"+tabname + "_prod_consum_ratio").tipTip();	
		$("#"+tabname + "_consum_biomass_ratio").tipTip();	
		$("#"+tabname + "_unassimilated_consum_ratio").tipTip();	
		$("#"+tabname + "_biomass_change").tipTip();	

		// bind input widgets
		bindValueInput( tabname, "population", node, stage_name);
		bindValueInput( tabname, "length", node, stage_name);
		bindValueInput( tabname, "mass", node, stage_name);
		bindValueInput( tabname, "drymass", node, stage_name);
		bindLengthRelationInput( tabname, "length_weight", node, stage_name);
		bindLengthRelationInput( tabname, "length_fecundity", node, stage_name);
		bindValueInput( tabname, "lifestyle", node, stage_name);
		bindValueInput( tabname, "duration", node, stage_name);
		bindValueInput( tabname, "fecundity", node, stage_name);
		bindValueInput( tabname, "consumer_strategy", node, stage_name);
		bindValueInput( tabname, "habitat", node, stage_name);
		bindValueInput( tabname, "max_depth", node, stage_name);
		bindValueInput( tabname, "mobility", node, stage_name);
		bindValueInput( tabname, "residency", node, stage_name);
		bindValueInput( tabname, "residency_time", node, stage_name);
		bindValueInput( tabname, "biomass_density", node, stage_name);
		bindValueInput( tabname, "prod_biomass_ratio", node, stage_name);
		bindValueInput( tabname, "consum_biomass_ratio", node, stage_name);
		bindValueInput( tabname, "unassimilated_consum_ratio", node, stage_name);
		bindValueInput( tabname, "biomass_change", node, stage_name);

		// create jquery button
		$("#" +tabname + "_options_but").button();
		$("#" +tabname + "_options_but").data("tabname", tabname);
		$("#" +tabname + "_options_but").data("stage_name", stage_name);
		$("#" +tabname + "_options_but").data("node", node);
		$("#"+ tabname + "_options_but").click(function() {
					var xabels = display_options.stage_vars; 
					var labels = Array();
					var tabname = $(this).data("tabname");
					var node = $(this).data("node");
					var stage_name = $(this).data("stage_name");
					var stage_id = null;
					if ( node.stages[stage_name] != undefined) {
						stage_id = node.stages[stage_name].id;
					}
					var buttontitle = 'Set ' + stage_name.substr(0, 1).toUpperCase() + stage_name.substr(1) + ' Values';
					for (var i =0;i<display_options.stage_vars.length;i++ ) {
						if ( $("#" + tabname + '_'+ xabels[i] ).val() != "" ) {
							labels.push(xabels[i]) ;
					  }
					}	
					//alert("building stage cite with stagename: " + stage_name +"\n"   +JSON.stringify(node));
					buildCitationDialog( labels, buttontitle, node, stage_name);
					});


	}


	// now create the add stage button if this node 
	if (stagecount < display_options.stage_names.length ){
		var tabname = stg + '_addstage';
		$("#"+ stg + "_tabs_ul").append('<li><a href="#'+ tabname +'"> <b>+</b> </a></li>\n');
		tmp = '<div id="'+ tabname +'">';
		tmp += '<p>To add a new stage, select one or more of the following stage types and click "Add New Stages". ';
		tmp += 'To request that a new stage type be added, please contact the project manager.</p>';

		// make radio button inputs for all stages that don't already exist
		for (var i=0;i<display_options.stage_names.length;i++) {
			var addstagename = display_options.stage_names[i];
			if (node.stages[addstagename] == undefined) {
				tmp += '<p><input type="checkbox" value="'+ addstagename +'">' + addstagename +'</input></p>';
			}
		}
		// add the button
		tmp += '<label class="button" for="'+ tabname + '_but"/><button id="'+ tabname + '_but">';
		tmp += 'Add New Stages</button>';
		tmp += '</table>';
		tmp += '</div>\n';
		$("#" + stg  + "_tabs").append( tmp );
		$("#" +tabname + "_but").button();
		$("#" +tabname + "_but").data("node_id", node.id);
		$("#" +tabname + "_but").data("div_id", tabname);
		$("#"+ tabname + "_but").click(function() {
				var node_id = $(this).data("node_id");
				var div_id = $(this).data("div_id");
				var stage_names = new Array();
				$("#" + div_id + " input:checked").each( function(i, item) { 
					stage_names.push( $(item).val() );
					});
				var postdata =Object();
				postdata.functionName = "addNewStages";
				postdata.stage_names = stage_names.join(",");
				postdata.node_id = node_id;
				$.ajax( { async:false,type:"GET", dataType:"json", 
					data: postdata,
					url: "query.php", 
					success: function(data, t, x) { 	
						if (data == null) {
							alert("Return value is null, this usually means a problem on the server.");	
						} else if (data.error == undefined ) {
							// the return data is the full node json
							log("Created new stages '" + postdata.stage_names + "' for node:" + postdata.node_id);
							makeNodeDialog(data, true);
						} else {
							alert(data.error);
						}
					}
			} );
		} );	
	}

	$("#" + stg + "_tabs").tabs();
/*
*/


}



function listAllNodes() {
	$( "#list_all_nodes_dialog" ).dialog("option","title", 'List of all Nodes' );
	$( "#list_all_nodes_dialog" ).html( "retrieving info..." );
	$( "#list_all_nodes_dialog" ).dialog( "open" );
	var postdata = Object();
	postdata.functionName = "listAllNodes";
	$("#list_all_nodes_dialog").css("background", "#ffffff url('css/ui-anim_basic_16x16.gif') right top no-repeat");
	$.ajax( { async:true, type:"GET", dataType:"json",
		data: postdata, 
		url: "query.php", 
		success: function(data, t, x) {	
			if (data == null || data == undefined) {
			  alert("Error on listAllNodes, no response from server." );
			} else {			
				var tmp="";
				for (var i in data) {
					var node_id = data[i].id;
					var working_name = data[i].working_name;
					var interactions1 = data[i].interactions1;
					var interactions2 = data[i].interactions2;
					tmp += '<div><span style="cursor:pointer;cursor:hand;color:blue;padding:4px;"';
					tmp += ' onclick="openNodeDialog('+ node_id +');">';
					tmp += working_name + "</span>";
					tmp += "<br>";
					if (interactions1.length > 0 ) {
						tmp+= '<div style="padding-left:10px;">';
					  for( var j  in interactions1) {
							tmp += working_name + "/" + interactions1[j].stage_name;
							tmp += "->";
							tmp += '<span style="cursor:pointer;cursor:hand;color:blue;padding:4px;"';
							tmp += ' onclick="openInteractionsDialog('+ node_id + ", '" + 
								interactions1[j].interaction_type + "', " +
								interactions1[j].node_id + ");\">";
							tmp += interactions1[j].interaction_type;
							tmp += "</span>->";
							tmp +=	interactions1[j].node_working_name + "/" + interactions1[j].node_stage_name;
							tmp += "<br>";
						}
						tmp+= "</div>";
					}
					if (interactions2.length > 0 ) {
						tmp+= '<div style="padding-left:10px;">';
					  for( var j  in interactions2) {
							tmp +=	interactions2[j].node_working_name + "/" + interactions2[j].node_stage_name;
							tmp += "->";
							tmp += '<span style="cursor:pointer;cursor:hand;color:blue;padding:4px;"';
							tmp += ' onclick="openInteractionsDialog('+ interactions2[j].node_id + ", '" + 
								interactions2[j].interaction_type + "', " +
								node_id + ");\">";
							tmp += interactions2[j].interaction_type;
							tmp += "</span>->";
							tmp += working_name + "/" + interactions2[j].stage_name;
							tmp += "<br>";
						}
						tmp+= "</div>";
					}

					tmp += "</div>";
				}	
			$("#list_all_nodes_dialog").html( tmp);
			$("#list_all_nodes_dialog").css("background", "#ffffff");
			}
		}
	});

}


// this function will open a Node Dialog for a given node id
function openNodeDialog(node_id){
	log("retrieving node items for node with node id:" + node_id);
	$.getJSON( "query.php?functionName=getNodeItems&node_id=" + node_id, getNodeItemsCB);
}


// This is the main node dialog window generator.  After we search via ITIS
// common name, science name, id or our working name, this function is called
function getNodeItemsCB (data) { 
	if (data == null) {
		alert("Error retrieving node information, data from server is null");
		return;
	}
	clearUnderNode(false);
	if (  data.error == undefined ) {
		// save the returned data to our global 'node'
		node = data;

		//$("#working_name").val( node.working_name );

		//if (node.itis_id != null ) { 
		//	$("#itis_id").val( node.itis_id );
	  //	}

		if (data.id==null) { // if node_id is not null lets get the stages
			if (document.getElementById("add_new_node_but") == undefined) {
				$("#nodediv").append('<label for="add_new_node_but"/><button id="add_new_node_but">Add New Node</button>');
				$( "#add_new_node_but").button();
				$( "#add_new_node_but").click(function() { add_new_node(node.itis_id); });
			}
		} else {
			makeNodeDialog(node, false);
		}	
	} else {
		alert( "An Error occurred:" + data.error );
		if ( data.sql != undefined)
			alert( "sql:" + data.sql );
	} 
}

// clear the search input DOM objects and any buttons 
// that may have been created (such as Add New Node)
function clearUnderNode( full ) {
	if (full) {
		$('#itis_common_name').val("" );
		$('#itis_science_name').val("");
		$('#itis_id').val("");
		$('#working_name').val("");
	}
	$('#nodediv').children( "#add_new_node_but"  ).remove().end();
}

function add_new_node( itis_id ) {
	node = new Object();
	node.itis_id = itis_id;
	$("#new_node_dialog_latinname").html(  "&nbsp; &nbsp;" );
	$("#new_node_dialog_commonname").html(  "&nbsp; &nbsp;" );
	$("#new_node_dialog_working_name").val("");
	$( "#new_node_dialog" ).dialog("option","title", 'Add New Node with ITIS id:' + node.itis_id  );
	$( "#new_node_dialog" ).dialog( "open" );
	getItisScientificName( itis_id, "new_node_dialog_latinname", false);
	getItisCommonNames( itis_id, "new_node_dialog_commonname", false);
}

</script>


<!-- ||||||||||||||||| main node dialog||||||||||||||||||||| 
-->
<div id="nodediv" style="width:500px;padding:5px 5px 10px 10px;border:1px solid black;">
	<div class="thead">Node Search</div>
  <div id="working_name_div" class="divpad"><label for="working_name">working name:  </label><input type="text" class="search" name="working_name" id="working_name" 
title="Search for working name in the kelpforest Database."/></div>
  <div id="itis_common_name_div" class="divpad"><label for="itis_common_name">ITIS common name:  </label><input class="search" type="text" name="itis_common_name" id="itis_common_name" title="Search based on the ITIS common name." /></div>
  <div id="itis_science_name_div" class="divpad"><label for="itis_science_name">ITIS latin name:  </label><input class="search" type="text" name="itis_science_name" id="itis_science_name" title="Search based on the ITIS scientific (latin) name." /></div>
  <div id="itis_id_div" class="divpad"><label for="itis_id">ITIS id:  </label><input class="search" type="text" name="itis_id" id="itis_id" title="search based on the numeric ITIS id." /></div>

</div>



<!-- |||||||||||||||||add new cited variables dialog||||||||||||||||||||| 
	you get here from the main node search page 
	you can either enter values into a single input widget and hit RETURN
	Or, you can enter multiple values and click on the button bellow the 
	stage or node info section.

	this dialogue will allow you to add new cited vars for nodes or stages 
-->


<div id="citation_dialog" title="Add to DB">
	<p><label for="citation_dialog_name_search">Search Citations:</label>
	<input type="text" name="name" id="citation_dialog_name_search" />
	</p>
	<p>
	<div style="cursor:pointer;cursor:hand;color:magenta;padding-left:135px;" 
			onclick="openNewCitationDialog();">Add New Citation</div>
	</p>
	<p>
	<label for="citation_dialog_select">Citation:</label>
	<select id="citation_dialog_select" style="width:320px;"></select>
	</p>
	<label for="citation_dialog_info_div">details:</label>
	<div id="citation_dialog_info_div" style="display:inline-block;">
	</div>
</div>

<!-- |||||||||||||||||add new node dialog||||||||||||||||||||| 
	you get here from the main node search page 
	if you search for a node and it is already recorded in our DB,
	the parameters and values for this node will then show up.  If 
	it is NOT in our DB, a button will appear that will allow you to 
	open this "add new node" dialogue.
	this dialogue will allow you to add nodes 
-->

<div id="new_node_dialog" title="Add New Node" >
	<div class="divpad" ><label for="new_node_dialog_latinname">ITIS latin name:</label><div id="new_node_dialog_latinname"></div></div>
	<div class="divpad" ><label for="new_node_dialog_commonname">ITIS common name:</label><div id="new_node_dialog_commonname"></div></div>
	<div class="divpad"><label for="new_node_dialog_working_name">working name:  </label>
  	<input type="text" name="new_node_dialog_working_name" id="new_node_dialog_working_name" title="The working name should represent an easily recognizable synonym for the node.  Most often, this will be the common name (e.g. Latin name: Enhydra lultris, Working name: Sea otter)"/></div>
	<div class="divpad" id="new_node_dialog_functional_group_id_div"><label for="new_node_dialog_functional_group_id">functional group:  </label>
		<select type="text" name="new_node_dialog_functional_group_id" id="new_node_dialog_functional_group_id"></select></div>
	<div class="divpad" id="new_node_dialog_native_div"><label for="new_node_dialog_native_status">native status:  </label>
		<select type="text" name="new_node_dialog_native_status" id="new_node_dialog_native_status" title="Native or Non-Native (introduced, invasive, or non-endemic)">
		<option value="native">native</option><option value="non-native">non-native</option></select></div>
	<div class="divpad" id="new_node_dialog_is_assemblage_div"><label for="new_node_dialog_is_assemblage">is assemblage:  </label>
		<input type="checkbox" name="new_node_dialog_is_assemblage" id="new_node_dialog_is_assemblage" title="Does this node entry represents a node that is identified to the species-specific level." /></div>
</div>
		


<!-- ||||||||||||||||||||| list all nodes dialog||||||||||||||||||||| 
	you get here from the main menu on top
	this dialogue will allow you to look at all nodes 
-->
<div id="list_all_nodes_dialog">
</div>


<script>

$("#itis_id").bind('keydown', function ( e ) {  if(e.which==13) { 
		var itis_id = $("#itis_id").val();
		clearUnderNode(true);
		$("#itis_id").val( itis_id );
		log("retrieving node items for node with itis id:" + itis_id);
		$.getJSON( "query.php?functionName=getNodeItems&itis_id=" + itis_id, getNodeItemsCB);
		getItisCommonNames( itis_id, "itis_common_name", true );
		getItisScientificName( itis_id, "itis_science_name", true );
		}  } );

$( "#itis_science_name" ).autocomplete({
minLength: 3,
	select: function( event, ui) {
		clearUnderNode(true);
		var itis_id = ui.item.id;
		$("#itis_id").val( itis_id );
 		log("retrieving node items for node with itis id:" + itis_id);
		$.getJSON( "query.php?functionName=getNodeItems&itis_id=" + itis_id, getNodeItemsCB);
		getItisCommonNames(itis_id, "itis_common_name", true);
	},
	source: makeAutocompleteFunc( "itis_science_name.php")
});

$( "#itis_common_name" ).autocomplete({
minLength: 3,
select: function( event, ui) {
clearUnderNode(true);
var itis_id = ui.item.id;
$("#itis_id").val( itis_id );
log("retrieving node items for node with itis id:" + itis_id);
$.getJSON( "query.php?functionName=getNodeItems&itis_id=" + itis_id, getNodeItemsCB);
getItisScientificName(ui.item.id, "itis_science_name", true);
},
source: makeAutocompleteFunc( "itis_common_name.php")
});



$( "#working_name" ).autocomplete({
	minLength: 0,
	select: function( event, ui) {
		if (ui.item.id != undefined ) {
			// id is the node_id not itis_id as we could get a non-itis node 
			clearUnderNode(true);	
			var node_id = ui.item.id;
			log("retrieving node items for node with node id:" + node_id);
			$.getJSON( "query.php?functionName=getNodeItems&node_id=" + node_id, getNodeItemsCB);
			$.ajax( { async:false,type:"GET", dataType: "json", url: "query.php?functionName=getItisId&node_id="+node_id, 
				success: function(data, t, x) { 	
					if ( data.itis_id != null) {
					//getItisCommonNames( data.itis_id, "itis_common_name", true );
					//getItisScientificName( data.itis_id, "itis_science_name", true );
					}
				}
			});
		} else {
			alert("error searching for working name: are you logged in?");	
		}
	},
	source: makeAutocompleteFunc( "working_name.php" )
});



$( "#citation_dialog_name_search" ).autocomplete({
			minLength: 3,
			select: function( event, ui) {
			  var cite = getCitationInfo( ui.item.id ); 
				$('#citation_dialog_select').children().each(function(i, option){ 
					if (cite.id == $(option).val()) {
						$(option).attr("selected","selected");	
					} 
				});
				$(this).val('');
				return false;
			},
			source: makeAutocompleteFunc( "citation_name.php" )
		});

// this sets the select drop down for functional groups
		makeSelect( "new_node_dialog_functional_group_id", display_options.functional_groups, null );



		$( "#list_all_nodes_dialog" ).dialog({
			autoOpen: false,
			height: 650,
			width: 520,
			modal: false,
			buttons: {
				"Close": function() {
								$( this ).dialog( "close" );
							}
			}
		});

		$( "#new_node_dialog" ).dialog({
			autoOpen: false,
			height: 300,
			width: 500,
			modal: true,
			buttons: {
			"Add Node": function() {
				var postobj = Object();
				postobj.functionName ="addNewNode";
				postobj.itis_id = node.itis_id;  // node is our global object
				postobj.working_name = $("#new_node_dialog_working_name").val();
				postobj.functional_group_id = $("#new_node_dialog_functional_group_id").val();
				postobj.native_status = $("#new_node_dialog_native_status").val();
				postobj.is_assemblage = 0;
				if ( $("#new_node_dialog_is_assemblage:checked").val() != null )
					postobj.is_assemblage = 1;
				if ($("#new_node_dialog_working_name").val() == "" ) {
					alert("need to submit a working name");
					return;
				}
				$.ajax( { async:false, type:"GET", dataType:"json", 
					data: postobj,
					url: "query.php",
					success: function (data) {
						if (data.error == undefined) {
							 getNodeItemsCB(data);
							 $( "#new_node_dialog" ).dialog( "close" );
						} else {
							alert( data.error );
							if( data.sql !=undefined) alert( data.sql);
						}
						}
					} );
			},
			"Close": function() {
								$( this ).dialog( "close" );
							}
			}
		});

</script>
