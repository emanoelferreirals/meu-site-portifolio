-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS portfolio_emanoel;
USE portfolio_emanoel;

-- Tabela de usuários admin
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de projetos
CREATE TABLE projetos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    tecnologias JSON,
    link_codigo VARCHAR(255),
    link_demo VARCHAR(255),
    imagem VARCHAR(255),
    ativo BOOLEAN DEFAULT TRUE,
    ordem INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de tecnologias/skills
CREATE TABLE tecnologias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    icone VARCHAR(50) NOT NULL,
    descricao TEXT,
    nivel INT DEFAULT 1,
    ativo BOOLEAN DEFAULT TRUE,
    ordem INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de contatos/mensagens
CREATE TABLE contatos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    mensagem TEXT NOT NULL,
    lida BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de configurações do site
CREATE TABLE configuracoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chave VARCHAR(50) NOT NULL UNIQUE,
    valor TEXT,
    descricao VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Inserir usuário admin padrão (senha: admin123)
INSERT INTO usuarios (username, password, email) VALUES 
('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin@emanoel.dev');

-- Inserir tecnologias padrão
INSERT INTO tecnologias (nome, icone, descricao, nivel, ordem) VALUES
('JavaScript', '🟨', 'Desenvolvimento frontend com foco em interatividade', 4, 1),
('PHP', '🐘', 'Criação de sistemas web e APIs básicas', 3, 2),
('HTML', '🌐', 'Estruturação de páginas web responsivas', 5, 3),
('CSS', '🎨', 'Estilização e design responsivo', 4, 4),
('Java', '☕', 'Desenvolvimento de aplicações desktop e mobile', 3, 5),
('Python', '🐍', 'Scripts, automação e desenvolvimento web', 3, 6),
('Banco de Dados', '🗄️', 'Trabalho com MySQL e design básico de schemas', 3, 7);

-- Inserir projetos exemplo
INSERT INTO projetos (titulo, descricao, tecnologias, link_codigo, link_demo, ordem) VALUES
('Sistema de Controle de Tarefas', 'Aplicação web para gerenciamento de tarefas com interface intuitiva e funcionalidades avançadas.', '["JavaScript", "PHP", "MySQL"]', '#', '#', 1),
('Site Institucional', 'Website responsivo para empresa local com design moderno e otimização SEO.', '["HTML", "CSS", "JavaScript"]', '#', '#', 2),
('API REST em Python', 'API robusta para sistema de e-commerce com autenticação e documentação completa.', '["Python", "Flask", "PostgreSQL"]', '#', '#', 3),
('App Android Básico', 'Aplicativo mobile para controle financeiro pessoal com interface nativa.', '["Java", "Android SDK", "SQLite"]', '#', '#', 4);

-- Inserir configurações padrão
INSERT INTO configuracoes (chave, valor, descricao) VALUES
('site_titulo', 'Emanoel - Desenvolvedor | Portfólio', 'Título do site'),
('site_descricao', 'Portfólio de Emanoel, estudante de TI e desenvolvedor apaixonado por programação', 'Descrição do site'),
('nome_completo', 'Emanoel', 'Nome completo'),
('profissao', 'Programador e Desenvolvedor', 'Profissão/Título'),
('sobre_texto', 'Sou estudante de TI no IFSertãoPE, apaixonado por programação e tecnologia. Estou sempre em busca de novos conhecimentos e oportunidades para aplicar o que aprendo em projetos práticos e desafiadores.', 'Texto sobre'),
('instagram', 'https://instagram.com/emanoel.dev', 'Link do Instagram'),
('linkedin', '#', 'Link do LinkedIn'),
('github', '#', 'Link do GitHub'),
('email', 'emanoel@email.com', 'Email de contato');