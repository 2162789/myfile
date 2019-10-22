<?php
include 'inc/db.php';

function department_all(){
	include 'inc/db.php';
	$sql = "SELECT * from documents where department = 'all'";
	$result = mysqli_query($conn, $sql);
	$output = '';
	while($row = mysqli_fetch_array($result))
	      { 
	      	$name = htmlspecialchars($row['name']);
	      	$modified_date = htmlspecialchars($row['date']);
	      	$size = htmlspecialchars($row['size']);
	      	$path = htmlspecialchars($row['location']);
	      	$output .= '
	      	<tr>
	      		<td><a href="dashboard.php?loc='.$path.'">'.$name.'</a></td>
	      		<td>'.$modified_date.'</td><td>';

	      		if ($_SESSION['users']['em_position'] == 'Admin') {
	      		$output .= '<a href="download.php?dow='.$path.'"><input type="button" class="btn btn-success" value="Download"/></a>
	      			<a href="delete.php?dow='.$path.'"><input type="button" class="btn btn-danger" value="Delete"/></a>';
				
				}
	      }

	return $output;	
}

function department_head(){
	include 'inc/db.php';
	$sql = "SELECT * from documents where department = 'all' OR department = 'head'";
	$result = mysqli_query($conn, $sql);
	$output = '';
	while($row = mysqli_fetch_array($result))
	      { 
	      	$name = htmlspecialchars($row['name']);
	      	$modified_date = htmlspecialchars($row['date']);
	      	$size = htmlspecialchars($row['size']);
	      	$path = htmlspecialchars($row['location']);
	      	$output .= '
	      	<tr>
	      		<td><a href="dashboard.php?loc='.$path.'">'.$name.'</a></td>
	      		<td>'.$modified_date.'</td><td>';

	      		if ($_SESSION['users']['em_position'] == 'Admin') {
	      		$output .= '<a href="download.php?dow='.$path.'"><input type="button" class="btn btn-success" value="Download"/></a>
	      			<a href="delete.php?dow='.$path.'"><input type="button" class="btn btn-danger" value="Delete"/></a>';
				
				}
	      }

	return $output;	
}

function department_personel(){
	include 'inc/db.php';
	$sql = "SELECT * from documents";
	$result = mysqli_query($conn, $sql);
	$output = '';
	while($row = mysqli_fetch_array($result))
	      { 
	      	$name = htmlspecialchars($row['name']);
	      	$modified_date = htmlspecialchars($row['date']);
	      	$size = htmlspecialchars($row['size']);
	      	$path = htmlspecialchars($row['location']);
	      	$output .= '
	      	<tr>
	      		<td><a href="dashboard.php?loc='.$path.'">'.$name.'</a></td>
	      		<td>'.$modified_date.'</td><td>';

	      		if ($_SESSION['users']['em_position'] == 'Admin') {
	      		$output .= '<a href="download.php?dow='.$path.'"><input type="button" class="btn btn-success" value="Download"/></a>
	      			<a href="delete.php?dow='.$path.'"><input type="button" class="btn btn-danger" value="Delete"/></a>';
				
				}
	      }

	return $output;	
}

function vouchers(){
	include 'inc/db.php';
	$sql = "SELECT * from vouchers";
	$result = mysqli_query($conn, $sql);
	$output = '';
	while($row = mysqli_fetch_array($result))
	      { 
	      	
	      	$name = htmlspecialchars($row['name']);
	      	$path = htmlspecialchars($row['destination']);
	      	$output .= '
	      	<tr>
	      		<td>'.$name.'</td>
	      		<td><a href="VouchersList.php?med='.$path.'"><input type="button" class="btn btn-success" value="Download"/></a>';
				
				}

	return $output;	
}

?>