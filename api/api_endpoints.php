<?php
// api/index.php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

require_once '../config/database.php';

$database = new Database();
$db = $database->getConnection();

$action = $_GET['action'] ?? '';

switch ($action) {
    case 'projetos':
        getProjetos();
        break;
    case 'tecnologias':
        getTecnologias();
        break;
    case 'contato':
        saveContato();
        break;
    case 'config':
        getConfiguracoes();
        break;
    default:
        jsonResponse(['error' => 'Ação não encontrada'], 404);
}

function getProjetos() {
    global $db;
    
    try {
        $stmt = $db->prepare("SELECT * FROM projetos WHERE ativo = 1 ORDER BY ordem ASC");
        $stmt->execute();
        $projetos = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Decodificar JSON das tecnologias
        foreach ($projetos as &$projeto) {
            $projeto['tecnologias'] = json_decode($projeto['tecnologias'], true);
        }
        
        jsonResponse($projetos);
    } catch (Exception $e) {
        jsonResponse(['error' => 'Erro ao buscar projetos'], 500);
    }
}

function getTecnologias() {
    global $db;
    
    try {
        $stmt = $db->prepare("SELECT * FROM tecnologias WHERE ativo = 1 ORDER BY ordem ASC");
        $stmt->execute();
        $tecnologias = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        jsonResponse($tecnologias);
    } catch (Exception $e) {
        jsonResponse(['error' => 'Erro ao buscar tecnologias'], 500);
    }
}

function saveContato() {
    global $db;
    
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        jsonResponse(['error' => 'Método não permitido'], 405);
    }
    
    $input = json_decode(file_get_contents('php://input'), true);
    
    $nome = sanitize($input['nome'] ?? '');
    $email = sanitize($input['email'] ?? '');
    $mensagem = sanitize($input['mensagem'] ?? '');
    
    if (empty($nome) || empty($email) || empty($mensagem)) {
        jsonResponse(['error' => 'Todos os campos são obrigatórios'], 400);
    }
    
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        jsonResponse(['error' => 'Email inválido'], 400);
    }
    
    try {
        $stmt = $db->prepare("INSERT INTO contatos (nome, email, mensagem) VALUES (?, ?, ?)");
        $stmt->execute([$nome, $email, $mensagem]);
        
        jsonResponse(['success' => 'Mensagem enviada com sucesso!']);
    } catch (Exception $e) {
        jsonResponse(['error' => 'Erro ao salvar mensagem'], 500);
    }
}

function getConfiguracoes() {
    global $db;
    
    try {
        $stmt = $db->prepare("SELECT chave, valor FROM configuracoes");
        $stmt->execute();
        $configs = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);
        
        jsonResponse($configs);
    } catch (Exception $e) {
        jsonResponse(['error' => 'Erro ao buscar configurações'], 500);
    }
}
?>