<?
// first create an error function that will be used by init.php
function error ( $msg ) {
	echo ( "<p>" . $response . "</p>" );	
} 
require_once('init.php');
require_authentication();


?>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" >
<meta http-equiv="content-language" content="EN">
<meta name="Author" content="August Black">
<meta name="Publisher" content="August Black">

<title>FoodWeb Interaction Database</title>

<link type="text/css" href="css/custom-theme/jquery-ui-1.8.6.custom.css" rel="stylesheet" />	
<link type="text/css" href="css/kelpstyle.css" rel="stylesheet" />	
<link type="text/css" href="tiptip/tipTip.css" rel="stylesheet" />	

<script type="text/javascript" src="js/jquery-1.4.4.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.6.custom.min.js"></script>
<script type="text/javascript" src="tiptip/jquery.tipTip.js"></script>
<script type="text/javascript" src="js/json2.js"></script> 
<script type="text/javascript">


// global url
var url = "http://kelpforest.ucsc.edu/";

// we will keep hold of a global citation var
// this will be used to update any citation widget 
// with citation info that has already been used by a user
var citations =  Array();

// use this to log messages in the top div
function log( msg ) {
	$("#logdiv").append( msg + "<br>");
	$("#logdiv").attr({ scrollTop: $("#logdiv").attr("scrollHeight") });
}

// get's the name of the biogeographic location based on id
function getLocationNameFromId( id ) {
	for (var l in display_options.locations) {
		if ( display_options.locations[l].id == id ) {
			return display_options.locations[l].name;
		}
	}
	return undefined;
}

// update a table in the database.  generic function 
// takes field:value array pairs
function updateTable( table_name, id, fields, values ) {
	var postdata = Object();
	postdata.functionName = "updateTable";
	postdata.table_name = table_name;
	postdata.id = id;
	postdata.fields = fields;
	postdata.values = values; 
	$.ajax( { async:false, type:"GET", dataType:"json",
		data: postdata, 
		url: "query.php", 
		success: function(data, t, x) {	
			if (data.error != undefined )
				alert(data.error);
			else {
				log("updated " + postdata.fields + " on " + postdata.table_name);
			}
		}
	});
}

// used in getItisCommonNames 
function getCommonNamesFromDataAsString(data) { 
	valstring='';
	var first = true;
	if (data.return != undefined  && data.return.commonNames != undefined ){
		if (data.return.commonNames instanceof Array) {
			for (var n=0; n < data.return.commonNames.length;n++) {
				if (first) first=false;
				else valstring+=", ";
				valstring +=  data['return']['commonNames'][n]['commonName'];
			}
		} else if ( data.return.commonNames instanceof Object) {
			valstring +=  data.return.commonNames.commonName;
		}
		if (valstring =='')
			return "none";
		else
			return valstring;
	}
}

// use this function to retrieve Itis Common Names from 
// the Itis DB. A node may have more than one name.
//  is_val tells whether or not to set the 
// "val" on the element id or to set the "html"  
function getItisCommonNames( itis_id, element_id, is_val) {
	var retstring = undefined;
	var postdata = Object();
	postdata.functionName = "getCommonNamesFromTSN";
	postdata.tsn= itis_id;
	var div_bg = document.getElementById(element_id).style.background;
	$("#"+element_id).css("background", "#ffffff url('css/ui-anim_basic_16x16.gif') right top no-repeat");
	$.ajax( { async:true, type:"GET", dataType:"json",
		data: postdata, 
		url: "itis.php", 
		success: function(data, t, x) {	
			if (data == null || data == undefined) {
			  alert("Error on getItisCommonNames, no response from server." );
			} else {			
				retstring = getCommonNamesFromDataAsString(data);
				if (is_val)
				  $("#" +element_id).val(retstring);
				else
				  $("#" +element_id).html(retstring);
				$("#" + element_id).css("background", div_bg);
			}
		}
	});
	return retstring;
}

// use this function to retrieve Itis Latin/Scientific Name from 
// the Itis DB. It can only be one name.  
// is_val tells whether or not to set the 
// "val" on the element id or to set the "html" 
function getItisScientificName( itis_id, element_id, is_val ) {
	var retstring = undefined;
	var postdata = Object();
	postdata.functionName = "getScientificNameFromTSN";
	postdata.tsn= itis_id;
	var div_bg = $("#"+element_id).css("background");
	$("#"+element_id).css("background", "#ffffff url('css/ui-anim_basic_16x16.gif') right top no-repeat");
	$.ajax( { async:true, type:"GET", dataType:"json",
		data: postdata, 
		url: "itis.php", 
		success: function(data, t, x) {	
			if (data == null || data == undefined) {
			  alert("Error on getItisScientificName, no response from server." );
			} else {			
				retstring = data.return.combinedName;
				if (is_val)
				 $("#" +element_id).val(retstring);
				else
				 $("#" +element_id).html(retstring);
				$("#" +element_id).css("background", div_bg);
			}
		}
	});
	return retstring;
}


// generic autocomplete function generator
// need this for caching searches.  should save search times
function makeAutocompleteFunc( url ) {
	var cache = {},
			lastXhr;
	
	return function( request, response ) {
		var term = request.term;
		if ( term in cache ) {
			response( cache[ term ] );
			return;
		}
		lastXhr = $.getJSON( url, request, function( data, status, xhr ) {
				cache[ term ] = data;
				if ( xhr === lastXhr ) {
				response( data );
				}
				});
	}
}

//---------------------------ON LOAD FUNCTIONS ------------------------------///
// these are called when the page is loaded
// $(function(){
// });

$.ajax( { async:false,type:"GET", dataType:"json", 
url: "query.php?functionName=getDisplayOptions", 
	success: function(data, t, x) { 	
		display_options = data;
		//alert(JSON.stringify(data.locations));
	}
});

</script>
</head>
<body>
<?
include("header.php");
?>

<div id="tooltipdiv" style="position:absolute;visibility:hidden;padding:15px;border:1px solid black;margin:0px;background-color:#cccccc;"></div>

<!-- ||||||||||||||||| error and message dialog||||||||||||||||||||| -->
<div id="logdiv" style="width:500px;padding:5px 5px 5px 10px;border:1px solid black;margin-bottom:5px;max-height:30px;overflow:auto;color:#cccccc;">Messages and events will be logged here.</div>


<?

include("incl_authors.php");
include("incl_nodes.php");
include("incl_citations.php");
include("incl_interactions.php");
include("incl_nonitisnodes.php");

?>



</body>
</html>


