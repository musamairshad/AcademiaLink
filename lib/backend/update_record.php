<?php

include("dbconnection.php");
$con = dbconnection();

if(isset($_POST["name"]))
{
    $name = $_POST["name"];
}
else return;

if(isset($_POST["email"]))
{
    $email = $_POST["email"];
}
else return;

if(isset($_POST["department"]))
{
    $department = $_POST["department"];
}
else return;

$query = "UPDATE `student_table` SET `sname`='$name', `sdepartment`='$department' WHERE `semail`='$email'";

$exe = mysqli_query($con, $query);
$arr = [];
if ($exe) {
    $arr["success"] = "true";
} else {
    $arr["success"] = "false";
}

print(json_encode($arr));

?>