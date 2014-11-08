<?

function queryRollbackIfFail ( $sql, $user, $table, $field, $id ) {
	global $db;
	// first see if we are allowed to act on this table
	if (!canModify($user, $table, $field, $id )) {
		$db->query("ROLLBACK"); 
		$response['error'] ="No permissions to modify $table with $field : $id";
		$response['sql'] = $sql;
		echo json_encode( $response );	
		exit();
	}

	$result = $db->query( $sql);
	if(DB::isError($result)) {  
		$db->query("ROLLBACK"); 
		$response['error'] = $result->getMessage();
		$response['sql'] = $sql;
		echo json_encode( $response );	
		exit();
	} 
}

function getRectWKT($bbox)
{
	list($left,$bottom,$right,$top) = explode(',',$bbox);
	return "POLYGON(($left $bottom, $left $top, $right $top, $right $bottom, $left $bottom))";
}

function error ( $msg ) {
	$response['error'] = $msg;
	echo json_encode( $response );	
	exit();
} 
include_once("init.php");
//include_once("jsonprint.php");

function canWrite($user) {
	global $db;
	if ($user['can_write']) {
		return true;
	}
	return false;
}

function canModify($user, $table, $field, $id) {
	global $db;
	if ($user['can_modify_others']) {
		//error(" Yes, you can modify it you are superuser" );	
		return true;
	} else {
		// check to see if the table row id is owned by user
		$sql = "SELECT * FROM $table WHERE $field=" . $db->quote($id); 
		$row = $db->getRow( $sql );  
		if(DB::isError($row)) { 
			error( $row->getMessage());
		} else if( empty($row) ) {
			// the row is empty, so the user can't modify it anyway
			return true;
		} else if ( empty($row['owner_id'] )) {
			// there is no owner_id on this table, let's play it safe and 
			// say the user cannot modify this table row
			return false;
		} else {
			if ($row['owner_id'] == $user['id']) {
				//error(" sql=$sql; you are user ". implode(",",$user) . "  ; owner_id=" . $row['owner_id'] . " Yes, you can modify it" );	
				return true;
			} else {
				//error(" sql=$sql; you are user ". implode(",",$user) . "  ; owner_id=" . $row['owner_id'] . " No!" );	
				return false;
			}
		} 
	}
	return false;
}

function getEnumValues($table, $field) {
	global $db;
	$enum_array = array();
	$enum_fields = array();
	$query = 'SHOW COLUMNS FROM `' . $table . '` LIKE "' . $field . '"';
	$q = $db->query($query);
	$row = $q->fetchRow(  ) ;
	//var_dump($row);
	preg_match_all('/\'(.*?)\'/', $row['Type'], $enum_array);
	if(!empty($enum_array[1])) {
		// Shift array keys to match original enumerated index in MySQL (allows for use of index values instead of strings)
		foreach($enum_array[1] as $mkey => $mval) 
			array_push($enum_fields, $mval);
		//$enum_fields["" . $mkey+1] = $mval;
		return $enum_fields;
	}
	else return array(); 
	// Return an empty array to avoid possible errors/warnings if array is passed 
	// to foreach() without first being checked with !empty().
}

function getFunctionalGroups () {
	global $db;
	$sql = "SELECT id, name FROM functional_groups ORDER BY name"; 
	$results = $db->getAll($sql);
	if(DB::isError($results)) { error($results->getMessage(  )); }
	return $results;
}

function getLocations () {
	global $db;
	$sql = "SELECT * FROM locations ORDER BY id"; 
	$results = $db->getAll($sql);
	if(DB::isError($results)) { error($results->getMessage(  )); }
	return $results;
}


function getAuthors($cite_id) {
	global $db;
	$sql = "SELECT authors.last_name, authors.first_name from author_cite ";
	$sql .= " INNER JOIN authors ON authors.id=author_cite.author_id WHERE author_cite.cite_id=" . $db->quote($cite_id);
	$results = $db->getAll($sql);
	if(DB::isError($results)) { error($results->getMessage(  )); }
	return $results;
}

function getValues ( $table, $field, $id, $value) {
	global $db;
	$results = Array( );
	$sql = "SELECT * FROM $table ";
	$sql .= " WHERE $field=" . $db->quote($id) ."  ORDER BY $value";
	$res = $db->getAll($sql);
	if(DB::isError($res)) { error($res->getMessage(  ) . " - " . $sql); }
	return $res;
}

function getCitationInfo ( $cite_id ) {
	global $db;
	$sql = "SELECT * FROM citations  WHERE id=" . $db->quote($cite_id) ;
	$res = $db->getRow($sql);
	if(DB::isError($res)) { error($res->getMessage(  )); }
	if (!empty($res)) {
		$res['authors'] = getAuthors($cite_id);
	}
	return $res;
}
/*
$stage_vars = Array (  "biomass_density", "biomass_change", "consumer_strategy",
"consum_biomass_ratio", "drymass", "duration", "fecundity", "habitat","population",
"length", "length_fecundity", "length_weight" ,"lifestyle", "mass", "max_depth", "mobility", "prod_biomass_ratio",
"prod_consum_ratio", "residency","residency_time", "unassimilated_consum_ratio");
 */

function getStageVars () { 
	global $db;

	$results = $db->getListOf('tables');
	if(DB::isError($results)) { error($results->getMessage(  )); }
	$tmp  =Array();
	if (!empty($results)) {
		foreach( $results as $k => $v ) {
			$sub = substr ( $v , 0 , 6 );
			if ( $sub == "stage_" )
				array_push( $tmp, substr($v, 6, strlen($v)));
		}
	}
	return $tmp;
}

/*
function getStageOld( $stage ) {
	$stage_vars = getStageVars();
	$tmp = Array();
	$stage_name = $stage['name'] ;
	$tmp[ $stage_name ] = Array( 'id'=> $stage['id'], 'node_id' => $stage['node_id'] );
	foreach( $stage_vars as $sv ) {
		// length_weight needs to be handled separately 
		//if ( $sv == "length_fecundity" || $sv == "length_weight" ) {
		//	$values =  getValues("stage_" .$sv, "stage_id", $stage['id'], "equation_type" ) ;
		//} else {
			$values = getValues("stage_".$sv, "stage_id", $stage['id'], $sv ) ;	
		//}
		if (!empty($values) )
			$tmp[$stage_name]['stage_' . $sv] =  $values ;
	}
	return $tmp;
}
 */

function getStage( $stage ) {
	$stage_vars = getStageVars();
	foreach( $stage_vars as $sv ) {
			$values = getValues("stage_".$sv, "stage_id", $stage['id'], $sv ) ;	
		if (!empty($values) )
			$stage['stage_' . $sv] =  $values ;
	}
	return $stage;
}

/*
function getStagesOld( $node_id ) {
	global $db;
	$sql = "SELECT * FROM stages WHERE node_id=$node_id";            // create SQL query
	$results = $db->getAll($sql);
	$tmp = Array();
	if(DB::isError($results)) { error($results->getMessage(  )); }
	if (empty($results)) {
		// always return at least one stage identifier, the "general" stage
		//$results = Array( Array( id=> null, name=> "general", node_id=> null,  ) ); 
	} else {
		// get the rest of the results 
		$tmp = Array();
		for($i=0; $i< count($results); $i++ ) {
			$stage_name = $results[$i]['name'] ;
			$stage = getStage( $results[$i] );
			$tmp[ $stage_name ] = $stage[ $stage_name ] ;
		}
	} 
	// build a full list of stages
	return $tmp;
}
 */

function getStages( $node_id ) {
	global $db;
	$sql = "SELECT * FROM stages WHERE node_id=$node_id";            // create SQL query
	$results = $db->getAll($sql);
	$tmp = Array();
	if(DB::isError($results)) { error($results->getMessage(  )); }
	if (empty($results)) {
		// always return at least one stage identifier, the "general" stage
		//$results = Array( Array( id=> null, name=> "general", node_id=> null,  ) ); 
	} else {
		// get the rest of the results 
		$tmp = Array();
		for($i=0; $i< count($results); $i++ ) {
			$stage = getStage( $results[$i] );
			array_push($tmp,  $stage);
		}
	} 
	// build a full list of stages
	return $tmp;
}


