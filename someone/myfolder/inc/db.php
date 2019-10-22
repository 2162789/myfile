<?php
$servername = "localhost";
$username = "root";
$password = "Boltpen32.";
$database = "folder";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $database);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
	echo "<script>
  			window.location.href='error.php';
  		</script>";
}
?>
