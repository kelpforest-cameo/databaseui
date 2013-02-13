<script>	

function openNewNonitisDialog() {
	$('#new_nonitis_dialog').dialog('open');
}


// for non-itis nodes, get tax level
function getTaxonomyLevel( val ) {
	if (val.taxonomy_level != undefined) {
		return;
	} else {
	// we have an itis node, need to get the taxon level
		var p  = Object();
		p.itis_id = val.id;
		$.ajax( { async:false, type:"GET", dataType:"json",
				data: p, 
				url: "itis_taxonomy.php", 
				success: function(data, t, x) {	
				if (data.error == undefined ) {
					val.taxonomy_level= data.taxonomy_level
				} else {
				  alert(data.error);
				}	
			}
		});
	}
}

function resetNonItisTaxSelect( ) {
		$("#new_nonitis_tax_level").html("");
		var tmp ="";
		for (var i=0; i< display_options.non_itis_taxonomy_level.length;i++) {
			var level = display_options.non_itis_taxonomy_level[i];
			tmp+= '<option value="' + level + '">' + level + '</option>';
		}
		$( "#new_nonitis_tax_level").append(tmp);
}

function setNonItisTaxSelect( taxonomy_level ) {
		$("#new_nonitis_tax_level").html("");
		var tl = taxonomy_level;
		var levels = new Array();
		for (var i=0; i< display_options.non_itis_taxonomy_level.length;i++) {
			var tmp = display_options.non_itis_taxonomy_level[i];
			var regex =   new RegExp( tmp, "i");
			if ( tl.search(regex) != -1 ) {
					for (var j=i+1;j< display_options.non_itis_taxonomy_level.length;j++) {
						levels.push( display_options.non_itis_taxonomy_level[j]);
					}
					break;
			}
		}
		var tmp='';
		for (var i in levels ){
			tmp+= '<option value="' + levels[i] + '">' + levels[i] + '</option>';
		}
		$( "#new_nonitis_tax_level").append(tmp);
}
</script>


<!-- |||||||||||||||||add new nonitis node dialog||||||||||||||||||||| 
	you get here from the main menu on top
	this dialogue will allow you to add new nodes that are not already 
	entered in the government sponsored ITIS database.
-->
<div id="new_nonitis_dialog" title="Add New NonItis Node">
		<div><p>Each node (i.e. species) that is not already in the ITIS database receives a Non-ITIS id with which is identified in our local database.  Each Non-ITIS id must point to a valid ITIS id at some higher (parent) taxonomic level.  If your new node's parent is already in ITIS, this will be a simple three-step process: (1) Use the "Parent Search" field to search the ITIS database for the scientific name of the most specific taxonomic name you can identify your new node to. Then (2) manually enter the taxonomic level and the Latin name of your new node.  Then (3) specify (i) a representative "working name" for the nod, (ii) select its functional group, and (iii) check "is assemblage" if the entry does not represent a node that is identified to the species-specific level.</p>
<p>The working name should represent an easily recognizable synonym for the node.  Most often, this will be the common name (e.g. Latin name: Enhydra lultris, Working name: Sea otter).</p>
<p>Note: If you have multiple taxonomic levels that are not already in ITIS, you will need to repeat the above steps several times, starting with the level of the parent that is already in ITIS. From there, work your way down by using the "Parent Search" field to search for the either an ITIS node or Non-ITIS node that represents the next parent.</p>
</div>	<br><br> 

		<div class="divpad" style="padding-left:140px" id="new_nonitis_parent_tree">
		</div>


	  <div class="divpad">
		<label for="new_nonitis_parent_latin_name">Parent Search: </label>
  	<input type="text"   name="new_nonitis_parent_latin_name" id="new_nonitis_parent_latin_name" title="Search for a parent node in both ITIS and local databases."></input>
		</div>

	  <div class="divpad" style="padding-left:140px" id="new_nonitis_parent_info">
		</div>


	  <div class="divpad">
		<label for="new_nonitis_latin_name">Latin Name: </label>
  	<input type="text"  name="new_nonitis_latin_name" id="new_nonitis_latin_name" title="You must enter a latin name for this non-itis node." ></input>
		</div>

	  <div class="divpad">
		<label for="new_nonitis_working_name">Working Name: </label>
  	<input type="text"  name="new_nonitis_working_name" id="new_nonitis_working_name" title="You must enter a working name for this non-itis node."/>
		</div>

	  <div class="divpad">
		<label for="new_nonitis_tax_level">Taxonomic Level: </label>
		<!-- these select options won't change so don't bother making them dynamic with javascript -->
  	<select class="medium"  name="new_nonitis_tax_level" id="new_nonitis_tax_level">
		<option value="phylum">phylum</option>
		<option value="class">class</option>
		<option value="order">order</option>
		<option value="family">family</option>
		<option value="genus">genus</option>
		<option value="species">species</option>
		</select>
		</div>

		<div class="divpad">
		<label for="new_nonitis_functional_group_id">Functional Group: </label>
		<select type="text" class="medium" name="new_nonitis_functional_group_id" id="new_nonitis_functional_group_id" >
		</select>
		</div>

		<div class="divpad">
		<label for="new_nonitis_native_status">Native Status: </label>
		<select type="text" class="medium" name="new_nonitis_native_status" id="new_nonitis_native_status" title="Native or Non-Native (introduced, invasive, or non-endemic)">
		<option value="native">native</option><option value="non-native">non-native</option>
		</select>
		</div>

		<div class="divpad">
		<label for="new_nonitis_is_assemblage">is assemblage:  </label>
		<input type="checkbox" name="new_nonitis_is_assemblage" id="new_nonitis_is_assemblage" title="Does this entry represent a node that is identified to the species-specific level."></input>
		</div>

		<div class="divpad">
		<label for="new_nonitis_info">Extra info: </label>
		<textarea name="new_nonitis_info" id="new_nonitis_info" title="Put any extra relevant info about this non-itis node here."></textarea>
		</div>


