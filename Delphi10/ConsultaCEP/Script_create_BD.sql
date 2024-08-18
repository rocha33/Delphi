CREATE TABLE cep (
    codigo             INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cep                VARCHAR(8) NOT NULL,
    logradouro         VARCHAR(200),
    complemento        VARCHAR(50),
    bairro             VARCHAR(100),
    localidade         VARCHAR(100),
    uf                 CHAR(2),
    usuario            INT,
    datahoraalteracao  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_cep (cep),
    INDEX idx_logradouro (logradouro),
    INDEX idx_bairro (bairro),
    INDEX idx_localidade (localidade),
    INDEX idx_uf (uf)
);