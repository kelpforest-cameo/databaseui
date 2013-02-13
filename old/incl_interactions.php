<script>
// callback for deleting an Interaction Observation
// needs the citation ID, as well as interaction_type (trophic, parasitic, etc.) and 
// the interaction ID
// because trophic interaction observations may have multiple locations to an observation
// we also need the location_id
function deleteInteractionObservation( cite_id, interaction_type, interaction_id, location_id, observation_type ) {
	if (!confirm("Delete this "+interaction_type +" interaction observation for id:" +  interaction_id  + 
				" loc_id:"  +  location_id  + "obs_type:" + observation_type +"?") ) {
		return;
	}
 var postdata = Object();
 postdata.functionName = "deleteInteractionObservation";
 postdata.cite_id= cite_id;
 postdata.interaction_type = interaction_type;
 postdata.interaction_id= interaction_id;
 postdata.location_id= location_id;
 postdata.observation_type = observation_type;
 //alert(JSON.stringify(postdata));
 $.ajax( { async:true, type:"GET", dataType:"json",
		 data: postdata, 
		 url: "query.php", 
		 success: function(data, t, x) {	
				if (data == null || data == undefined) {
				  alert("Error : data is null" );
				} else if (  data.error != undefined) {
				  alert("Error deleting citation value: " + data.error );
					alert(data.sql);
				} else {
					 var divname = postdata.interaction_type + "_" + postdata.cite_id + "_" + postdata.interaction_id;		
					 $("#"+divname).remove();
				}
			}
	});	
}



// make a string that consists of a <span> html entity with the interaction
// observation data in it.  This is used in the interaction dialogue to show
// the observations for a particular interaction between node/stage pairs
function makeObservationSpan( cite, obs, interaction_id, interaction_type ){
	var authors = "";
	for (var j=0;j< cite.authors.length;j++) {
		if (j != 0) authors+=",&nbsp;";
		authors+=cite.authors[j].last_name;
	}
	var divname = interaction_type + "_" + obs.cite_id + "_" + interaction_id;
	var tmp = '<div class="divpad" id="'+divname+'">[' + authors + " - " + cite.year + "]";
	tmp += '[<span style="cursor:pointer;cursor:hand;color:magenta;padding:4px;" ';
	tmp += 'onclick="deleteInteractionObservation(' + cite.id + ',\'';
	tmp += interaction_type +'\', '+ interaction_id +', '+ obs.location_id +  ', \''+ obs.observation_type +'\');">X</span>]<br>';
	for(var prop in obs) {
		if(obs.hasOwnProperty(prop)) {
			if ( (prop != 'cite_id' ) && ( prop.slice( prop.length - 14, prop.length) != "interaction_id" ) ) {
				if (prop == "location_id") {
					for (var l in display_options.locations) {
						if ( display_options.locations[l].id == obs.location_id ) {
							tmp+= "&nbsp;&nbsp;location : " +  display_options.locations[l].name  + '<br>';
							break;
						}
					}
				} else {
					if ( obs[prop] == null )
						tmp+= "&nbsp;&nbsp;" + prop.replace(/_/g, '&nbsp;') + ": <br>";
					else
						tmp+= "&nbsp;&nbsp;" + prop.replace(/_/g, '&nbsp;') + ": " +  obs[prop] + '<br>';
				}
			}
		}
	}
	tmp+='</div>';
	return tmp;	
}



function openInteractionsDialog(node1_id, interaction_type, node2_id ) {
	if ( interaction_type == undefined) 
		interaction_type = $("#interactions_dialog_interaction_type").val();

	$( "#add_new_interaction_observation_but").button( "option", "disabled", true );
  $( "#add_new_interaction_but").button( "option", "disabled", true );
					
	$('#interactions_dialog_node1_info').html('');
	$('#interactions_dialog_node1_all_interactions').html('');

	$("#interactions_dialog_interaction_type").val(interaction_type);
	$('#interactions_dialog_interaction_type_info').html('');

	$('#interactions_dialog_node2_info').html('');
	$('#interactions_dialog_node2_all_interactions').html('');


	$('#interactions_dialog').dialog('open');
	if ( (node1_id != undefined) && (node2_id != undefined) ) {
		getNodeInfoForInteraction(1, node1_id);
		getAllInteractionsForNode(1, node1_id );

		getNodeInfoForInteraction(2, node2_id);
		getAllInteractionsForNode(2, node2_id );

		getInteractionInfo();
	}
}

