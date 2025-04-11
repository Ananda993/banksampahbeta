<?php
session_start();
include "../config/database.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM users WHERE email = '$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['role'] = $user['role'];

            if ($user['role'] == 'admin') {
                header("Location: dashboard_admin.php");
            } else {
                header("Location: dashboard_user.php");
            }
            exit();
        } else {
            echo "Password salah!";
        }
    } else {
        echo "Email tidak ditemukan!";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sampah Bali Lestari</title>
    <link rel="stylesheet" href="../assets/css/style.css">
    <style>
        /* Modern CSS for Login Page */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .login-container {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .login-container h1 {
            margin-bottom: 1.5rem;
            font-size: 2rem;
            color: #2575fc;
        }

        .login-container input {
            width: 100%;
            padding: 0.75rem;
            margin: 0.5rem 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .login-container input:focus {
            border-color: #2575fc;
        }

        .login-container button {
            width: 100%;
            padding: 0.75rem;
            margin-top: 1rem;
            background: #2575fc;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .login-container button:hover {
            background: #1a5bbf;
        }

        .login-container p {
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .login-container a {
            color: #2575fc;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .login-container a:hover {
            color: #1a5bbf;
        }

        .error-message {
            color: #ff4d4d;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form method="POST" id="loginForm">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <?php
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            if (isset($error)) {
                echo '<p class="error-message">' . $error . '</p>';
            }
        }
        ?>
        <p>Belum punya akun? <a href="register.php">Daftar di sini</a></p>
    </div>

    <script>
        // Optional: Add JavaScript for better UX
        const loginForm = document.getElementById('loginForm');
        loginForm.addEventListener('submit', (e) => {
            const email = loginForm.email.value.trim();
            const password = loginForm.password.value.trim();

            if (!email || !password) {
                e.preventDefault();
                alert('Email dan password harus diisi!');
            }
        });
    </script>
</body>
</html>