<?php

if (isset($_POST['submit'])) {
include 'inc/db.php';

$file = $_FILES["file"];

if($file['name'] == ""){
	   echo "<script>
	      	alert('No file added');
	      </script>";
}
else{

	$doc_name = $file["name"];
	$location = "uploads/".$file["name"];

	$i=0;

	while ( <= count($file['name'])) {
	
	$query = mysqli_query($conn,"INSERT INTO documents (name, location) VALUES('$doc_name','$location')");
	move_uploaded_file($file["tmp_name"][$i], "uploads/" . $file["name"][$i]);
	$i++;
	}

	

	header("Location:dashboard.php");
	}
}
?>