function openNewInteractionObservationDialog() {
	if ( $("#interactions_dialog").data("node1") != undefined && 
			$("#interactions_dialog").data("node2") != undefined ){
		var interaction_type = $("#interactions_dialog_interaction_type").val();
		var title = "Add " + interaction_type.substr(0,1).toUpperCase() + interaction_type.substr(1) + " Interaction Observation";
		$("#new_interaction_observation_dialog_info").html("");
		var  labels = Array();
		if ( interaction_type == "trophic") {
				var tmp = makeValueInputDiv( "location_id", "location id", display_options.locations, "Add separate observations for an interaction observed in multiple regions." ); 
				tmp += makeValueInputDiv( "lethality", "lethatlity", display_options.trophic_interaction_observation_lethality, "<b>Lethal Whole</b> - the entire individual is consumed.<br><b>Lethal Partial</b> - only part of the individual is consumed, but the effect is fatal.<br><b>Nonlethal partial</b> - only part of the individual is consumed and the effect is not lethal."); 
				tmp += makeValueInputDiv( "structures_consumed", "structures consumed", display_options.trophic_interaction_observation_structures_consumed, "<b>Whole organism</b> (default).<br><b>Flesh</b> - e.g., shell is not consumed.<br><b>Frond</b> - e.g. stipe is not consumed</p>"); 
				tmp += makeValueInputDiv( "percentage_consumed", "percentage consumed", null, "fraction of individual consumed"); 
				tmp += makeValueInputDiv( "percentage_diet", "percentage of diet", null, "percentage of predator's diet"); 
				tmp += makeValueInputDiv( "preference", "preference", display_options.trophic_interaction_observation_preference, "<b>None</b> prey is consumed in proportion to its availability in the environment.<br><b>More preferred</b> - prey is consumed in greater proportion than is reflected by its availability in the environment.<br><b>Less preferred</b> - prey is consumed in lower proportion than is reflected by its availability in the environment."); 
				tmp += makeValueInputDiv( "observation_type", "observation type", display_options.trophic_interaction_observation_observation_type, "<b>Field observation</b>.<br><b>Laboratory observation</b> - Observation made in non-field setting.<br><b>Chemical</b> - Stable isotope, fatty acid, etc.<br><b>Gut contents</b>.<br><b>Inferred</b> - Based on similar species.<br><b>Expert opinion</b>.<br><b>Fishery</b> - Caught by humans.<br><b>Nest contents</b>.<br><b>Scat</b>.<br><b>Forensic</b>."); 
				labels = Array( "location_id", "lethality", "structures_consumed", "percentage_consumed","percentage_diet", "preference", "observation_type");
				$("#new_interaction_observation_dialog_info").append(tmp);
				$("#new_interaction_observation_dialog_info #location_id").tipTip();
				$("#new_interaction_observation_dialog_info #lethality").tipTip();
				$("#new_interaction_observation_dialog_info #structures_consumed").tipTip();
				$("#new_interaction_observation_dialog_info #percentage_consumed").tipTip();
				$("#new_interaction_observation_dialog_info #percentage_diet").tipTip();
				$("#new_interaction_observation_dialog_info #preference").tipTip();
				$("#new_interaction_observation_dialog_info #observation_type").tipTip();
		}

		if ( interaction_type == "parasitic") {
				var tmp = makeValueInputDiv( "location_id", "location id", display_options.locations, "Add separate observations for an interaction observed in multiple regions." ); 
				tmp += makeValueInputDiv( "endo_ecto","endo ecto",  display_options.parasitic_interaction_observation_endo_ecto, "<b>Endoparasite</b> - inside body cavity.<br><b>Ecoparasite</b> - on body surface (including oral cavity)"); 
				tmp += makeValueInputDiv( "lethality", "lethality",  
						display_options.parasitic_interaction_observation_lethality, "<b>benign</b> - does not directly cause mortality.<br><b>lethal</b> - directly causes mortality."); 
				tmp += makeValueInputDiv( "prevalence", "prevalence",  null, "<b>Prevalence</b> - % of hosts infected."); 
				tmp += makeValueInputDiv( "intensity", "intensity",  null, "<b>Intensity</b> - #parasites/host"); 
	
				tmp += makeValueInputDiv( "parasite_type", "type",  
						display_options.parasitic_interaction_observation_parasite_type, "<b>Typical parasites/parasitoid</b> - recruit to hosts, but do not multiply on them.  Impact on the host is intensity dependent (e.g., worms in the gut).<br><b>Pathogen</b> -  microbe or microorganism that reproduces in or on the host to cause disease (e.g., virus, bacterium, prion, fungus).<br><b>Castrator</b> - blocks hosts reproduction, partially or completely (e.g.rhizocephalan barnacle, larval trematode).<br><b>Trophically transmitted parasite larva</b> (typical parasites and castrators): cysts in a prey host that become adult parasites in an adult host."); 
				tmp += makeValueInputDiv( "observation_type", "observation type",  
						display_options.parasitic_interaction_observation_observation_type, "<b>Field observation</b>.<br><b>Laboratory observation</b> - Observation made in non-field setting.<br><b>Chemical</b> - Stable isotope, fatty acid, etc.<br><b>Gut contents</b>.<br><b>Inferred</b> - Based on similar species.<br><b>Expert opinion</b>.<br><b>Fishery</b> - Caught by humans.<br><b>Nest contents</b>.<br><b>Scat</b>.<br><b>Forensic</b>."); 
				labels = Array( "location_id", "lethality", "endo_ecto", "prevalence", "intensity", "parasite_type", "observation_type");
				$("#new_interaction_observation_dialog_info").append(tmp);

				$("#new_interaction_observation_dialog_info #location_id").tipTip();
				$("#new_interaction_observation_dialog_info #endo_ecto").tipTip();
				$("#new_interaction_observation_dialog_info #lethality").tipTip();
				$("#new_interaction_observation_dialog_info #prevalence").tipTip();
				$("#new_interaction_observation_dialog_info #intensity").tipTip();
				$("#new_interaction_observation_dialog_info #parasite_type").tipTip();
				$("#new_interaction_observation_dialog_info #observation_type").tipTip();
		}

		if ( interaction_type == "competition") {
				var tmp =makeValueInputDiv( "location_id", "location id",   display_options.locations, "Add separate observations for an interaction observed in multiple regions." ); 
				tmp += makeValueInputDiv( "observation_type", "observation type",    
						display_options.competition_interaction_observation_observation_type, "<b>Field observation</b>.<br><b>Laboratory observation</b> - Observation made in non-field setting.<br><b>Chemical</b> - Stable isotope, fatty acid, etc.<br><b>Gut contents</b>.<br><b>Inferred</b> - Based on similar species.<br><b>Expert opinion</b>.<br><b>Fishery</b> - Caught by humans.<br><b>Nest contents</b>.<br><b>Scat</b>.<br><b>Forensic</b>.");
				tmp += makeValueInputDiv( "competition_type", "competition type",   
						display_options.competition_interaction_observation_competition_type, "<b>Space</b> - indirect competition through removal of available space.<br><b>Interference</b> - direct aggression between individuals"); 
				labels = Array( "location_id", "competition_type", "observation_type");
				$("#new_interaction_observation_dialog_info").append(tmp);

				$("#new_interaction_observation_dialog_info #location_id").tipTip();
				$("#new_interaction_observation_dialog_info #observation_type").tipTip();
				$("#new_interaction_observation_dialog_info #competition_type").tipTip();
		}

		if ( interaction_type == "facilitation") {
				var tmp =makeValueInputDiv( "location_id","location id",  display_options.locations, "Add separate observations for an interaction observed in multiple regions." ); 
				tmp += makeValueInputDiv( "observation_type", "observation type",   
						display_options.facilitation_interaction_observation_observation_type, "<b>Field observation</b>.<br><b>Laboratory observation</b> - Observation made in non-field setting.<br><b>Chemical</b> - Stable isotope, fatty acid, etc.<br><b>Gut contents</b>.<br><b>Inferred</b> - Based on similar species.<br><b>Expert opinion</b>.<br><b>Fishery</b> - Caught by humans.<br><b>Nest contents</b>.<br><b>Scat</b>.<br><b>Forensic</b>."); 
				tmp += makeValueInputDiv( "facilitation_type", "facilitation type",   
						display_options.facilitation_interaction_observation_facilitaton_type, "<b>Habitat</b> - e.g., kelp providing shelter to juvenile fishes.<br><b>Mutualism</b> - both partners profit from interaction.<br><b>Commensalism</b> - one partner profits, the other is unaffected"); 
				labels = Array( "location_id", "facilitation_type", "observation_type");
				$("#new_interaction_observation_dialog_info").append(tmp);

				$("#new_interaction_observation_dialog_info #location_id").tipTip();
				$("#new_interaction_observation_dialog_info #observation_type").tipTip();
				$("#new_interaction_observation_dialog_info #facilitation_type").tipTip();
		}

	
		var func = Object();	
		func[title] = function() { 
			var interaction_id = $("#interactions_dialog").data("interaction_id");
			if ( interaction_id == null || interaction_id == undefined) {
				alert("No interaction id :" + interaction_id);
				return;
			}
			var interaction_type = $("#interactions_dialog_interaction_type").val();
			var cite_id =  $("#new_interaction_observation_dialog_select").val();
			if ( cite_id == null  || cite_id == undefined){
				alert("You need to enter and choose a citation.");
				return;
			}
		/*
			for (var i=0; i <labels.length; i++) {
				var name = labels[i];
				if ( $("#" + name ).val() == '') {
					// some fields will be required, others not	
					if (name != "percentage_consumed") {
						alert( name + " is empty");
						return;
					}
				}
			}
		*/
			var postdata = Object();
			postdata.functionName = "addNewInteractionObservation";
			postdata.cite_id = cite_id;
			postdata.interaction_type = interaction_type;
			postdata.interaction_id = interaction_id;
			for(var i in labels) {
				var l = labels[i];
				postdata[l] = $("#" + l ).val();
			}		
			$.ajax( { async:false, type:"GET", dataType:"json",
					data: postdata, 
					url: "query.php", 
					success: function(data, t, x) {	
						if (data == null) {
							alert("Error on addNewInteractionObservation, no response from server." );
					  } else if (data.error == undefined ) {
							// we have a new  
							getInteractionInfo();
							$("#new_interaction_observation_dialog").dialog("close")
						} else {
							alert("Error on addNewInteractionObservation:" + data.error);
							alert( data.sql);
						}
					}
			});
		
		};	
		func['Cancel'] = function() { $( this ).dialog( "close" ); };
		$('#new_interaction_observation_dialog').dialog('option', 'buttons', func);
		$("#new_interaction_observation_dialog" ).dialog("option","title", title );
		$('#new_interaction_observation_dialog').dialog('open');
	} else {
		alert("You need two nodes to make an observation.");
	}

}

