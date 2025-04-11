<?php
session_start();
include "../config/database.php";

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'admin') {
    header("Location: login.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user_id = $_POST['user_id'];
    $jenis_sampah = $_POST['jenis_sampah'];
    $berat_kg = $_POST['berat_kg'];

    // Hitung saldo (asumsi Rp 1000 per kg)
    $saldo = $berat_kg * 1000;

    // Masukkan data transaksi
    $sql_transaksi = "INSERT INTO transaksi (user_id, jenis_sampah, berat_kg, saldo) VALUES ($user_id, '$jenis_sampah', $berat_kg, $saldo)";
    $conn->query($sql_transaksi);

    // Update saldo user
    $sql_update_saldo = "UPDATE users SET saldo = saldo + $saldo WHERE id = $user_id";
    $conn->query($sql_update_saldo);

    header("Location: dashboard_admin.php");
    exit();
}
?>
