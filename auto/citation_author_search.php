<?
function error ( $msg ) {
	echo json_encode( Array('error'=> $msg));	
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
	error( "No search terms.");
	exit();
}

$wk = "%{$srchKey}%";
$sql = "SELECT id, CONCAT(last_name,', ',first_name) AS `value`, CONCAT(last_name,', ',first_name) AS `label` "
	."FROM authors "
	."WHERE last_name LIKE ? OR first_name LIKE ? "
	."ORDER BY last_name ASC";
$results = $db->getAll($sql,array($wk,$wk));
if(DB::IsError($results)) { error($results->getMessage(  )); }
echo json_encode($results);
?>