// callback from the interactions dialog that will get 
// the interaction info for the left or right hand side nodes
// called from the two  #interactions_dialog_node*_search autocomplete widgets
// takes either a node_id or an itis_id, but not both;  one must be null
// node_it is returned
function getNodeInfoForInteraction( which, node_id, itis_id ) {
	var id = undefined;
	var postdata = Object();
	postdata.functionName = "getNodeItems";
	if (node_id != null)
		postdata.node_id = node_id;
	if (itis_id != null)
		postdata.itis_id = itis_id;
	$.ajax( { async:false, type:"GET", dataType:"json",
		data: postdata, 
		url: "query.php", 
		success: function(datanode, t, x) {	
		if (datanode.error == undefined ) {
			// set id to be the node.id ;  we need this for searching 
			// scientific names with itis_id 
			id = datanode.id;
			var divname = "interactions_dialog_node"+which +"_info";
			var selectname = "interactions_dialog_node"+which +"_info_stage";
			$( "#interactions_dialog").data( "node"+which, datanode); 
			var tmp="<p><hr></p>";
			tmp += "<p>working name: <big><b>" + datanode.working_name +"</b></big><p>";
			if (datanode.itis_id != -1 ) {
			 tmp += "<p>Itis common name: <span id=\"node"+which+"commonname\">&nbsp; &nbsp; &nbsp;</span><br>";
			 tmp += "Itis latin name: <span id=\"node"+which+"latinname\">&nbsp; &nbsp; &nbsp;</span><br>";
			 tmp+="Itis id: " + datanode.itis_id +"<p>";
			}
			for (var i in display_options.stage_names) {
				var stage_name = display_options.stage_names[i];
				if ( datanode.stages[stage_name] != undefined ) {
				  tmp += "<select id='" + selectname + "'></select>";
					break;
				}
			}
			$("#" +divname).html( tmp );
			// retrieve the itis information
			if (datanode.itis_id != -1 ) {
				getItisCommonNames(datanode.itis_id, "node"+which+"commonname", false );
				getItisScientificName(datanode.itis_id, "node"+which+"latinname", false );
			}
			for (var i in display_options.stage_names) {
				var stage_name = display_options.stage_names[i];
				if ( datanode.stages[stage_name] != undefined ) {
					var tmp2 = '<option value="' + datanode.stages[stage_name].id + '">'+ stage_name +'</option>';
					$( "#" + selectname ).append( tmp2);
				}
			}
			$( "#" + selectname ).bind("change", getInteractionInfo); 
		} else {
		  alert("Error getting info for node interaction dialog");
		}	
	}
	});
	return id;
}


