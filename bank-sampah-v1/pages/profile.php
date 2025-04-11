<?php
// Pastikan Anda telah menyertakan koneksi database
include '../config/db.php';

// Memulai sesi
session_start();

// Periksa apakah pengguna telah login
if (!isset($_SESSION['user_id'])) {
    header('Location: ../login.php');
    exit();
}

// Ambil data pengguna berdasarkan session
$user_id = $_SESSION['user_id'];
$query = "SELECT * FROM users WHERE id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param('i', $user_id);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

// Jika form di-submit, update data pengguna
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = htmlspecialchars(trim($_POST['name']));
    $email = htmlspecialchars(trim($_POST['email']));

    // Validasi input
    if (!empty($name) && !empty($email) && filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $update_query = "UPDATE users SET name = ?, email = ? WHERE id = ?";
        $update_stmt = $conn->prepare($update_query);
        $update_stmt->bind_param('ssi', $name, $email, $user_id);

        if ($update_stmt->execute()) {
            $_SESSION['success_message'] = 'Profil berhasil diperbarui';
            header('Location: profile.php');
            exit();
        } else {
            $error_message = 'Terjadi kesalahan saat memperbarui profil. Coba lagi.';
        }
    } else {
        $error_message = 'Nama dan email tidak boleh kosong atau email tidak valid.';
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="../assets/styles.css"> <!-- Sesuaikan dengan file CSS Anda -->
</head>
<body>
    <div class="container mx-auto p-4">
        <h1 class="text-2xl font-bold mb-4">Edit Profil</h1>

        <!-- Tampilkan pesan sukses atau error -->
        <?php if (isset($_SESSION['success_message'])): ?>
            <div class="bg-green-100 text-green-700 p-2 rounded mb-4">
                <?= $_SESSION['success_message']; unset($_SESSION['success_message']); ?>
            </div>
        <?php endif; ?>

        <?php if (isset($error_message)): ?>
            <div class="bg-red-100 text-red-700 p-2 rounded mb-4">
                <?= $error_message; ?>
            </div>
        <?php endif; ?>

        <form action="" method="POST" class="space-y-4">
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Nama</label>
                <input type="text" id="name" name="name" value="<?= htmlspecialchars($user['name']); ?>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            </div>

            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <input type="email" id="email" name="email" value="<?= htmlspecialchars($user['email']); ?>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
            </div>

            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Simpan Perubahan</button>
        </form>

        <div class="mt-6">
            <a href="../dashboard_user.php" class="text-blue-500 hover:underline">Kembali ke Dashboard</a>
        </div>
    </div>
</body>
</html>
