<?php

function dbconnection() {
    $con = mysqli_connect("localhost", "root", "", "student");
    return $con;
}

?>