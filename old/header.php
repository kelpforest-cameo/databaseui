<?
require_once("connect.php");
$user_first_name ="";
$user_last_name="";

if(is_authenticated() ) {
	$user_email = $_SESSION[username];
	$res = $db->getRow( "SELECT * FROM users WHERE email=". $db->quote($user_email) );  
	if(DB::IsError($res)) { 
		die( $res->getMessage()) ;
	} else {
		$user_id= $res['id'];
		$user_first_name= $res['first_name'];
		$user_last_name= $res['last_name'];
	}
}
?>

<p>
<span style="font-size:1.3em;font-weight:bold;">Kelpforest FoodWeb Interaction DB</span>  &nbsp;  &nbsp;  <a class="link" href="index.php">Add,Edit Nodes</a> |  <a class="link" href="#" onclick="listAllNodes();">List Nodes/Interactions</a> | <a class="link" href="#" onclick="openNewNonitisDialog();">Add NonItis Nodes</a> | <a class="link" href="#" onclick="openNewCitationDialog();">Add Citations</a> |  <a class="link" href="#" onclick="listAllCitations();">List Citations</a> | <a class="link" href="#"  onclick="openInteractionsDialog();">Add,Edit Interactions</a>  &nbsp;  &nbsp; <a class="link" href="login.php">logout
<?
	echo $user_first_name ." " . $user_last_name;
?>
</a>  
</p>
