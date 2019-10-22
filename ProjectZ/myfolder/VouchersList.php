<?php
include 'query.php';

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

//Restrict User or Moderator to Access Employee.php page
if($_SESSION['users']['department']=='All' || 
	$_SESSION['users']['department']=='Head'){
    header('location:dashboard.php');
}


if(isset($_GET['med'])){

	$path = $_GET['med'];

	$result = mysqli_query($conn,"SELECT * FROM documents WHERE location=".$path."");

	header('Content-Type: application/octet-stream');
	header('Content-Disposition: attachment; filename="'.basename($path).'"');
	header('Content-Length: '.filesize($path));
	readfile($path);
}

?>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min2.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">       
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap.min.css" /> 
	<title>Vouchers List</title>
</head>
<body>
	<div class="container">
		<div class="table-responsive">
			<table id="file_data" class="table table-striped table-bordered">
				<thead>
					<tr>
						<td>Name</td>
						<td>Voucher</td>
					</tr>
				</thead>
			
			<?php
				echo vouchers();
			?>
				</td></tr>
			</table>
		</div>
	</div>
	<script src="js/ajax.js"></script> 
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>  
	<script src="js/dataTables.bootstrap.min.js"></script>
	<script type="text/javascript">
	
      $(document).ready(function(){

          $('#file_data').DataTable();
      });

	</script>
</body>
</html>