// getAllInteractionsForNode will request all interactions for a given node_id
// it returns an array of interactions with the stage_name of this node, the interaction
// type, the working_name and stage name of the other node with which it interacts
function getAllInteractionsForNode( which, node_id ) {
	$("#interactions_dialog_node"+which +"_all_interactions").empty();
	var postdata = Object();
	postdata.functionName = "getAllInteractionsForNode";
	postdata.node_id = node_id;
	postdata.stage_1_or_2 = which;
	$.ajax( { async:false, type:"GET", dataType:"json",
		data: postdata, 
		url: "query.php", 
		success: function(data, t, x) {	
		if (data.error == undefined ) {
			var tmp='<br><br><div style="color:#333333;"><p>All interactions</p><hr>';
			for(var i=0;i< data.interactions.length;i++) {
				if (which==1) {
				//tmp += JSON.stringify( data.interactions[i])
				tmp += data.interactions[i].stage_name + "&nbsp;";
				tmp += data.interactions[i].interaction_type + "->";
				tmp += data.interactions[i].node_working_name + "/";
				tmp += data.interactions[i].node_stage_name + "<br>";
				}else{
				tmp += data.interactions[i].node_working_name + "/";
				tmp += data.interactions[i].node_stage_name + "&nbsp;";
				tmp += data.interactions[i].interaction_type + "->";
				tmp += data.interactions[i].stage_name + "<br>";
				}
			}
			tmp += "</div>";
			var divname = "interactions_dialog_node"+which +"_all_interactions";
			$("#" + divname).html( tmp );
		} else {
		  alert("Error getting all interactions for node with id="+node_id);
		}	
	}
	});
}


