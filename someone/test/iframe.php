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
?>
<!DOCTYPE html>
<html>
<frameset rows="30%,70%">
  <frame src="dashboard.php">
  <frame src="uploads/edit.pdf">
</frameset>

</html>