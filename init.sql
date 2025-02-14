-- Cria o banco de dados wise-wallet
CREATE DATABASE "wise-wallet";

-- Conecta ao banco de dados wise-wallet
\c "wise-wallet"

-- Cria a tabela de transações
CREATE TABLE transacoes (
    id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    valor NUMERIC(10, 2) NOT NULL,
    identificador UUID NOT NULL UNIQUE,
    descricao TEXT NOT NULL,
    categoria VARCHAR(100) NOT NULL
);