// this function will be called in the interaction dialog window when either of the 
// pull down menus for stage changes or a search for a name is completed.
// calls getInteractionInfo() in query.php which returns the interaction observation
// info for the stages in node1 (left side) and node 2 (right side)
function getInteractionInfo() {
	$( "#add_new_interaction_observation_but").button( "option", "disabled", true );
  $( "#add_new_interaction_but").button( "option", "disabled", true );
					
	if ( $("#interactions_dialog").data("node1") != undefined && 
			$("#interactions_dialog").data("node2") != undefined && 
			$("#interactions_dialog_node1_info_stage").val() != undefined &&
			$("#interactions_dialog_node2_info_stage").val() != undefined
		 ){
		$("#interactions_dialog_interaction_type_info").html('');
		var node1 = $("#interactions_dialog").data("node1") ;
		var node2 = $("#interactions_dialog").data("node2") ;
		var postdata = Object();
		postdata.functionName = "getInteractionInfo";
		postdata.interaction_type = $("#interactions_dialog_interaction_type").val();
		postdata.stage_1_id = $("#interactions_dialog_node1_info_stage").val();
		postdata.stage_2_id = $("#interactions_dialog_node2_info_stage").val();
		//alert(JSON.stringify( postdata) );
		$.ajax( { async:false, type:"GET", dataType:"json",
				data: postdata, 
				url: "query.php", 
				success: function(data, t, x) {	
					if (data.error == undefined ) {
						if (data.id != undefined) {
							// this means we have an interaction for these two stages and this interaction type
						  $("#interactions_dialog").data("interaction_id", data.id);	
							$( "#add_new_interaction_observation_but").button( "option", "disabled", false );
							$( "#add_new_interaction_but").button( "option", "disabled", false );
							$( "#add_new_interaction_but").button( "option", "label", "Remove Interaction" );
							$( "#add_new_interaction_but").unbind("click");
							$( "#add_new_interaction_but").click( deleteInteraction );
						} else {
						  $("#interactions_dialog").data("interaction_id", null);	
							$( "#add_new_interaction_observation_but").button( "option", "disabled", true );
							$( "#add_new_interaction_but").button( "option", "disabled", false );
							$( "#add_new_interaction_but").button( "option", "label", "Add Interaction" );
							$( "#add_new_interaction_but").unbind("click");
							$( "#add_new_interaction_but").click( addNewInteraction );
	
						}
						if (data.observations != undefined && data.observations.length>0) {
							// we have observation info, let's show it in the interactions_dialog_interaction_type_info div
							var tmp = '';
							for ( o in data.observations) {
								var obs = data.observations[o];
							  var cite = getCitationInfo(obs.cite_id);
								tmp += makeObservationSpan( cite, obs, data.id, postdata.interaction_type);	
							}
							$("#interactions_dialog_interaction_type_info").append(tmp);
						} 
					} else {
						alert("Error getting interaction info: " + data.error);
						alert(data.sql);
					}	
				}
			});
	}
}

