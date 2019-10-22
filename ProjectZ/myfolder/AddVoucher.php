<?php

session_start();
//Checking User Logged or Not
if(empty($_SESSION['users'])){
    header('location:index.php');
}

//timeout after 5 sec
if(isset($_SESSION['users'])) {
    if((time() - $_SESSION['last_time']) > 1800) {
      header("location:logout.php");  
    }
}

//Restrict User or Moderator to Access Admin.php page
if($_SESSION['users']['em_position']=='Admin'){
    header('location:dashboard.php');
}

	if (isset($_POST['submit'])) {
	include 'inc/db.php';

	$curdate = $_POST['date'];
	$file = $_FILES['file'];
	$file_type = $_FILES['file']['type'];
	$file_size = $_FILES['file']['size'];


	$doc_name = $file["name"];
	$i=0;

	while($i < count($doc_name)){

		if ($file_type[$i] == 'image/png' && $file_type[$i] == 'image/jpg') {
			move_uploaded_file($file["tmp_name"][$i], "voucher/" . $file["name"][$i]);		
			$query = mysqli_query($conn,"
					INSERT INTO vouchers (name, curdate, destination) 
					VALUES('oreinz','$curdate', 'voucher/$doc_name[$i]')");	
			

		}
		$i++;
		}
	}
	
?>

<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>

<div class="container-fluid">
	<div class="container">
		<!--<div class="text-red"><?php if(isset($error)){ echo $error; }?></div>-->
		<form method="POST" enctype="multipart/form-data" action="AddVoucher.php">
			<input type="date" name="date">
			<input type="file" name="file[]" multiple>
			<input type="submit" name="submit" value="submit">
		</form>
	</div>
</div>
</body>
</html>