<?php
$servername = "localhost"; // atau sesuai konfigurasi server Anda
$username = "root";        // username database
$password = "";            // password database
$dbname = "bank_sampah";   // nama database Anda

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Periksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}
?>