// post a new interaction for the two node/stage pairs.
function addNewInteraction() {
	var postdata = Object();
	postdata.functionName = "addNewInteraction";
	postdata.interaction_type = $("#interactions_dialog_interaction_type").val();
	postdata.stage_1_id = $("#interactions_dialog_node1_info_stage").val();
	postdata.stage_2_id = $("#interactions_dialog_node2_info_stage").val();
	//alert(JSON.stringify( postdata) );
	$.ajax( { async:false, type:"GET", dataType:"json",
			data: postdata, 
			url: "query.php", 
			success: function(data, t, x) {	
			if (data.error == undefined && data.id != undefined ) {
			log("Added "+ postdata.interaction_type +  " interaction with id=" +  data.id );
			$("#interactions_dialog").data("interaction_id", data.id);	
			$("#add_new_interaction_observation_but").button("option", "disabled", false);
			$("#add_new_interaction_but").button("option", "disabled", false);
			$("#add_new_interaction_but").button("option", "label", "Remove Interaction");
			$("#add_new_interaction_but").unbind("click");
			$("#add_new_interaction_but").click( deleteInteraction);
			} else {
			alert("Error getting interaction info on add: " + data.error);
			alert(data.sql);
			}	
			}
			});
}

// delete an interaction
function deleteInteraction() {
	if (!confirm("Delete this interaction?" ) ) {
		return;
	}
	var postdata = Object();
	postdata.functionName = "deleteInteraction";
	postdata.interaction_type = $("#interactions_dialog_interaction_type").val();
	postdata.interaction_id = $("#interactions_dialog").data("interaction_id");	
	if (postdata.interaction_id == null || postdata.interaction_id == undefined) {
		alert("interaction id is not defined.");
		return;
	}
	postdata.stage_1_id = $("#interactions_dialog_node1_info_stage").val();
	postdata.stage_2_id = $("#interactions_dialog_node2_info_stage").val();

	//alert("delete interaction:" + JSON.stringify(postdata));
	$.ajax( { async:false, type:"GET", dataType:"json",
			data: postdata, 
			url: "query.php", 
			success: function(data, t, x) {	
				//alert("GOT ANSER FROM SERVER interaction:" + JSON.stringify(data));
			 if (data.error == undefined  ) {
			  log("Deleted "+ postdata.interaction_type +  " interaction with id=" +  postdata.interaction_id );
				$("#interactions_dialog_interaction_type_info").html("");	
				$("#interactions_dialog").data("interaction_id", null);	
				$("#add_new_interaction_but").button("option", "disabled", false);
				$("#add_new_interaction_but").button("option", "label", "Add Interaction");
				$("#add_new_interaction_but").unbind("click");
				$("#add_new_interaction_but").click( addNewInteraction);
				$("#add_new_interaction_observation_but").button("option", "disabled", true);
			 } else {
			  alert("Error getting deleted interaction info: " + data.error);
			  alert(data.sql);
			 }	
			}
	});
}


