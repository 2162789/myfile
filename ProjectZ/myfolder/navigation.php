
<?php

function department_all(){
echo "<nav class='navbar navbar-default'>
  <div class='container-fluid'>
    <div class='navbar-header'>
      <a class='navbar-brand' href='dashboard.php'>Human Resource Department</a>
    </div>
    <ul class='nav navbar-nav'>
      <li class='active'><a href='dashboard.php'>Home</a></li>
      <?php
			if ($_SESSION['users']['department'] == 'All') {
		  echo '<li><a href='#'>Medical Voucher</a></li>';

		}elseif($department == 'Personel'){
		  echo '<li><a href='#'>List of Voucher</a></li>';
		}
      ?>
      
    </ul>
   	<ul class='nav navbar-nav navbar-right'>
  		<li><a class='text-right' href='logout.php'>Logout</a></li>
	</ul>
  </div>
</nav>";

}

?>