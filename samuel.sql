!-- Criação do banco de dados --!
CREATE DATABASE gestao_consultas_medicas;
!-- Resultado: CREATE DATABASE --!

!-- Conexão com o banco de dados --!
\c gestao_consultas_medicas
!-- Resultado: Você está conectado ao banco de dados "gestao_consultas_medicas" como usuários "postgres".--!

!-- Tabela de pacientes - obriga o paciente a preencher seus dados --!
CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(150) NOT NULL
);
!-- Resultado: CREATE TABLE --!

!-- Consulta para listar os pacientes --!
SELECT * FROM pacientes;
!-- Resultado: id_paciente | nome | cpf | data_nascimento | email --!

!-- Tabela de médicos - obriga o médico a preencher seus dados --!
CREATE TABLE medicos (
    id_medico SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL
);
!-- Resultado: CREATE TABLE --!

!-- Consulta para listar os médicos --!
SELECT * FROM medicos;
!-- Resultado: id_medico | nome | cpf | especialidade | email --!

!-- Tabela de consultas - obriga o paciente e o médico a preencher seus dados --!
CREATE TABLE consultas (
    id_consulta SERIAL PRIMARY KEY,
    id_paciente INTEGER NOT NULL,
    id_medico INTEGER NOT NULL,
    data_consulta DATE NOT NULL,
    horario TIME NOT NULL,
    valor NUMERIC(5,2) NOT NULL,
    CONSTRAINT fk_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
);
!-- Resultado: CREATE TABLE --!

!-- Consulta para listar as consultas --!
SELECT * FROM consultas;
!-- Resultado: id_consulta | id_paciente | id_medico | data_consulta | horario | valor --!

!-- Inserção de dados na tabela de pacientes --!
INSERT INTO pacientes (nome, cpf, data_nascimento, email) VALUES 
('Samuel', '12345682501', '1995-06-01', 'samuel@exemplo.com'),
('Mariana', '83764232109', '1990-01-01', 'mariana@exemplo.com'),
('Thiago', '45673412925', '1985-12-31', 'thiago@exemplo.com');
!-- Resultado: INSERT 0 3 --!

!-- Consulta para listar os pacientes --!
SELECT * FROM pacientes;
!-- Resultado: id_paciente | nome | cpf | data_nascimento | email --!

!-- Inserção de dados na tabela de médicos --!
INSERT INTO medicos (nome, cpf, especialidade, email) VALUES 
('Felipe', '11934678901', 'Clínico Geral', 'felipe@exemplo.com'),
('Eduardo', '98767242109', 'Pediatra', 'eduardo@exemplo.com'),
('Marcelo', '45678015305', 'Dermatologista', 'marcelo@exemplo.com');
!-- Resultado: INSERT 0 3 --!

!-- Consulta para listar os médicos --!
SELECT * FROM medicos;
!-- Resultado: id_medico | nome | cpf | especialidade | email --!

!-- Inserção de dados na tabela de consultas --!
INSERT INTO consultas (id_paciente, id_medico, data_consulta, horario, valor) VALUES 
(2, 2, '2022-10-15', '09:30', 200.00),
(3, 1, '2021-07-23', '10:00', 250.00),
(1, 3, '2024-01-27', '10:30', 400.00);
!-- Resultado: INSERT 0 3 --!

!-- Consulta para listar as consultas --!
SELECT * FROM consultas;
!-- Resultado: id_consulta | id_paciente | id_medico | data_consulta | horario | valor --!

!-- Consulta para listar os pacientes que já tiveram consultas realizadas --!
SELECT p.nome AS nome_paciente, m.nome AS nome_medico, c.data_consulta, m.especialidade
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico
WHERE c.data_consulta <= CURRENT_DATE;
!-- Resultado: nome_paciente | nome_medico | data_consulta | especialidade --!

!-- Consulta para listar TODOS os pacientes (até mesmo os com consultas futuras) --!
SELECT p.nome AS nome_pacientes, m.nome AS nome_medico, c.data_consulta, m.especialidade
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico;
!-- Resultado: nome_paciente | nome_medico | data_consulta | especialidade --!

!-- Consulta para listar os médicos que ainda não realizaram nenhuma consulta --!
SELECT m.nome AS nome_medico, m.especialidade
FROM medicos m
LEFT JOIN consultas c ON m.id_medico = c.id_medico
WHERE c.id_medico IS NULL;
!-- Resultado: nome_medico | especialidade --!