</script>
<!-- |||||||||||||||||||||Interactions dialog||||||||||||||||||||| 
	you get here from the main menu on top
	this dialogue will allow you to search for interactions between
	nodes (species, genus, family, etc) at varying stages of their lives.
-->
<div id="interactions_dialog" title="Node Interactions">
	<table cellpadding="10"><tr>
		<td valign="top" align="left" style="min-width:230px;">
		Node&nbsp;1&nbsp;Search:
		</td>
		<td  width="*" style="min-width:300px;">
		Interaction Type
		</td>
		<td valign="top" align="left" style="min-width:230px;">
		Node&nbsp;2&nbsp;Search:
		</td>
		</tr>
		<tr>
		<td valign="top" >
		<p>working name: &nbsp;<input type="text" class="medium"  name="interactions_dialog_node1_search" id="interactions_dialog_node1_search" /></p>
		<p>ITIS latin name:  <input type="text" class="medium"  name="interactions_dialog_node1_search_science_name" id="interactions_dialog_node1_search_science_name" /></p>
		<div class="divpad" id="interactions_dialog_node1_info"></div>
		<div class="divpad" id="interactions_dialog_node1_all_interactions"></div>
		</td>
		<td valign="top" align="left">
		<!-- these select options won't change so don't bother making them dynamic with javascript -->
		<select id="interactions_dialog_interaction_type">
			<option name="trophic" value="trophic">trophic (1 eats 2)</option>
			<option name="competition" value="competition">competition (1 outcompetes 2)</option>
			<option name="facilitation" value="facilitation">facilitation (1 facilitates 2)</option>
			<option name="parasitic" value="parasitic">parasitic (1 is parasite of 2)</option>
		</select>
		<p>
		<div id="interactions_dialog_interaction_type_info"></div>
		</p>
		<p>
		<button id="add_new_interaction_observation_but">Add Observation</button>
		<button id="add_new_interaction_but">Add Interaction </button>
		</p>
		</td>
		<td valign="top" align="left">
	  <p>working name: &nbsp;<input type="text" class="medium"  name="interactions_dialog_node2_search" id="interactions_dialog_node2_search" /></p>
		<p>ITIS latin name:  <input type="text" class="medium"  name="interactions_dialog_node2_search_science_name" id="interactions_dialog_node2_search_science_name" /></p>
		<div class="divpad" id="interactions_dialog_node2_info"></div>
		<div class="divpad" id="interactions_dialog_node2_all_interactions"></div>
		</td>
  </tr></table>
</div>



<!-- ||||||||||||Interactions Observation dialog||||||||||||||||||||| 
	you get here from the interaction menu, you search for an
	interaction type on the left and right.  If there is an interaction
	set for these two, you can then add interaction observations 
-->

<div id="new_interaction_observation_dialog" title="Add New Observation">
	<div> <label for="new_interaction_observation_dialog_citation">Search Citation :</label>
	<input type="text" id="new_interaction_observation_dialog_citation"></input></div>
	<p>
	<div style="cursor:pointer;cursor:hand;color:magenta;padding-left:135px;" 
			onclick="openNewCitationDialog();">Add New Citation</div>
	</p>

	<p>
	<label for="new_interaction_observation_dialog_select">Citation:</label>
	<select id="new_interaction_observation_dialog_select" style="width:320px;"></select>
	</p>
	<br>
	<div id="new_interaction_observation_dialog_info"></div>
</div>

