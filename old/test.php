<?
require_once("DB.php"); 

// --------  DATABASE CONFIGURE OPTIONS ---------------------------------------------- //

$DB_host    = "localhost";  // the hostname of the database server
$DB_user    = "kelpforest";           // the username to connect with
$DB_pass    = "RC.1ab";      // the user's password
$DB_dbName  = "kelpforest";         // the name of the database to connect to
$DB_dbType  = "mysql";           // the type of database server.

//----------- Connect to database ------------------------------------------------------//
$dsn = $DB_dbType . "://"               // Build a DSN string (Data Source Name)
. $DB_user . ":"                // Required by DB::connect()
. $DB_pass . "@" 
. $DB_host . "/" 
. $DB_dbName;

$db = DB::connect($dsn);                // connect to database
if (DB::isError($db)) {                 // Check for error at connect time
	//unset($_SESSION['is_logged_in']);
	//unset($_SESSION['username']);
	//unset($_SESSION['password']);
	echo $db->getMessage();             // Print out error message and exit 
	exit();
} else {
	//$_SESSION['is_logged_in'] = 1;
	$db->setFetchMode(DB_FETCHMODE_ASSOC);
}
$sql = "SELECT * FROM authors ORDER BY last_name"; 
$results = $db->getAll($sql);
if(DB::IsError($results)) { error($results->getMessage(  )); }
else {
	for($i=0; $i < count($results); $i++ ) {
		$citations = Array();
		$q1= "SELECT * FROM author_cite WHERE author_id=". $db->quote($results[$i]['id']);
		$r1 = $db->getAll($q1);
		if(DB::IsError($r1)) { error($r1->getMessage(  )); }
		for ($j=0; $j < count($r1); $j++ ) {
			$q2= "SELECT id, title, year FROM citations WHERE id=". $db->quote($r1[$j]['cite_id'] . " ORDER BY year");
			$r2 = $db->getAll($q2);
			if(DB::IsError($r2)) { error($r2->getMessage(  )); }
			for ($k=0;$k <  count($r2); $k++){
				array_push($citations, $r2[$k]);
			}
		}
		$results[$i]['citations'] = $citations ;
	}
}
echo "<html><body><pre>";
print_r($results);

echo "</pre></body></html>";
?>
