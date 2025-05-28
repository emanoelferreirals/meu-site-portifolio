<?php
// admin/auth.php
require_once '../config/database.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    
    $username = sanitize($input['username'] ?? '');
    $password = $input['password'] ?? '';
    
    if (empty($username) || empty($password)) {
        jsonResponse(['error' => 'Usuário e senha são obrigatórios'], 400);
    }
    
    $database = new Database();
    $db = $database->getConnection();
    
    try {
        $stmt = $db->prepare("SELECT id, username, password FROM usuarios WHERE username = ? LIMIT 1");
        $stmt->execute([$username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($user && password_verify($password, $user['password'])) {
            startSession();
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            
            jsonResponse(['success' => true, 'message' => 'Login realizado com sucesso']);
        } else {
            jsonResponse(['error' => 'Usuário ou senha incorretos'], 401);
        }
    } catch (Exception $e) {
        jsonResponse(['error' => 'Erro interno do servidor'], 500);
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Logout
    startSession();
    session_destroy();
    jsonResponse(['success' => true, 'message' => 'Logout realizado com sucesso']);
} else {
    jsonResponse(['error' => 'Método não permitido'], 405);
}
?>