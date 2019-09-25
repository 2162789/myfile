<?php 

session_start();
//Checking User Logged or Not
if(empty($_SESSION['user'])){
    header('location:index.php');
}

//timeout after 5 sec
if(isset($_SESSION['user'])) {
    if((time() - $_SESSION['last_time']) > 1800) {
      header("location:logout.php");  
    }
}

include 'inc/db.php';
$sql = "SELECT * from documents";
$result = mysqli_query($conn, $sql);


if (isset($_POST['submit'])) {
include 'inc/db.php';

$file = $_FILES['file'];
$file_type = $_FILES['file']['type'];
$file_size = $_FILES['file']['size'];
$error_1='File Size too large';



if($file['name'] == ""){
	   echo "<script>
	      	alert('No file added');
	      </script>";

	}else{

	$doc_name = $file["name"];

	$i=0;
	while($i < count($doc_name)){

		$allName = mysqli_query($conn,"SELECT name FROM documents WHERE name = '$doc_name[$i]'");
		if(mysqli_num_rows($allName) >= 1){

			 echo "<script>
              alert('The File is redundant');
              </script>";


		}else{
			$curdate = date('Y-m-d');
			move_uploaded_file($file["tmp_name"][$i], "uploads/" . $file["name"][$i]);			
			$query = mysqli_query($conn,"
				INSERT INTO documents (name, date, size, location) 
				VALUES('$doc_name[$i]','$curdate','$file_size[$i]','uploads/$doc_name[$i]')");
		}
		$i++;
	}

	header("Location:dashboard.php");


		}
	}

?>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min2.css">	   
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />            
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap.min.css" /> 
	<title>Share File</title>
</head>
<body>
<div class="container-fuild">
	<div class="container">
		<h1>Hello User !!</h1>
		<div class="main text-right">
			<a class="btn btn-primary" data-role="update" href="#">Add new Document</a>
			<a class="btn btn-danger" data-role="update" href="logout.php">Logout</a>
		</div><br>
		<div class="table-responsive">
			<table id="file_data" class="table table-striped table-bordered">
				<thead>
					<tr>
						<td>Name</td>
						<td>Date Modified</td>
						<td>size</td>
						<td>Action</td>
					</tr>
				</thead>
			
			<?php

			 while($row = mysqli_fetch_array($result))
		      {  
		      	$id = $row['id'];
		      	$name = $row['name'];
		      	$modified_date = $row['date'];
		      	$size = $row['size'];
		      	$path = $row['location'];
		      	echo '
		      	<tr>
		      		<td>'.$name.'</td>
		      		<td>'.$modified_date.'</td>
		      		<td>'.$size.'</td>
		      		<td><a href="download.php?dow='.$path.'">Download</a>
		      			<a href="delete.php?dow='.$path.'">Delete</a></td>
		      	</tr>
		      	';

		      }

			?>
			</table>
		</div>
	</div>
</div>
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content" style="width: 50%; margin: auto;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update Status</h4>
      </div>
      <form method="POST" enctype="multipart/form-data" action="dashboard.php">
	      <div class="modal-body">
			<input type="file" name="file[]" multiple>
	      </div>
	      <div class="modal-footer">
	        <input type="submit" name="submit" class="btn btn-primary pull-right" value="Upload">
	        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
	      </div>
      </form>
    </div>

  </div>
</div>
<script src="js/ajax.js"></script> 
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.dataTables.min.js"></script>  
<script src="js/dataTables.bootstrap.min.js"></script>
<script>
      $(document).ready(function(){

          $('#file_data').DataTable();
        //  append values in input fields
          $(document).on('click','a[data-role=update]',function(){
                var id  = $(this).data('id');
                var status  = $('#'+id).children('td[data-target=status]').text();

                $('#status').val(status);
                $('#ClientId').val(id);
                $('#myModal').modal('toggle');
          });

          // now create event to get data from fields and update in database 
           $('#save').click(function(){
              var id  = $('#ClientId').val(); 
              var status =  $('#status').val();

              $.ajax({
                  url      : 'update.php',
                  method   : 'post',  
                  data     : {id: id, status:status},

                  success  : function(response){
                                // now update user record in table 
                                 $('#'+id).children('td[data-target=status]').text(status);
                                 $('#myModal').modal('toggle'); 
                             }
              });
           });
      });
</script>
</body>
</html>


