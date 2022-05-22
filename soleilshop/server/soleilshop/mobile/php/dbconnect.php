<?php
$servername = "localhost";
$username   = "root";
$password   = "";
$dbname     = "soleilshop_db";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>