<script>


		$( "#add_new_interaction_observation_but").button( { disabled: true } );
		$( "#add_new_interaction_observation_but").click( openNewInteractionObservationDialog );
		$( "#add_new_interaction_but").button( { disabled: true, label: "Add Interaction" } );
		$( "#add_new_interaction_but").click( addNewInteraction );

		$( "#interactions_dialog_interaction_type" ).bind("change", getInteractionInfo); 

		$( "#interactions_dialog_node1_search" ).autocomplete({
			minLength: 1,
			select: function( event, ui) {
				var node_id = ui.item.id;
				getNodeInfoForInteraction(1, node_id, null );
				getAllInteractionsForNode(1, node_id );
				getInteractionInfo();
				$(this).val('');
				return false;
			},
			source: makeAutocompleteFunc( "node_search.php" )
		});

		$( "#interactions_dialog_node1_search_science_name" ).autocomplete({
			minLength: 3,
			select: function( event, ui) {
				var itis_id = ui.item.id;
				var node_id  = getNodeInfoForInteraction(1, null, itis_id );
				if (node_id == undefined) {
				  $("#interactions_dialog_node1_all_interactions").empty();
				  var divname = "interactions_dialog_node1_info";
					var tmp ="<p>" + $( "#interactions_dialog_node1_search_science_name" ).val() + " is not found in the database.";
					tmp += '<br>Please <span style="cursor:pointer;cursor:hand;color:magenta;padding:4px;"';
					tmp += ' onclick="add_new_node('+ itis_id +');">create the node</span> or modify your search.</p>';
	
					$("#" +divname).html( tmp );
					$(this).val('');
				} else {
				 getAllInteractionsForNode(1, node_id );
				 getInteractionInfo();
				 $(this).val('');
				}
				return false;
			},
			source: makeAutocompleteFunc( "itis_science_name.php")
		});


		$( "#interactions_dialog_node2_search" ).autocomplete({
			minLength: 1,
			select: function( event, ui) {
				var node_id = ui.item.id;
				getNodeInfoForInteraction(2, node_id, null);
				getAllInteractionsForNode(2, node_id );
				getInteractionInfo();
				$(this).val('');
				return false;
			},
			source: makeAutocompleteFunc( "node_search.php" )
		});


		$( "#interactions_dialog_node2_search_science_name" ).autocomplete({
			minLength: 3,
			select: function( event, ui) {
				var itis_id = ui.item.id;
				var node_id  = getNodeInfoForInteraction(2, null, itis_id );
				if (node_id == undefined) {
				  $("#interactions_dialog_node2_all_interactions").empty();
				  var divname = "interactions_dialog_node2_info";
					var tmp ="<p>" + $( "#interactions_dialog_node2_search_science_name" ).val() + " is not found in the database.";
					tmp += '<br>Please <span style="cursor:pointer;cursor:hand;color:magenta;padding:4px;"';
					tmp += ' onclick="add_new_node('+ itis_id +');">create the node</span> or modify your search.</p>';
					$("#" +divname).html( tmp );
					$(this).val('');
				} else {
				 getAllInteractionsForNode(2, node_id );
				 getInteractionInfo();
				 $(this).val('');
				}
				return false;
			},
			source: makeAutocompleteFunc( "itis_science_name.php")
		});

		$( "#new_interaction_observation_dialog_citation" ).autocomplete({
			minLength: 3,
			select: function( event, ui) {
			  var cite = getCitationInfo( ui.item.id ); 
				$('#new_interaction_observation_dialog_select').children().each(function(i, option){ 
					if (cite.id == $(option).val()) {
						$(option).attr("selected","selected");	
					} 
				});
				$(this).val('');
				return false;
			},
			source: makeAutocompleteFunc( "citation_name.php" )
		});

		$( "#interactions_dialog" ).dialog({
			autoOpen: false,
			height: 450,
			width: 820,
			modal: true,
			buttons: {
				"Close": function() {
								$( this ).dialog( "close" );
							}
			}
		});


		$( "#new_interaction_observation_dialog" ).dialog({
			autoOpen: false,
			height: 400,
			width: 600,
			modal: true,
			buttons: {
				"Close": function() {
								$( this ).dialog( "close" );
							}
			}
		});


</script>
