<?php
include('inc/db.php');

if(isset($_GET['dow'])){
	$path = $_GET['dow'];
	
	
	if (!unlink($path)) {
		echo "Error";
	}else{
		$result = mysqli_query($conn,"DELETE FROM documents WHERE location='$path'");
		header('Location:dashboard.php');
	}
}


?>