function getNodeItems () {
	global $db;
	$sql = "";
	$itis_id= null;
	if ( !empty( $_REQUEST['itis_id']) ) { 
		$itis_id = $_REQUEST['itis_id']; 
		$sql = "SELECT * FROM nodes WHERE itis_id=$itis_id";            // create SQL query
	} else if ( !empty( $_REQUEST['node_id']) ) {
		$node_id = $_REQUEST['node_id']; 
		$sql = "SELECT * FROM nodes WHERE id=$node_id";            // create SQL query
	} else { 
		error("No itis_id or node_id given.");
	}
	//$result = $db->queryRow($sql);
	$result = $db->getRow($sql);
	if(DB::isError($result)) { error($result->getMessage(  )); }
	if (!empty($result)) {
		$result["node_max_age"] =  getValues("node_max_age", "node_id", $result['id'], "max_age" ) ;
		//$result["node_reproductive_strategy"] =  getValues("node_reproductive_strategy", "node_id", $result['id'], "reproductive_strategy" ) ;
		$result["node_geo_range"] =  getValues("node_geo_range", "node_id", $result['id'], "cite_id") ;
		// stages can be null here
		$result["stages"] =  getStages( $result['id']) ;
		//echo jsonprint( json_encode($result) );
		//echo ( json_encode($result) );
		return $result;
	} else {
		// return empty array if no results
		$result = Array( 'id'=> null, 'itis_id'=> $itis_id, 'non_itis_id'=> null, 'working_name' => null, 
				'functional_group_id' => "1", 'is_assemblage'=>"0" );
		// max_ages => Array( cite_id =>null, max_age=>null, authors=> Array() ), 
		// reproductive_strategy => Array(  cite_id =>null, reproductive_strategy=>null, authors=> Array()   ) );
		return $result;
	}
}


function getAllInteractionsForNode ( $node_id , $stage_1_or_2) {
	global $db;
	$response = Array ( );
	$response['interactions'] = Array();
	if ( isset( $node_id) && isset( $stage_1_or_2) ) { 
		$stage_number = "stage_" . $stage_1_or_2 . "_id";
		$other_stage_number = ($stage_1_or_2 == 1) ? "stage_2_id" : "stage_1_id";
		// first, get the stages for this node
		$sql = "SELECT * FROM stages WHERE node_id=" .  $db->quote( $node_id); 
		$results = $db->getAll($sql);
		if(DB::isError($results)) { $response['error'] = $results->getMessage(  ); $response['sql'] = $sql; break; }

		for($k=0; $k< count($results); $k++ ) {
			// now get the interactions for each of the stages	
			$stage_id = $results[$k]['id'];
			$stage_name = $results[$k]['name'];
			$i_types = Array( "trophic", "competition", "facilitation", "parasitic");
			for( $i=0; $i < count($i_types); $i++) {
				$table =  $i_types[$i] . "_interactions";
				$sql = "SELECT $table.id, stages.name as stage_name, nodes.working_name as node_work_name, nodes.id as node_id from $table ";
				$sql .= " LEFT JOIN (stages,nodes) ON (stages.id=$table.$other_stage_number AND nodes.id=stages.node_id) ";
				$sql .= " WHERE  $stage_number=" . $db->quote( $stage_id );
				$sres = $db->getAll($sql);
				if(DB::isError($sres)) { 
					$response['error'] = $sres->getMessage(  ); 
					$response['sql'] = $sql; 
					break;
				} else {
					// go through our results and ad them to our response
					for($j=0; $j< count($sres); $j++ ) {
						array_push( $response['interactions'] , Array( 'stage_name'=> $stage_name, 
									'interaction_type'=> $i_types[$i], 
									'node_id'=> $sres[$j]['node_id'], 
									'node_working_name'=> $sres[$j]['node_work_name'], 
									'node_stage_name'=> $sres[$j]['stage_name']  ) );
					}
				}
			}
		}
	} else {
		$response['error'] = "No stage_2_id or stage_1_id or interaction_type given. node_id: $node_id, stage_1_or_2: $stage_1_or_2";
	}
	return $response;
}

function addLocationData($location_data)
{
	global $db;
  $lid = null;
	$coords = '';
	if ($location_data['coordinates'] != 'null' && $location_data['coordinates'] != null) {
		$coords = "POINT({$location_data[coordinates][lon]} {$location_data[coordinates][lat]})";
	}

  //Try to reuse existing location data entries
  $sql = "SELECT id FROM location_data WHERE location_id = ?";
  if ($coords != '') {
    $sql .= " AND sdata = GeomFromText(?)";
    $lid = $db->getOne($sql,array($location_data['location_id'],$coords));
  } else {
    $sql .= " AND sdata is null";
  }
  $lid = $db->getOne($sql,array($location_data['location_id']));
  if ($lid != null) {
    $db->query("UPDATE location_data SET refcount = refcount+1 WHERE id = ?",array($lid));
    return $lid;
  }

  //Insert new location data entry
	$r = $db->query("INSERT INTO location_data (location_id, sdata, refcount) VALUES (?,GeomFromText(?),?)",array($location_data['location_id'],$coords,1));
	if (!DB::isError($r)) {
		return $db->getOne("SELECT LAST_INSERT_ID() FROM location_data");
	} else {
		return -1;
	}
}
// ------------- Get params ------------------------------------------------------------//

$functionName="";
if ( !empty( $_REQUEST['functionName']) ) { $functionName = $_REQUEST['functionName']; }
//--------------------------------------------------
// if ( !empty( $_POST['functionName']) ) { $functionName = $_POST['functionName']; }
//-------------------------------------------------- 


