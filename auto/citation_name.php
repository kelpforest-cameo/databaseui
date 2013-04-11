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
$catstr = "CONCAT(authors.last_name,', ',authors.first_name,': \\'',citations.title,'\\', ',citations.year)";
$sql = "SELECT citations.id AS `id`, {$catstr} AS `label`, {$catstr} AS `value`";
$sql .= " FROM author_cite";
$sql .= " INNER JOIN authors ON authors.id =author_cite.author_id ";
$sql .= " INNER JOIN citations on citations.id = author_cite.cite_id ";
$sql .= " WHERE authors.last_name LIKE ?";
$sql .= " OR authors.first_name LIKE ?";
$sql .= " OR citations.title LIKE ?";
$sql .= " ORDER BY authors.last_name"; 
$results = $db->getAll($sql,array($wk,$wk,$wk));
if(DB::IsError($results)) { error($results->getMessage(  )); }
echo json_encode($results);

?>
