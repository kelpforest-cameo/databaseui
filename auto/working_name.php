<?
function error ( $msg ) {
	$response['error'] = $msg;
	echo json_encode( $response );	
	exit();
} 
// init will check our session and log us in
include_once("../init.php");

// send out the header first to tell the client to expect json data
//header("Content-Type: application/json");

$srchKey='';

if ( !empty( $_GET['term']) ) {
	$srchKey = $_GET['term'];
} else {
	error("No search terms.");
	exit();
}

//get valid ITIS entries
$sql = "SELECT id, working_name AS `value`, CONCAT(`working_name`,' itis_id:',`itis_id`) AS `label` FROM nodes WHERE working_name LIKE ? AND itis_id <> -1 ORDER BY working_name ASC";
$r1 = $db->getAll($sql,array('%'.$srchKey.'%'));

//get non-ITIS entries
$sql = "SELECT id, working_name AS `value`, CONCAT(`working_name`,' non_itis_id:',`non_itis_id`) AS `label` FROM nodes WHERE working_name LIKE ? AND itis_id = -1 ORDER BY working_name ASC";
$r2 = $db->getAll($sql,array('%'.$srchKey.'%'));

if(DB::IsError($results)) { error($results->getMessage(  )); }

//result is ITIS/non-ITIS merged
echo json_encode(array_merge($r1,$r2));

?>
