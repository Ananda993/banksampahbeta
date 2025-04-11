<?php
session_start();
include "../config/database.php";

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION['user_id'];

// Fetch user data
$sql_user = "SELECT * FROM users WHERE id = $user_id";
$result_user = $conn->query($sql_user);
$user = $result_user->fetch_assoc();

// Fetch transaction history
$sql_transaksi = "SELECT * FROM transaksi WHERE user_id = $user_id ORDER BY created_at DESC";
$result_transaksi = $conn->query($sql_transaksi);

// Calculate total savings
$total_saldo = $user['saldo'];

// Get statistics for chart
$sql_stats = "SELECT jenis_sampah, SUM(berat_kg) as total_berat 
              FROM transaksi 
              WHERE user_id = $user_id 
              GROUP BY jenis_sampah";
$result_stats = $conn->query($sql_stats);

$labels = [];
$data = [];
while ($row = $result_stats->fetch_assoc()) {
    $labels[] = $row['jenis_sampah'];
    $data[] = $row['total_berat'];
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard User - Sampah Bali Lestari</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-50">
    <!-- Sidebar -->
    <nav class="fixed top-0 left-0 z-40 w-64 h-screen transition-transform -translate-x-full sm:translate-x-0">
        <div class="h-full px-3 py-4 overflow-y-auto bg-gradient-to-b from-blue-600 to-blue-700">
            <div class="mb-8 p-4">
                <h2 class="text-2xl font-semibold text-white">Bank Sampah</h2>
                <p class="text-blue-200">Bali Lestari</p>
            </div>
            <ul class="space-y-2 font-medium">
                <li>
                    <a href="#dashboard" class="flex items-center p-2 text-white rounded-lg hover:bg-blue-500 group">
                        <svg class="w-5 h-5 text-blue-200" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 21">
                            <path d="M16.975 11H10V4.025a1 1 0 0 0-1.066-.998 8.5 8.5 0 1 0 9.039 9.039.999.999 0 0 0-1-1.066h.002Z"/>
                            <path d="M12.5 0c-.157 0-.311.01-.565.027A1 1 0 0 0 11 1.02V10h8.975a1 1 0 0 0 1-.935c.013-.188.028-.374.028-.565A8.51 8.51 0 0 0 12.5 0Z"/>
                        </svg>
                        <span class="ml-3">Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="tabungan.php" class="flex items-center p-2 text-white rounded-lg hover:bg-blue-500 group">
                        <svg class="w-5 h-5 text-blue-200" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M11.074 4 8.442.408A.95.95 0 0 0 7.014.254L2.926 4h8.148ZM9 13v-1a4 4 0 0 1 4-4h6V6a1 1 0 0 0-1-1H1a1 1 0 0 0-1 1v13a1 1 0 0 0 1 1h17a1 1 0 0 0 1-1v-2h-6a4 4 0 0 1-4-4Z"/>
                            <path d="M19 10h-6a2 2 0 0 0-2 2v1a2 2 0 0 0 2 2h6a1 1 0 0 0 1-1v-3a1 1 0 0 0-1-1Zm-4.5 3a1 1 0 1 1 0-2 1 1 0 0 1 0 2Z"/>
                        </svg>
                        <span class="ml-3">Tabungan</span>
                    </a>
                </li>
                <li>
                    <a href="statistik.php" class="flex items-center p-2 text-white rounded-lg hover:bg-blue-500 group">
                        <svg class="w-5 h-5 text-blue-200" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M5 2a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1h2a2 2 0 0 1 2 2v15a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h2V2ZM4 5H3v15h14V5h-1v1a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V5Zm2 0v1h8V5H6V2H5v3h1Zm6 5a1 1 0 1 0-2 0v6a1 1 0 1 0 2 0v-6Zm-4 2a1 1 0 1 0-2 0v4a1 1 0 1 0 2 0v-4Zm8 0a1 1 0 1 0-2 0v4a1 1 0 1 0 2 0v-4Z"/>
                        </svg>
                        <span class="ml-3">Statistik</span>
                    </a>
                </li>
                <li>
                    <a href="profile.php" class="flex items-center p-2 text-white rounded-lg hover:bg-blue-500 group">
                        <svg class="w-5 h-5 text-blue-200" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M10 0a10 10 0 1 0 10 10A10.011 10.011 0 0 0 10 0Zm0 5a3 3 0 1 1 0 6 3 3 0 0 1 0-6Zm0 13a8.949 8.949 0 0 1-4.951-1.488A3.987 3.987 0 0 1 9 13h2a3.987 3.987 0 0 1 3.951 3.512A8.949 8.949 0 0 1 10 18Z"/>
                        </svg>
                        <span class="ml-3">Profile</span>
                    </a>
                </li>
                <li>
                    <a href="login.php" class="flex items-center p-2 text-white rounded-lg hover:bg-blue-500 group">
                        <svg class="w-5 h-5 text-blue-200" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 16">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 8h11m0 0-4-4m4 4-4 4m-5 3H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h3"/>
                        </svg>
                        <span class="ml-3">Logout</span>
                    </a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Main content -->
    <div class="p-4 sm:ml-64">
        <div class="p-4 rounded-lg mt-14">
            <!-- Welcome Card -->
            <div class="p-6 bg-white border border-gray-200 rounded-lg shadow mb-4">
                <div class="flex justify-between items-center">
                    <div>
                        <h2 class="text-2xl font-bold text-gray-900">Selamat datang, <?php echo $user['nama']; ?>!</h2>
                        <p class="mt-1 text-sm text-gray-600">Kelola sampahmu untuk masa depan yang lebih baik</p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm text-gray-600">Total Saldo</p>
                        <p class="text-2xl font-bold text-blue-600">Rp <?php echo number_format($total_saldo, 2); ?></p>
                    </div>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-4">
                <div class="p-4 bg-white rounded-lg shadow">
                    <div class="flex items-center">
                        <div class="p-3 rounded-full bg-blue-100 text-blue-500">
                            <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M4 4a2 2 0 00-2 2v1h16V6a2 2 0 00-2-2H4z"/>
                                <path fill-rule="evenodd" d="M18 9H2v5a2 2 0 002 2h12a2 2 0 002-2V9zM4 13a1 1 0 011-1h1a1 1 0 110 2H5a1 1 0 01-1-1zm5-1a1 1 0 100 2h1a1 1 0 100-2H9z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm text-gray-500">Total Transaksi</p>
                            <p class="text-lg font-semibold"><?php echo $result_transaksi->num_rows; ?></p>
                        </div>
                    </div>
                </div>
                <!-- Add more stat cards as needed -->
            </div>

            <!-- Transaction History -->
            <div class="bg-white rounded-lg shadow mb-4">
                <div class="p-4 border-b">
                    <h2 class="text-xl font-bold">Riwayat Transaksi</h2>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm text-left text-gray-500">
                        <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3">Tanggal</th>
                                <th scope="col" class="px-6 py-3">Jenis Sampah</th>
                                <th scope="col" class="px-6 py-3">Berat (kg)</th>
                                <th scope="col" class="px-6 py-3">Saldo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($row = $result_transaksi->fetch_assoc()) { ?>
                                <tr class="bg-white border-b hover:bg-gray-50">
                                    <td class="px-6 py-4"><?php echo date('d M Y H:i', strtotime($row['created_at'])); ?></td>
                                    <td class="px-6 py-4"><?php echo $row['jenis_sampah']; ?></td>
                                    <td class="px-6 py-4"><?php echo $row['berat_kg']; ?> kg</td>
                                    <td class="px-6 py-4 font-medium text-blue-600">Rp <?php echo number_format($row['saldo'], 2); ?></td>
                                </tr>
                            <?php } ?>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Statistics Chart -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">
                <div class="bg-white rounded-lg shadow p-4">
                    <h2 class="text-xl font-bold mb-4">Statistik Sampah</h2>
                    <canvas id="statistikChart"></canvas>
                </div>

                <!-- Profile Card -->
                <div class="bg-white rounded-lg shadow p-4">
                    <h2 class="text-xl font-bold mb-4">Profile</h2>
                    <div class="space-y-4">
                        <div>
                            <p class="text-sm text-gray-500">Nama</p>
                            <p class="font-medium"><?php echo $user['nama']; ?></p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Email</p>
                            <p class="font-medium"><?php echo $user['email']; ?></p>
                        </div>
                        <a href="profile.php" class="inline-block px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                            Edit Profile
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.min.js"></script>
    <script>
        // Initialize Chart
        var ctx = document.getElementById('statistikChart').getContext('2d');
        var statistikChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: <?php echo json_encode($labels); ?>,
                datasets: [{
                    data: <?php echo json_encode($data); ?>,
                    backgroundColor: [
                        '#3B82F6', // blue
                        '#10B981', // green
                        '#F59E0B', // yellow
                        '#EF4444', // red
                        '#8B5CF6', // purple
                        '#EC4899'  // pink
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                    },
                    title: {
                        display: true,
                        text: 'Distribusi Jenis Sampah',
                        font: {
                            size: 16
                        }
                    }
                },
                cutout: '70%'
            }
        });

        // Add smooth scrolling to navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Add active state to sidebar links
        const sidebarLinks = document.querySelectorAll('.sidebar a');
        sidebarLinks.forEach(link => {
            link.addEventListener('click', function() {
                sidebarLinks.forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });
    </script>
</body>
</html>