</div>

<script>

	
		$( "#new_nonitis_parent_latin_name" ).autocomplete({
			minLength: 3,
			select: function( event, ui) {
			  clearUnderNode(true);
				var val = ui.item.id;
				getTaxonomyLevel( val );
				$("#new_nonitis_parent_info").html( "id: " + val.id + ", is itis:" + val.is_itis + ", taxonomy level: " + val.taxonomy_level );
				setNonItisTaxSelect( val.taxonomy_level);
				$("#new_nonitis_dialog").data("val", val);
			},
			source: makeAutocompleteFunc( "non_itis_search.php")
		});

		makeSelect( "new_nonitis_functional_group_id", display_options.functional_groups, null );

		$( "#new_nonitis_dialog" ).dialog({
			autoOpen: false,
			height: 600,
			width: 700,
			modal: true,
			buttons: {
				"Add New NonItis Node": function() {
					if ( $("#new_nonitis_dialog").data("val") != undefined && $("#new_nonitis_dialog").data("val") != null) {
							var p = new Object();
							p.functionName = "addNewNonItisNode";
							p.parent_id = $("#new_nonitis_dialog").data("val").id;
							p.parent_id_is_itis = $("#new_nonitis_dialog").data("val").is_itis;
							p.latin_name = $("#new_nonitis_latin_name").val();	
							p.working_name = $("#new_nonitis_working_name").val();	
							p.functional_group_id = $("#new_nonitis_functional_group_id").val();	
							p.native_status = $("#new_nonitis_native_status").val();
							p.info = $("#new_nonitis_info").val();
							p.is_assemblage = 0;
							if ( $("#new_nonitis_is_assemblage:checked").val() !=null)	
								p.is_assemblage=1;
							p.taxonomy_level = $("#new_nonitis_tax_level").val();	
							if (p.latin_name == "") { alert("no latin name"); return};
							if (p.working_name =="") { alert("no working name"); return};
							if (p.taxonomy_level =="") { alert("no taxonomy level"); return};
							$.ajax( { async:false, type:"GET", dataType:"json",
								data: p, 
								url: "query.php", 
								success: function(data, t, x) {	
								if (data == null || data == undefined) {
								  alert("Error : data is null" );
								} else if (  data.error != undefined) {
								  alert("Error adding new non-itis node: " + data.error );
								  alert(data.sql);
								} else {
									$("#new_nonitis_parent_info").html("");
									$("#new_nonitis_parent_latin_name").val("");
									$("#new_nonitis_latin_name").val("");
									$("#new_nonitis_working_name").val("");
									$("#new_nonitis_info").val("");
									$("#new_nonitis_dialog").data("val", null);
									resetNonItisTaxSelect();
								}
								}
						  });	
					}else {
						alert("A non-itis node must have a parent");
					}
			  },
				Reset: function() {
							$("#new_nonitis_parent_info").html("");
							$("#new_nonitis_parent_latin_name").val("");
							$("#new_nonitis_latin_name").val("");
							$("#new_nonitis_working_name").val("");
							$("#new_nonitis_info").val("");
							$("#new_nonitis_dialog").data("val", null);
							resetNonItisTaxSelect();
							},
				Close: function() {
								$( this ).dialog( "close" );
							}
			}
		});

</script>
