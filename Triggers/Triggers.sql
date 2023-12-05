create database livraria;

----------------------------------------------------------------

use livraria;

----------------------------------------------------------------
CREATE TABLE Autores (
    ID_Autor INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    DataNascimento DATE,
    Nacionalidade VARCHAR(50)
);

----------------------------------------------------------------

CREATE TABLE Editoras (
    ID_Editora INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Logradouro VARCHAR(100),
	Numero INT,
	Cidade VARCHAR(100),
	Estado VARCHAR(2),
    TelefoneEditora VARCHAR(17)
);

----------------------------------------------------------------

CREATE TABLE Livros (
    ID_Livro INT PRIMARY KEY,
    Titulo VARCHAR(255) NOT NULL,
    AnoPublicacao INT,
    ID_Autor INT,
    ID_Editora INT,
    FOREIGN KEY (ID_Autor) REFERENCES Autores(ID_Autor),
    FOREIGN KEY (ID_Editora) REFERENCES Editoras(ID_Editora)
);

----------------------------------------------------------------

CREATE TABLE LogMensagens (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Mensagem TEXT,
    DataRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----------------------------------------------------------------

INSERT INTO Autores (ID_Autor, Nome, DataNascimento, Nacionalidade)
VALUES
    (1, 'Carlos Santos Silva', '1980-03-15', 'Brasileiro'),
    (2, 'Ana Lima Pereira', '1988-08-20', 'Brasileiro'),
    (3, 'Rafael Oliveira Costa', '1975-05-10', 'Brasileiro');

----------------------------------------------------------------

INSERT INTO Editoras (ID_Editora, Nome, Logradouro, Numero, Cidade, Estado, TelefoneEditora)
VALUES
    (1, 'Editora WebBrasil', 'Avenida Cais do Apolo', 77, 'Recife', 'PE', '+55-81-99876-5432'),
    (2, 'Livraria Codificação Nacional', 'Avenida Paulista', 1811, 'Bela Vista', 'SP', '+55-11-98765-4321'),
    (3, 'Publicações ByteBrasil', 'Rua da Gloria', 190, 'Gloria', 'RJ', '+55-21-97654-3210');

----------------------------------------------------------------

INSERT INTO Livros (ID_Livro, Titulo, AnoPublicacao, ID_Autor, ID_Editora)
VALUES
    (1, 'Construindo Páginas Web Modernas', 2019, 1, 1),
    (2, 'CSS Criativo: Estilos Além do Básico', 2021, 2, 2),
    (3, 'Javascript Avançado para Desenvolvedores Web', 2020, 3, 3),
	(4, 'Python para Ciência de Dados', 2022, NULL, 1),
    (5, 'Front-end Development with React', 2019, 2, NULL),
    (6, 'Programação Funcional em Haskell', 2020, NULL, 3),
    (7, 'Mobile App Development with Flutter', 2021, 3, NULL),
    (8, 'Machine Learning em Python', 2018, 2, NULL);

---------------------------------------------------------------------------------------------------

select * from autores;

select * from editoras;

select * from livros;


----------------------------------------------------------------


DELIMITER //
CREATE TRIGGER tr_AposInsertLivro
AFTER INSERT ON Livros
FOR EACH ROW
BEGIN
    -- Obter o nome do autor
    SET @autor_nome = (SELECT Nome FROM Autores WHERE ID_Autor = NEW.ID_Autor);

    -- Obter o nome da editora
    SET @editora_nome = (SELECT Nome FROM Editoras WHERE ID_Editora = NEW.ID_Editora);

    -- Imprimir mensagem indicando a inserção do livro
    INSERT INTO LogMensagens (Mensagem)
    VALUES (CONCAT('Novo livro inserido: ', NEW.Titulo, '. Autor: ', @autor_nome, '. Editora: ', @editora_nome));
END;
//
DELIMITER ;



---------------------------------------------------------------------------------------------------

select * from logmensagens;


---------------------------------------------------------------------------------------------------

INSERT INTO Livros (ID_Livro, Titulo, AnoPublicacao, ID_Autor, ID_Editora)
VALUES
    (9, 'Introdução à Programação com Python', 2019, 2, 1),
    (10, 'Código Limpo', 2009, 3, 2);
	
---------------------------------------------------------------------------------------------------

select * from logmensagens;

---------------------------------------------------------------------------------------------------	