//if(!isset($_SESSION['is_logged_in'])) {
if(!is_authenticated()  ) {
	// display login form here
	error("not logged in");
} else {
	// we are logged in, let's roll with it

	$email = $_SESSION['username'];
	$user = $db->getRow( "SELECT * FROM users WHERE email=". $db->quote($email) );  
	if(DB::isError($user)) { 
		error( $user->getMessage()) ;
	} 

	switch ($functionName) {
		case "listAllLocations":
			$result = getLocations();
			echo  json_encode($result);
			break;

		case "listAllCitationsByAuthor":
			$sql = "SELECT * FROM authors ORDER BY last_name"; 
			$results = $db->getAll($sql);
			if(DB::isError($results)) { error($results->getMessage(  )); }
			else {
				for($i=0; $i < count($results); $i++ ) {
					$citations = Array();
					$q1= "SELECT * FROM author_cite WHERE author_id=". $db->quote($results[$i]['id']);
					$r1 = $db->getAll($q1);
					if(DB::isError($r1)) { error($r1->getMessage(  )); }
					for ($j=0; $j < count($r1); $j++ ) {
						$q2= "SELECT id, title, year FROM citations WHERE id=". $db->quote($r1[$j]['cite_id'] . " ORDER BY year");
						$r2 = $db->getAll($q2);
						if(DB::isError($r2)) { error($r2->getMessage(  )); }
						for ($k=0;$k <  count($r2); $k++){
							array_push($citations, $r2[$k]);
						}
					}
					$results[$i]['citations'] = $citations ;
				}
			}
			echo  json_encode($results);
			break;
	
		case "listAllCitations":
			$q2= "SELECT * FROM citations ORDER BY title";
			$citations = Array();
			$r2 = $db->getAll($q2);
			if(DB::isError($r2)) { error($r2->getMessage(  )); }
			for ($k=0;$k <  count($r2); $k++){
				$cite = $r2[$k];
				$cite['authors'] = getAuthors($cite['id']);
				array_push($citations, $cite);
			}
			echo  json_encode($citations);
			break;

		case "setCitationClosed":
			$tmp = "Attempting to set citation open/close: ";
			if (!isset( $_REQUEST['cite_id'] ) ) error( $tmp . "missing cite_id.");
			if (!isset( $_REQUEST['open_or_closed'] ) ) error( $tmp . "missing open_or_closed");
			$response = Array();
			$sql = "UPDATE citations SET ";
			if (  $_REQUEST['open_or_closed'] == "open" ) $sql .=  " closed=0";
			else  $sql .=  " closed=1";
			$sql .= " WHERE id=" . $db->quote( $_REQUEST['cite_id'] );
			$result = $db->query($sql);
			if(DB::isError($result)) { 
				$response['error'] = $result->getMessage();
				$response['sql'] = $sql;
			}
			echo json_encode( $response );
			break;

		case "listAllNodes":
			$sql = "SELECT id,itis_id,working_name FROM nodes ORDER BY working_name"; 
			$results = $db->getAll($sql);
			if(DB::isError($results)) { error($results->getMessage(  )); }
			else {
				//foreach ($results as $r ) {
				for($i=0; $i < count($results); $i++ ) {
					$interactions1 = getAllInteractionsForNode($results[$i]['id'], 1);
					$interactions2 = getAllInteractionsForNode($results[$i]['id'], 2);
					//array_push( $results[$i], Array('interactions1' => $interactions1 ) );
					$results[$i]['interactions1'] = $interactions1['interactions'] ;
					$results[$i]['interactions2'] = $interactions2['interactions'] ;
					//array_push( $results[$i], Array('interactions2' => $interactions2 ) );
				}
			}
			echo  json_encode($results);
			break;
		case "getDisplayOptions":
			$result = Array();
			$result['functional_groups'] = getFunctionalGroups();
			$result['node_native_status'] = getEnumValues("nodes", "native_status");
			$result['non_itis_taxonomy_level'] = getEnumValues("non_itis", "taxonomy_level");
			$result['stage_vars'] = getStageVars();
			$result['stage_reproductive_strategy'] = getEnumValues("stage_reproductive_strategy", "reproductive_strategy");
			$result['stage_names'] = getEnumValues("stages", "name");
			$result['stage_consumer_strategy'] = getEnumValues("stage_consumer_strategy", "consumer_strategy");
			$result['stage_length_weight'] = getEnumValues("stage_length_weight", "length_weight");
			$result['stage_length_fecundity'] = getEnumValues("stage_length_fecundity", "length_fecundity");
			$result['stage_habitat'] = getEnumValues("stage_habitat", "habitat");
			$result['stage_lifestyle'] = getEnumValues("stage_lifestyle", "lifestyle");
			$result['stage_mobility'] = getEnumValues("stage_mobility", "mobility");
			$result['stage_residency'] = getEnumValues("stage_residency", "residency");
			#$result['locations'] = getLocations();
			$result['trophic_interaction_observation_lethality'] = getEnumValues("trophic_interaction_observation", "lethality");
			$result['trophic_interaction_observation_structures_consumed'] = getEnumValues("trophic_interaction_observation", "structures_consumed");
			$result['trophic_interaction_observation_preference'] = getEnumValues("trophic_interaction_observation", "preference");
			$result['trophic_interaction_observation_observation_type'] = getEnumValues("trophic_interaction_observation", "observation_type");
			$result['trophic_interaction_observation_percentage_diet_by'] = getEnumValues("trophic_interaction_observation", "percentage_diet_by");
			$result['competition_interaction_observation_observation_type'] = getEnumValues("competition_interaction_observation", "observation_type");
			$result['competition_interaction_observation_competition_type'] = getEnumValues("competition_interaction_observation", "competition_type");
			$result['facilitation_interaction_observation_observation_type'] = getEnumValues("facilitation_interaction_observation", "observation_type");
			$result['facilitation_interaction_observation_facilitaton_type'] = getEnumValues("facilitation_interaction_observation", "facilitation_type");
			$result['parasitic_interaction_observation_observation_type'] = getEnumValues("parasitic_interaction_observation", "observation_type");
			$result['parasitic_interaction_observation_lethality'] = getEnumValues("parasitic_interaction_observation", "lethality");
			$result['parasitic_interaction_observation_endo_ecto'] = getEnumValues("parasitic_interaction_observation", "endo_ecto");
			$result['parasitic_interaction_observation_parasite_type'] = getEnumValues("parasitic_interaction_observation", "parasite_type");
			//$result['parasitic_interaction_observation_prevalence'] = getEnumValues("parasitic_interaction_observation", "prevalence");
			$result['citation_format'] = getEnumValues("citations", "format");
			echo  json_encode($result);
			//echo jsonprint( json_encode($result));
			break;
		case "getItisId":
			$sql = "";
			if ( !empty( $_REQUEST['node_id']) ) {
				$node_id = $_REQUEST['node_id']; 
				$sql = "SELECT itis_id FROM nodes WHERE id=$node_id";            // create SQL query
			} else { 
				error("No itis_id or node_id given.");
			}
			$result = $db->getRow($sql);
			if(DB::isError($result)) { error($result->getMessage(  )); }
			echo json_encode($result);
			break;
		case "getCitationInfo":
			if ( !empty( $_REQUEST['cite_id']) ) { 
				$cite_id = $_REQUEST['cite_id'];
				$info = getCitationInfo( $cite_id );
				echo json_encode(  $info );
				//echo jsonprint( json_encode( $info ));
			} else {
				error("No cite_id given.");
			}
			break;
		case "getInteractionInfo":
			$response = Array ( );
			if ( isset( $_REQUEST['stage_1_id']) && isset( $_REQUEST['stage_2_id']) && isset( $_REQUEST['interaction_type']) ) { 
				$table =  $_REQUEST['interaction_type'] . "_interactions";
				$sql = "SELECT * from $table WHERE  stage_1_id=" . $db->quote(  $_REQUEST['stage_1_id'] );
				$sql .= " AND stage_2_id=".  $db->quote(  $_REQUEST['stage_2_id'] );
				$result = $db->getRow($sql);
				if(DB::isError($result)) { 
						$response['error'] = $result->getMessage(  ); 
						$response['sql'] = $sql; 
				} else if ( $result['id']) {
					$response['id'] = $result['id'];
					$table = $_REQUEST['interaction_type'] . "_interaction_observation";
					$match = $_REQUEST['interaction_type'] . "_interaction_id";
					$sql = "SELECT * from $table WHERE $match=" . $result['id'];
					$result = $db->getAll($sql);
					if(DB::isError($result)) { 
						$response['error'] = $result->getMessage(  ); 
						$response['sql'] = $sql; 
					} else if ( count( $result ) > 0) {
						$response['observations'] = $result;
					}
				}
			} else {
				$response['error'] = "No stage_2_id or stage_1_id or interaction_type given. 1:" 
					. $_REQUEST['stage_1_id'] . " 2:". $_REQUEST['stage_2_id'] . " int_type:".  $_REQUEST['interaction_type'];
			}
		  echo ( json_encode($response) );
			break;	
		// this will get all the interactions for a given node.  stage_1_or_2 tells
		// whether or not it is the left or right hand side of the interaction.
		// 1 == left; 2 == right; 
		case "getAllInteractionsForNode":
			$response = getAllInteractionsForNode( $_REQUEST['node_id'],  $_REQUEST['stage_1_or_2'] );
		  echo ( json_encode($response) );
			break;	
		case "getStageVars":
			$result = getStageVars();
		  echo ( json_encode($result) );
			break;
		case "getStages":
			if ( empty( $_REQUEST['node_id']) ) error("getStages requires a node_id"); 
			$result = getStages(  $_REQUEST['node_id'] );
		  echo ( json_encode($result) );
			break;

		case "getNodeItems":
			$result = getNodeItems();
		  echo ( json_encode($result) );
			break;
		case "checkItisId":
			$result = Array();
			if (isset( $_REQUEST['itis_id'])  ) {
				$result['itis_id'] = $_REQUEST['itis_id'];
				$sql = "SELECT * FROM nodes WHERE itis_id=" . $_REQUEST['itis_id'] ;
				$res = $db->getRow($sql);
				if(DB::isError($res)) { 
          $result['error'] = $res->getMessage();
        } else if ( count($res) > 0 ) { 
					$result = getNodeItems();
          //$result['error'] = "Already have this ITIS id node in our DB";
				} else {
          $result['notfound'] = 1;
				}
			} else {
				$result['error'] = "Caling function checkItisId without var itis_id defined";
			}
		  echo ( json_encode($result) );
			break;
		case "addNewNodeCheck":
			// we want to check here if there are any nodes with a similar working name
			$result = Array();
			if ( isset( $_REQUEST['working_name']) ) {
				$working_name = $_REQUEST['working_name'];
				$result['similar_items'] = Array();
				$sql = "SELECT id, itis_id, working_name FROM nodes WHERE working_name LIKE " . $db->quote( '%'. $working_name . '%') . " ORDER BY working_name"; 
				$results = $db->getAll($sql);
				if(DB::isError($results)) { error($results->getMessage(  )); }
				foreach( $results as $k => $v ) {
					$r = Array();
					$r["id"] = $v['id'];
					$r["working_name"] = $v['working_name'];
					$r["itis_id"] = $v['itis_id'];
					array_push( $result['similar_items'],  $r);
				}
			} else {
				$result['error'] = "To addNewNodeCheck, you must supply a working_name";
			}
		  echo json_encode( $result );
			break;	
		case "addNewNode":
			$result = Array();
			if (!canWrite($user) ) { error("No permissions to add New Node."); }
			$tmp = "Attempting to insert new node: ";
			if (!isset( $_REQUEST['itis_id'] ) ) error( $tmp . "missing itis_id.");
			if (!isset( $_REQUEST['working_name'] ) ) error( $tmp . "missing working_name.");
			if (!isset( $_REQUEST['native_status'] ) ) error( $tmp . "missing native_status.");
			if (!isset( $_REQUEST['functional_group_id'] ) ) error( $tmp . "missing functional_group_id .");
			if (!isset( $_REQUEST['is_assemblage'] ) ) error( $tmp . "missing is_assemblage .");

			// first, we need to check if there is one with the same itis_id
			$sql = "SELECT * FROM nodes WHERE itis_id=" . $_REQUEST['itis_id'] . " OR working_name=" . $db->quote( $_REQUEST['working_name'] );
			$res = $db->getRow($sql);
			if(DB::isError($res)) { 
				$result['error'] = $res->getMessage();
				$result['sql'] = $sql;
			} else if ( count($res) > 0 ) { 
				$result['error'] = "A node with this itis id ( " .$_REQUEST['itist_id'] ." ) or working name ( ". $_REQUEST['working_name'] . " ) already exists in the database.";
				$result['sql'] = $sql;
			} else {
				$sql = "INSERT into nodes ( itis_id, non_itis_id, working_name, native_status, functional_group_id, owner_id, is_assemblage ) VALUES (";
				$sql .= $db->quote($_REQUEST['itis_id']) . ", ";
				$sql .=  "-1 , ";
				$sql .= $db->quote($_REQUEST['working_name']) . ", ";
				$sql .= $db->quote($_REQUEST['native_status']) . ", ";
				$sql .= $db->quote($_REQUEST['functional_group_id']) . ", ";
				$sql .= $db->quote($user['id']) . ", ";
				$sql .= $db->quote($_REQUEST['is_assemblage']) . ") ";
				$res = $db->query($sql);
				if(DB::isError($res)) { 
					$result['error'] = $res->getMessage();
					$result['sql'] = $sql;
				} else { 
					// always make a general stage
					if (!canWrite($user) ) { error("No permissions to add New Stage."); }
						$node_id= $db->getOne("SELECT * from nodes WHERE id=LAST_INSERT_ID()");
					$sql = "INSERT into stages  ( node_id, name, owner_id) VALUES (";
					$sql .= $db->quote( $node_id ) . ", " . $db->quote("general") . ", ". $db->quote($user['id']) .  ")";
					$result = $db->query($sql);
					if(db::iserror($result)) { 
						$response['error'] = $result->getmessage();
						$response['sql'] = $sql;
					} else {
						$result = getNodeItems();
					}
				}
			}
		  echo json_encode( $result );
			break;
		case "addNewNonItisNodeCheck":
			// we want to check here if there are any nodes with a similar working name
			$result = Array();
			if ( isset( $_REQUEST['working_name']) && isset( $_REQUEST['latin_name']) ) {
				$working_name = $_REQUEST['working_name'];
				$latin_name = $_REQUEST['latin_name'];
				$result['similar_items'] = Array();
				$sql = "SELECT id, itis_id, working_name FROM nodes WHERE working_name LIKE " . $db->quote( '%'. $working_name . '%') . " ORDER BY working_name"; 
				$results = $db->getAll($sql);
				if(DB::isError($results)) { error($results->getMessage(  )); }
				foreach( $results as $k => $v ) {
					$r = Array();
					$r["id"] = $v['id'];
					$r["working_name"] = $v['working_name'];
					$r["itis_id"] = $v['itis_id'];
					array_push( $result['similar_items'],  $r);
				}
				$sql = "SELECT * FROM non_itis WHERE latin_name LIKE " . $db->quote( '%'. $latin_name . '%') . " ORDER BY latin_name"; 
				$results = $db->getAll($sql);
				if(DB::isError($results)) { error($results->getMessage(  )); }
				foreach( $results as $k => $v ) {
					$r = Array();
					$r["id"] = $v['id'];
					$r["latin_name"] = $v['latin_name'];
					$r["parent_id"] = $v['parent_id'];
					$r["parent_id_is_itis"] = $v['parent_id_is_itis'];
					$r["taxonomy_level"] = $v['taxonomy_level'];
					array_push( $result['similar_items'],  $r);
				}

			} else {
				$result['error'] = "To addNewNonItisNodeCheck, you must supply a working_name and latin_name";
			}
		  echo json_encode( $result );
			break;	

		case "addNewNonItisNode":
			$response = Array();
			if (!canWrite($user) ) { 
				error("No permissions to add New NonItis Node."); 
			}
			if ( !isset( $_REQUEST['parent_id']) )  error("addNewNonItisNode: No parent id."); 
			if ( !isset( $_REQUEST['parent_id_is_itis']) )  error("addNewNonItisNode: No parent_id_is_itis. "); 
			if ( !isset( $_REQUEST['latin_name']) )  error("addNewNonItisNode: No latin_name."); 
			if ( !isset( $_REQUEST['taxonomy_level']) )  error("addNewNonItisNode: No taxonomy_level."); 
			if ( !isset( $_REQUEST['working_name']) )  error("addNewNonItisNode: No working_name."); 
			if ( !isset( $_REQUEST['functional_group_id']) )  error("addNewNonItisNode: No functional_group_id."); 
			if ( !isset( $_REQUEST['native_status']) )  error("addNewNonItisNode: No native_status."); 
			if ( !isset( $_REQUEST['is_assemblage']) )  error("addNewNonItisNode: No is_assemblage."); 
			// first, we need to check if there is one with the same itis_id
			$sql = "SELECT * FROM non_itis WHERE latin_name=" . $db->quote( $_REQUEST['latin_name'] );
			$res = $db->getRow($sql);
			if(DB::isError($res)) { 
				$response['error'] = $res->getMessage();
				$response['sql'] = $sql;
			} else if ( count($res) > 0 ) { 
				$response['error'] = "A node with this latin name already exists in the database.";
				$response['sql'] = $sql;
			} else {
				$sql = "INSERT into non_itis ( parent_id, parent_id_is_itis, latin_name, owner_id, info, taxonomy_level ) VALUES (";
				$sql .= $db->quote($_REQUEST['parent_id']) . ", ";
				$sql .= $db->quote($_REQUEST['parent_id_is_itis']) . ", ";
				$sql .= $db->quote($_REQUEST['latin_name']) . ", ";
				$sql .= $db->quote($user['id']) . ", ";
				$sql .= $db->quote($_REQUEST['info']) . ", ";
				$sql .= $db->quote($_REQUEST['taxonomy_level']) . ")";
				$res = $db->query($sql);
				if(DB::isError($res)) { 
					$response['error'] = $res->getMessage();
					$response['sql'] = $sql;
				} else { 
					$non_itis_id= $db->getOne("SELECT * from non_itis WHERE id=LAST_INSERT_ID()");
					if (DB::isError($non_itis_id)) { 
						$response['error'] = $res->getMessage(); 
						$response['sql'] = $sql;
					} else {
						$sql = "INSERT into nodes ( itis_id, non_itis_id, working_name, native_status, functional_group_id, owner_id, is_assemblage ) VALUES (";
						$sql .= $db->quote( -1 ) . ", ";
						$sql .=  $db->quote($non_itis_id) . ", ";;
						$sql .= $db->quote($_REQUEST['working_name']) . ", ";
						$sql .= $db->quote($_REQUEST['native_status']) . ", ";
						$sql .= $db->quote($_REQUEST['functional_group_id']) . ", ";
						$sql .= $db->quote($user['id']) . ", ";
						$sql .= $db->quote($_REQUEST['is_assemblage']) . ") ";
						$res = $db->query($sql);
						if(DB::isError($res)) { 
							$response['error'] = $res->getMessage();
							$response['sql'] = $sql;
						} else { 
							$node_id= $db->getOne("SELECT * from nodes WHERE id=LAST_INSERT_ID()");
							$sql = "INSERT into stages  ( node_id, name, owner_id) VALUES (";
							$sql .= $db->quote( $node_id ) . ", " . $db->quote("general") . ", ". $db->quote($user['id']) .  ")";
							$res = $db->query($sql);
							if(db::iserror($res)) { 
								$response['error'] = $res->getmessage();
								$response['sql'] = $sql;
							} 
							$response['response'] ="alles klar" ;
						}
					} 
				}
			}
			echo json_encode( $response );
			break;

		case "deleteInteraction": 
			$response = Array();
			if ( isset( $_REQUEST['stage_1_id']) && isset( $_REQUEST['stage_2_id']) 
					&& isset( $_REQUEST['interaction_type'])  && isset( $_REQUEST['interaction_id']) ) { 
				$type = $_REQUEST['interaction_type'];
				$table =  $type . "_interactions";
				$interaction_id = $_REQUEST['interaction_id'];

				if (!canModify($user, $table, "id", $interaction_id) ) {
					error("No permissions to modify this entry, $table:$interaction_id");
				} 
				$sql = "DELETE from $table WHERE stage_1_id=" .  $db->quote($_REQUEST['stage_1_id']);
				$sql .= " AND stage_2_id=" . $db->quote( $_REQUEST['stage_2_id'] );
				$sql .= " AND id=" . $db->quote( $interaction_id );
				$result = $db->query($sql);
				if(DB::isError($result)) { 
					$response['error'] = $result->getMessage(); $response['sql'] = $sql;
				} else {
					$response['response'] = "Deleted interaction";
					// now delete all Interaction Observations
					$sql = "DELETE FROM {$type}_interaction_observation WHERE {$type}_interaction_id = ?";
					$result = $db->query($sql,array($interaction_id));
				}
			} else {
				$response['error'] = "No stage_1_id stage_2_id interaction_type or interaction_id";
			}
			echo json_encode( $response );
			break;

		case "deleteInteractionObservation": 
			$response = Array();
			if (!isset( $_REQUEST['cite_id']) ) error("deleteInteractionObservation: Must have a cite_id");
			if (!isset( $_REQUEST['interaction_id']) )  error("deleteInteractionObservation: must have interaction_id");
			if (!isset( $_REQUEST['interaction_type']) ) error("deleteInteractionObservation: must have interaction_type");
			if (!isset( $_REQUEST['location_id']) ) error("deleteInteractionObservation: must have location_id");
			if (!isset( $_REQUEST['observation_type']) )  error("deleteInteractionObservation: must have observation_type");

			$type = $_REQUEST['interaction_type'];
			$interaction_id= $_REQUEST['interaction_id'];
			$table =  $type . "_interaction_observation";
			$idname = $type . "_interaction_id";

	
			if (!canModify($user, $table, $idname, $interaction_id) ) {
				error("No permissions to modify this entry, $table:$idname:$interaction_id");
			}

      $db->query("DELETE FROM location_data WHERE id = ? AND refcount=1",array($_REQUEST['location_id']));
      if ($db->affectedRows() == 0) {
        $db->query("UPDATE location_data SET refcount = refcount-1 WHERE id = ?",array($_REQUEST['location_id']));
      }

			$sql = "DELETE from $table WHERE cite_id=" .  $db->quote($_REQUEST['cite_id']);
			$sql .= " AND location_id=" . $db->quote( $_REQUEST['location_id'] ) ;
			$sql .= " AND observation_type=" . $db->quote( $_REQUEST['observation_type'] ) ;
			$sql .= " AND $idname=" . $db->quote( $_REQUEST['interaction_id'] );
			$result = $db->query($sql);
			if(DB::isError($result)) { 
				$response['error'] = $result->getMessage();
				$response['sql'] = $sql;
			} 
			echo json_encode( $response );
			break;

		case "deleteCitedVar": 
			if ( !isset( $_REQUEST['table']) ) error("you must provide table name in order to delete a cited variable.");
			if ( !isset( $_REQUEST['cite_id']) ) error("you must provide cite_id in order to delete a cited variable.");
			if ( !isset( $_REQUEST['node_id']) AND !isset( $_REQUEST['stage_id']) ) 
				error("you must provide either a node_id or stage_id in order to delete a cited variable.");
			$foreign_ptr="node_id";
			if ( isset( $_REQUEST['stage_id'])) {	$foreign_ptr="stage_id"; }
						
			if (!canModify($user, $_REQUEST['table'], $foreign_ptr, $_REQUEST[$foreign_ptr] )) {
				error("No permissions to modify/delete this cited var" . $_REQUEST['table'] .":". $foreign_ptr .":". $_REQUEST[$foreign_ptr]);
			}

			$response = Array();
			$sql = "DELETE from " .$_REQUEST['table'] . " WHERE cite_id=" .  $db->quote($_REQUEST['cite_id']);
			$sql .= " AND $foreign_ptr=" . $db->quote($_REQUEST[$foreign_ptr]);
			$result = $db->query($sql);
			if(DB::isError($result)) { 
				$response['error'] = $result->getMessage();
				$response['sql'] = $sql;
			} else {
				$response['success'] = $result;
			}	
			echo json_encode( $response );
			break;

		case "deleteStage": 
			$response = Array();
			if (!canWrite($user) ) { 
				error("No permissions to delete a stage."); 
			}
			if ( !isset( $_REQUEST['stage_id']) )  error("deleteStage: no stage_id provided."); 
			$stage_id = $_REQUEST['stage_id'];
			$response['stage_id'] =  $stage_id;
			$stage_vars = getStageVars();

			$result = $db->query("START TRANSACTION");
			if(DB::isError($result)) {  
				error("Couldn't start transaction"); 
			}
			queryRollbackIfFail("DELETE  from stages WHERE stages.id=" .   $db->quote($stage_id ), $user, "stages", "id", $stage_id );
			foreach ($stage_vars as $s) {
				queryRollbackIfFail("DELETE FROM stage_$s  WHERE stage_id=" .   $db->quote($stage_id ), $user, "stage_$s", "stage_id", $stage_id );
			}
			
			$sql = "SELECT * from trophic_interactions WHERE stage_1_id=" .   $db->quote($stage_id ) . " OR stage_2_id=" . $db->quote($stage_id ) ;
			$results = $db->getAll($sql);
			if(DB::isError($results)) { $db->query("ROLLBACK"); error("Couldn't select on trophic_interactions"); }
			for( $k=0; $k < count($results); $k++ ) {
				$id = $results[$k]['id'];
				queryRollbackIfFail( "DELETE from trophic_interactions WHERE id=" .   $db->quote($id ), $user, "trophic_interactions", "id", $id );
				queryRollbackIfFail( "DELETE from trophic_interaction_observation WHERE trophic_interaction_id=" .   $db->quote($id ), 
				$user, "trophic_interaction_observation", "trophic_interaction_id", $id );
			}

			$sql = "SELECT * from parasitic_interactions WHERE stage_1_id=" .   $db->quote($stage_id ) . " OR stage_2_id=" . $db->quote($stage_id ) ;
			$results = $db->getAll($sql);
			if(DB::isError($results)) { $db->query("ROLLBACK"); error("Couldn't select on parasitic_interactions"); }
			for( $k=0; $k < count($results); $k++ ) {
				$id = $results[$k]['id'];
				queryRollbackIfFail( "DELETE from parasitic_interactions WHERE id=" .   $db->quote($id ), $user, "parasitic_interactions", "id", $id );
				queryRollbackIfFail( "DELETE from parasitic_interaction_observation WHERE parasitic_interaction_id=" .   $db->quote($id ),
			 	$user, "parasitic_interaction_observation", "parasitic_interaction_id", $id	);
			}

			$sql = "SELECT * from competition_interactions WHERE stage_1_id=" .   $db->quote($stage_id ) . " OR stage_2_id=" . $db->quote($stage_id ) ;
			$results = $db->getAll($sql);
			if(DB::isError($results)) { $db->query("ROLLBACK"); error("Couldn't select on competition_interactions"); }
			for( $k=0; $k < count($results); $k++ ) {
				$id = $results[$k]['id'];
				queryRollbackIfFail( "DELETE from competition_interactions WHERE id=" .   $db->quote($id ), $user, "competition_interactions", "id", $id );
				queryRollbackIfFail( "DELETE from competition_interaction_observation WHERE competition_interaction_id=" .   $db->quote($id ),
			 	$user, "competition_interaction_observation", "competition_interaction_id", $id	);
			}

			$sql = "SELECT * from facilitation_interactions WHERE stage_1_id=" .   $db->quote($stage_id ) . " OR stage_2_id=" . $db->quote($stage_id ) ;
			$results = $db->getAll($sql);
			if(DB::isError($results)) { $db->query("ROLLBACK"); error("Couldn't select on facilitation_interactions"); }
			for( $k=0; $k < count($results); $k++ ) {
				$id = $results[$k]['id'];
				queryRollbackIfFail( "DELETE from facilitation_interactions WHERE id=" .   $db->quote($id ), $user, "facilitation_interactions", "id", $id );
				queryRollbackIfFail( "DELETE from facilitation_interaction_observation WHERE facilitation_interaction_id=" .   $db->quote($id ),
			 	$user, "facilitation_interaction_observation", "facilitation_interaction_id", $id	);
			}


			$result = $db->query("COMMIT");
			if(DB::isError($result)) { 
				$response['error'] = $result->getMessage();
				$response['sql'] = $sql;
			} 
			echo json_encode( $response );
			break;
		case "addNewCitationCheck":
			// we want to check here if there are any publications with a similar title 
			$result = Array();
			if ( isset( $_REQUEST['title']) ) {
				$title = $_REQUEST['title'];
				$result['similar_items'] = Array();
	
				$sql = "SELECT * FROM citations WHERE title LIKE " . $db->quote( '%'. $title . '%') . 
					" ORDER BY title"; 
				$similar_items = $db->getAll($sql);
				if(DB::isError($similar_items)) { 
					error($similar_items->getMessage(  )); 
				}
				foreach( $similar_items as $k => $v ) {
					$r = Array();
					$r["id"] = $v['id'];
					$r["title"] = $v['title'];
					$r['authors'] = getAuthors($v['id']);
					array_push( $result['similar_items'],  $r);
				}
			} else {
				$result['error'] = "To addNewAuthorCheck, you must supply a first and last name";
			}
		  echo json_encode( $result );
			break;	
	
	
		case "addNewCitation":
			$response = Array();
			if (!canWrite($user) ) { error("No permissions to add New Citation."); }
			if ( !isset( $_REQUEST['author_ids']) || count($_REQUEST['author_ids']) < 1 ) { error("Need at least one author.");}
			if ( !isset( $_REQUEST['title']) || empty( $_REQUEST['title']  ) ) { error("Need at least one title.");}
			if ( !isset( $_REQUEST['year']) || empty(  $_REQUEST['year']  ) ) { error("Need to state the year.");}
			if ( !isset( $_REQUEST['format']) || empty($_REQUEST['format']) ) { error("Need format.");}

			if ( !isset( $_REQUEST['document']) ) { $_REQUEST['document'] = "No document.";}
			if ( !isset( $_REQUEST['abstract']) ) { $_REQUEST['abstract'] = "Need abstract.";}
			$sql = "INSERT into citations (title, document, year, abstract, format, format_title, number, pages, owner_id, publisher, volume) ";
			$sql .= " VALUES (" . $db->quote($_REQUEST['title']);
			$sql .= ", " . $db->quote($_REQUEST['document']);
			$sql .= ", " . $db->quote($_REQUEST['year']);
			$sql .= ", " . $db->quote($_REQUEST['abstract']);
			$sql .= ", " . $db->quote($_REQUEST['format']);
			$sql .= ", " . $db->quote($_REQUEST['format_title']);
			$sql .= ", " . $db->quote($_REQUEST['number']);
			$sql .= ", " . $db->quote($_REQUEST['pages']);
			$sql .= ", " . $db->quote($user['id']);
			$sql .= ", " . $db->quote($_REQUEST['publisher']);
			$sql .= ", " . $db->quote($_REQUEST['volume']);
			$sql .= ")";
			$result = $db->query($sql);
			if(DB::isError($result)) { 
				$response['error'] = $result->getMessage();
				$response['sql'] = $sql;
			}else { 
				$cite_id = $db->getOne( "SELECT LAST_INSERT_ID() from citations" );  
				if (DB::isError($cite_id)) {
					$response['error'] = $cite_id->getMessage();
					$response['sql'] = $sql;
				} else {
					foreach ( $_REQUEST['author_ids'] as $a_id) {
						$sql = "INSERT into author_cite (author_id, owner_id, cite_id) VALUES";
						$sql .=	" (" .$db->quote($a_id) ."," .$db->quote($user['id']) ."," . $db->quote($cite_id) . ")";
						$res = $db->query($sql);
						// we won't worry about errors here
					}
					$response = getCitationInfo( $cite_id );
				}
			}
			echo json_encode(  $response );
			break;
		case "addNewAuthorCheck":
			// we want to check here if there are any authors with a similar working name
			$result = Array();
			if ( isset( $_REQUEST['first_name']) &&  isset( $_REQUEST['last_name'] ) ) {
				$first_name = $_REQUEST['first_name'];
				$last_name = $_REQUEST['last_name'];
				$result['similar_items'] = Array();
	
				$sql = "SELECT id, first_name, last_name FROM authors WHERE first_name LIKE " . $db->quote( '%'. $first_name . '%') . 
					" AND last_name LIKE " . $db->quote( '%'. $last_name . '%') . 
					" ORDER BY last_name"; 

				$similar_items = $db->getAll($sql);
				if(DB::isError($similar_items)) { 
					error($similar_items->getMessage(  )); 
				}
				foreach( $similar_items as $k => $v ) {
					$r = Array();
					$r["id"] = $v['id'];
					$r["first_name"] = $v['first_name'];
					$r["last_name"] = $v['last_name'];
					array_push( $result['similar_items'],  $r);
				}
			} else {
				$result['error'] = "To addNewAuthorCheck, you must supply a first and last name";
			}
		  echo json_encode( $result );
			break;	
	
		case "addNewAuthor":
			$response = Array();
			if (!canWrite($user) ) { error("No permissions to add New Author."); }
			if ( !empty( $_REQUEST['first_name']) && !empty( $_REQUEST['last_name']) ) {
				$first_name = $_REQUEST['first_name'];
				$last_name = $_REQUEST['last_name'];
				$sql = "INSERT into authors (first_name, owner_id, last_name) VALUES (";
				$sql .= $db->quote($first_name) . "," . $db->quote($user['id']) ."," . $db->quote($last_name) ." )";	
				$result = $db->query($sql);
				if(DB::isError($result)) { 
					$response['error'] = $result->getMessage();
					$response['sql'] = $sql;
				}else { 
					$res = $db->getRow( "SELECT * FROM authors WHERE last_name=". $db->quote($last_name) ." AND first_name=" . $db->quote($first_name) );  
					if(DB::isError($res)) { 
						$response['error'] = $res->getMessage();
					} else {
						$response['id'] = $res['id'];
						$response['first_name'] = $res['first_name'];
						$response['last_name'] = $res['last_name'];
					}
				}
			} else {
				$response['error'] = "First or Last name is empty when trying to add new author";
			}
			echo json_encode( $response );
			break;
		case "addNewInteraction":
			$response = Array ( );
			if (!canWrite($user) ) { error("No permissions to add New Interaction."); }
			if ( isset( $_REQUEST['stage_1_id']) && isset( $_REQUEST['stage_2_id']) && isset( $_REQUEST['interaction_type']) ) { 
				$table =  $_REQUEST['interaction_type'] . "_interactions";
				$sql = "INSERT into $table ( stage_1_id, owner_id, stage_2_id) values (";
				$sql .= $db->quote( $_REQUEST['stage_1_id'] ) . ", "  . $db->quote($user['id']) ."," . $db->quote($_REQUEST['stage_2_id']) . ")";
				$result = $db->query($sql);
				if(DB::isError($result)) { 
					$response['error'] = $result->getMessage();
					$response['sql'] = $sql;
				} else { 
					$interaction = $db->getRow( "SELECT * from $table WHERE id=LAST_INSERT_ID()" );
					if(DB::isError($interaction)) { 
						$response['error'] = $result->getMessage();
						$response['sql'] = $sql;
					}else {
						$response = $interaction;
					}
				}	
			} else {
				$response['error'] = "Need stage_1_id, stage_2_id, and interaction_type.";
			}	
			echo json_encode( $response );
			break;
	
		case "addNewInteractionObservation":
			
			$response = Array ( );
			if (!canWrite($user) ) { error("No permissions to add New Interaction Observation."); }
			if ( !isset( $_REQUEST['cite_id']) ) { error("Need a citation id"); }
			if ( !isset( $_REQUEST['interaction_type'] ) ) {  error("Need an interaction type"); }
			if ( !isset( $_REQUEST['location_data'] ) ) {  error("Need a location_id"); }
			//--------------------------------------------------
			// if ( !isset( $_REQUEST['location_id'] ) ) {  error("Need a location_id"); }
			//-------------------------------------------------- 
			$location_id = addLocationData($_REQUEST['location_data']);

			$type = $_REQUEST['interaction_type'];
			$table =  $type . "_interaction_observation";
			$sql = "INSERT into $table  ";
			switch ($type) {
			case "trophic":
				$sql .= "( cite_id, owner_id, trophic_interaction_id, location_id, lethality,";
				$sql .= "structures_consumed,percentage_consumed, percentage_diet, percentage_diet_by, ";
				$sql .= "preference, observation_type, comment, datum) ";
				$sql .= " VALUES ( ". $db->quote( $_REQUEST['cite_id'] ) . ",";
				$sql .=  $db->quote( $user['id']) . ",";
				$sql .=  $db->quote( $_REQUEST['interaction_id'] ) . ",";
				//--------------------------------------------------
				// $sql .=  $db->quote( $_REQUEST['location_id'] ) . ",";
				//-------------------------------------------------- 
				$sql .=  $db->quote( $location_id ) . ",";
				$sql .=  $db->quote( $_REQUEST['lethality'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['structures_consumed'] ) . ",";
				if ( empty($_REQUEST['percentage_consumed']) )
					$sql .=  "NULL,";
				else
					$sql .=  $db->quote( $_REQUEST['percentage_consumed'] ) . ",";
				if ( empty($_REQUEST['percentage_diet']) )
					$sql .=  "NULL,";
				else
					$sql .=  $db->quote( $_REQUEST['percentage_diet'] ) . ",";
				if ( empty($_REQUEST['percentage_diet_by']) )
					$sql .=  "NULL,";
				else
					$sql .=  $db->quote( $_REQUEST['percentage_diet_by'] ) . ",";
	
				$sql .=  $db->quote( $_REQUEST['preference'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['observation_type'] ) . ",";
				break;
			case "facilitation":
				$sql .= "( cite_id, owner_id, facilitation_interaction_id, location_id,";
				$sql .= "facilitation_type, observation_type, comment, datum ) ";
				$sql .= " VALUES ( ". $db->quote( $_REQUEST['cite_id'] ) . ",";
				$sql .=  $db->quote( $user['id']) . ",";
				$sql .=  $db->quote( $_REQUEST['interaction_id'] ) . ",";
				//--------------------------------------------------
				// $sql .=  $db->quote( $_REQUEST['location_id'] ) . ",";
				//-------------------------------------------------- 
				$sql .=  $db->quote( $location_id ) . ",";
				$sql .=  $db->quote( $_REQUEST['facilitation_type'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['observation_type'] ) . ",";
			break;
			case "competition":
				$sql .= "( cite_id, owner_id, competition_interaction_id, location_id,";
				$sql .= "competition_type, observation_type, comment, datum) ";
				$sql .= " VALUES ( ". $db->quote( $_REQUEST['cite_id'] ) . ",";
				$sql .=  $db->quote( $user['id']) . ",";
				$sql .=  $db->quote( $_REQUEST['interaction_id'] ) . ",";
				//--------------------------------------------------
				// $sql .=  $db->quote( $_REQUEST['location_id'] ) . ",";
				//-------------------------------------------------- 
				$sql .=  $db->quote( $location_id ) . ",";
				$sql .=  $db->quote( $_REQUEST['competition_type'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['observation_type'] ) . ",";
				break;
			case "parasitic":
				$sql .= "( cite_id, owner_id, parasitic_interaction_id, location_id,";
				$sql .= "endo_ecto, lethality, prevalence, intensity,  parasite_type, observation_type, comment, datum) ";
				$sql .= " VALUES ( ". $db->quote( $_REQUEST['cite_id'] ) . ",";
				$sql .=  $db->quote( $user['id']) . ",";
				$sql .=  $db->quote( $_REQUEST['interaction_id'] ) . ",";
				//--------------------------------------------------
				// $sql .=  $db->quote( $_REQUEST['location_id'] ) . ",";
				//-------------------------------------------------- 
				$sql .=  $db->quote( $location_id ) . ",";
				$sql .=  $db->quote( $_REQUEST['endo_ecto'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['lethality'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['prevalence'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['intensity'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['parasite_type'] ) . ",";
				$sql .=  $db->quote( $_REQUEST['observation_type'] ) . ",";
				break;
			default:
				break;
			}

			if ( empty($_REQUEST['comment']) ) $sql .=  "NULL,";
			else $sql .=  $db->quote( $_REQUEST['comment'] ) . ",";
			if ( empty($_REQUEST['datum']) ) $sql .=  "NULL )";
			else $sql .=  $db->quote( $_REQUEST['datum'] ) . ")";
	
			$result = $db->query($sql);
			if(DB::isError($result)) { 
				$response['error'] = $result->getMessage();
				$response['sql'] = $sql;
			} else { 
				$response = $_REQUEST;
			}	
			echo json_encode( $response );
			break;
		// add stages to a node, return the node
		case "addNewStages":
			if (isset( $_REQUEST['node_id'] ) && isset( $_REQUEST['stage_names'] )){
				$response =Array();
				$stage_names = explode(",", $_REQUEST['stage_names'] );
				if (!canWrite($user) ) { error("No permissions to add New Stage."); }
				foreach ($stage_names as $stage_name) {
					$sql = "INSERT into stages  ( node_id, name, owner_id) VALUES (";
					$sql .= $db->quote( $_REQUEST['node_id'] ) . ", " . $db->quote($stage_name) . ", ". $db->quote($user['id']) .  ")";
					$result = $db->query($sql);
					if(db::iserror($result)) { 
						$response['error'] = $result->getmessage();
						$response['sql'] = $sql;
					} //else { 
						//$stage = $db->getrow( "SELECT * from stages WHERE id=last_insert_id()" );
						//$response[ $stage_name ] = getStage($stage);
					//}	
				}
				if (!isset( $response['error'] ) )
					$response = getNodeItems();
				echo json_encode( $response );
			} else {
				error("No node_id or stage_names given, need both.");
			}	
			break;
		case "addNewStage":
			if (isset( $_REQUEST['node_id'] ) && isset( $_REQUEST['stage_name'] )){
				$response =Array();
				if (!canWrite($user) ) { error("No permissions to add New Stage."); }
				$sql = "INSERT into stages  ( node_id, name, owner_id) VALUES (";
				$sql .= $db->quote( $_REQUEST['node_id'] ) . ", " . $db->quote($_REQUEST['stage_name']) . ", ". $db->quote($user['id']) .  ")";
				$result = $db->query($sql);
				if(db::iserror($result)) { 
					$response['error'] = $result->getmessage();
					$response['sql'] = $sql;
				} else { 
					$stage = $db->getrow( "SELECT * from stages WHERE id=last_insert_id()" );
					$response = getStage($stage);
				}	
				echo json_encode( $response );
			} else {
				error("no node_id or stage_name given, need both.");
			}	
			break;
		case "addNewCitedVar":
			if ( !isset( $_REQUEST['table']) ) error("you must provide table name for citation data");
			if ( !isset( $_REQUEST['fields']) ) error("you must provide field names for citation data");
			if ( !isset( $_REQUEST['values']) ) error("you must provide values for citation data");
			if ( !isset( $_REQUEST['cite_id']) ) error("you must provide cite_id for citation data");
			if ( !isset( $_REQUEST['node_id']) AND !isset( $_REQUEST['stage_id']) ) error("you must provide either a node_id or stage_id for citation data");
			if (!canWrite($user) ) { error("No permissions to add Cited Variable."); }
			$foreign_ptr="node_id";
			if ( isset( $_REQUEST['stage_id'])) {	$foreign_ptr="stage_id"; }
			$sql = "INSERT into " .$_REQUEST['table'] . " ( cite_id, owner_id, ". $foreign_ptr;
			if ( isset( $_REQUEST['comment']) ) $sql .= ", comment";
			if ( isset( $_REQUEST['datum']) )   $sql .= ", datum";
			foreach( $_REQUEST['fields'] as $f ) { $sql .= ', ' . $f;	}
			$sql .= ") VALUES ( " . $db->quote($_REQUEST['cite_id']) . ', ' . $db->quote($user['id']) .', '. $db->quote($_REQUEST[$foreign_ptr]);
			if ( isset( $_REQUEST['comment']) ) $sql .=  "," . $db->quote($_REQUEST['comment']);
			if ( isset( $_REQUEST['datum']) ) $sql .=  "," . $db->quote($_REQUEST['datum']);
			foreach( $_REQUEST['values'] as $v ) { $sql .= ', '. $db->quote($v);	}
				$sql .= ")";
			$result = $db->query($sql);
			if(DB::isError($result)) { 
				$tmp = Array();
				$tmp['error'] = $result->getMessage();
				$tmp['sql'] = $sql;
				echo json_encode( $tmp );
			} else { 
				$tmp = Array();
				$values = getValues($_REQUEST['table'], $foreign_ptr, $_REQUEST[$foreign_ptr], $foreign_ptr ) ;	
				$tmp[$_REQUEST['table']] = $values;
				echo json_encode( $tmp );
			}
			break;
	
		case "addNewCitedVars":
			if ( empty( $_REQUEST['json']) ) {  
				error("you must provide citation data");
			}
			if (!canWrite($user) ) { error("No permissions to add Cited Variable."); }
			$request =  $_REQUEST['json'] ;
			$response = Array ( );
			foreach ($request as $req) {
				$foreign_ptr="node_id";
				if ( isset( $req['stage_id'])) {	$foreign_ptr="stage_id"; }
				$sql = "INSERT into " .$req['table'] . " ( cite_id, owner_id, ". $foreign_ptr;
				foreach( $req['fields'] as $f ) { $sql .= ', ' . $f;	}
				$sql .= ") VALUES ( " . $db->quote($req['cite_id']) . ', ' . $db->quote($user['id']) .', '. $db->quote($req[$foreign_ptr]);
				foreach( $req['values'] as $v ) { $sql .= ', '. $db->quote($v);	}
				$sql .= ")";
				$result = $db->query($sql);
				if(DB::isError($result)) { 
					$tmp = Array();
					$tmp['error'] = $result->getMessage();
					$tmp['sql'] = $sql;
					array_push($response, $tmp);
				} else { 
					$tmp = Array();
					$values = getValues($req['table'], $foreign_ptr, $req[$foreign_ptr], $foreign_ptr ) ;	
					$tmp[$req['table']] = $values;
					array_push($response, $tmp);
				}
			}
			echo json_encode( $response );
			break;
	
		case "updateTable":
			$response = Array();
			if ( isset( $_REQUEST['table_name']) &&  isset( $_REQUEST['fields']) && isset( $_REQUEST['values'])  && isset( $_REQUEST['id'])  ) {

				if (!canModify($user,  $_REQUEST['table_name'], "id",  $_REQUEST['id']) ) {
						error("No permissions to modify this table" . $_REQUEST['table_name'] .":id:". $_REQUEST['id']);
				}

			  $sql = "UPDATE " . $_REQUEST['table_name'] . " SET ";
				for($i=0; $i < count($_REQUEST['fields']);$i++) {	
					if ($i >0) $sql .= ", ";
					$sql .=  $_REQUEST['fields'][$i]	. "=" . $db->quote($_REQUEST['values'][$i]); 
				}
				$sql .= " WHERE id=" . $db->quote( $_REQUEST['id'] );
				$result = $db->query($sql);
				if(DB::isError($result)) { 
					$response['error'] = $result->getMessage();
					$response['sql'] = $sql;
				} 
			}else{
				$response['error'] = "Need more variables to update " . $_REQUEST['table_name'];
			}
		  echo json_encode( $response );
			break;
		//--------------------------------------------------
		// Map interface server functions
		//-------------------------------------------------- 
		case 'contains_point':
			$lat = $_REQUEST['lat'];
			$lon = $_REQUEST['lon'];
			$sql = "SELECT id, AsText(region) AS region FROM locations WHERE MBRIntersects(region,GeomFromText(?)) ORDER BY z_index DESC, zoom_max DESC";
			$r = $db->getAll($sql,array("POINT($lon $lat)"),DB_FETCHMODE_ASSOC);
			if (!DB::isError($r)) {
				print json_encode($r);
			} else {
				error($r->getMessage());
			}
			break;
		case 'select_region':
			$id = $_REQUEST['id'];
			$sql = "SELECT AsText(region) AS region, AsText(centroid) AS centroid FROM locations WHERE id = ?";
			$r = $db->getAll($sql,array($id),DB_FETCHMODE_ASSOC);
			if (!DB::isError($r)) {
				print json_encode($r);
			} else {
				error($r->getMessage());
			}
			break;
		case 'visible_regions':
			$bbox = $_REQUEST['bbox'];
			$rect = getRectWKT($bbox);
			$zoom = $_REQUEST['zoom'];
			$ignore = isset($_REQUEST['exclude']) ? $_REQUEST['exclude'] : '';
			$sql = "SELECT AsText(region) AS region, AsText(centroid) AS centroid, z_index AS z_index, visible AS visible, parent AS parent,
				id AS id, AsText(Envelope(region)) AS envelope, zoom_min AS zoom_min, zoom_max AS zoom_max, lft AS rank
				FROM locations
				WHERE ( (zoom_min <= ? AND zoom_max >= ?)\n";
			if (isset($_REQUEST['exclude']) && count($ignore) > 0) {
				$qmrk = str_repeat('?,',count($ignore)-1).'?';
				$sql .= " AND id NOT IN ({$qmrk})\n";
			}
			$sql .= 	" AND MBRIntersects(GeomFromText(?),region) )";
			$p = (isset($_REQUEST['exclude']) && count($ignore) > 0) ? array_merge(array($zoom,$zoom),$ignore,array($rect)) : array($zoom,$zoom,$rect);
			$r = $db->getAll($sql,$p,DB_FETCHMODE_ASSOC);
			if (!DB::isError($r)) {
				print json_encode($r);
			} else {
				error($r->getMessage());
			}
			break;
		case 'get_children':
			$id = (int)$_REQUEST['id'];
			$sql = "SELECT node.id AS id, node.name AS name, (COUNT(children.id) - 1) AS children,
				node.zoom_min AS zoom_min, node.zoom_max AS zoom_max, AsText(node.centroid) AS centroid, node.parent AS parent
				FROM locations AS node, locations as children
				WHERE children.lft BETWEEN node.lft AND node.rgt
				AND node.parent = ?
				AND node.visible = 1
				AND node.active = 1
				AND children.visible = 1
				AND children.active = 1
				GROUP BY node.id
				ORDER BY node.lft ASC";

			$result = array();
			$res = $db->query($sql,array($id));
			if (!DB::isError($res)) {
				while ($row = $res->fetchRow(DB_FETCHMODE_ASSOC)) {
					$result[] = array(
						"attr" => array("id" => "node_".$row['id']),
						"data" => $row['name'],
						"state" => ((int)$row['children'] >= 1) ? "closed" : "",
						"zoom_min" => $row['zoom_min'],
						'zoom_max' => $row['zoom_max'],
						"centroid" => $row['centroid'],
						'parent' => $row['parent']
					);
				}
				print json_encode($result);
			} else {
				error($res->getMessage());
			}
			break;
		case 'search':
			$id = $_REQUEST['srch'];
			$sql = "SELECT DISTINCT found.id 
				FROM locations srch, locations found
				WHERE 0 OR (found.lft < srch.lft AND found.rgt > srch.rgt) 
				AND srch.id = ?
				AND srch.visible = 1
				AND srch.active = 1
				ORDER BY found.lft ASC";
			$sth = $db->query($sql,array($id));
			if (!DB::isError($sth)) {
				$result = array();
				while ($row = $sth->fetchRow(DB_FETCHMODE_ARRAY)) {
					$result[] = "#node_".$row[0];
				}
				print json_encode($result);
			} else {
				print "[]";
			}
			break;

		default:
			break;
	}


}


?>
