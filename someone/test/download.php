<?php
include('inc/db.php');

if(isset($_GET['dow'])){

	$path = $_GET['dow'];

	$result = mysqli_query($conn,"SELECT * FROM documents WHERE location=".$path."");

	header('Content-Type: application/octet-stream');
	header('Content-Disposition: attachment; filename="'.basename($path).'"');
	header('Content-Length: '.filesize($path));
	readfile($path);
}


?>