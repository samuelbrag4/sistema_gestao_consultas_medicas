# Atividade 03 - 👩‍⚕️ Sistema de Gestão de Consultas Médicas 👨‍⚕️

Este projeto é um sistema de gestão de consultas médicas, que permite gerenciar pacientes, médicos e consultas. O banco de dados utilizado é o PostgreSQL.

## Estrutura do Banco de Dados 📦

O banco de dados é composto por três tabelas principais:

1. **pacientes 🤒**: Armazena informações sobre os pacientes.
2. **medicos 👩‍⚕️👨‍⚕️**: Armazena informações sobre os médicos.
3. **consultas 📋**: Armazena informações sobre as consultas realizadas.

### Tabelas 📂

#### Tabela `Pacientes`

```sql
CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(150) NOT NULL
);
```

### Tabela `Médicos`

```sql
CREATE TABLE medicos (
    id_medico SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL
);
```
### Tabela `Consultas`

```sql
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
```

## Consultas SQL 📚

### Listar todas as consultas:

```sql
SELECT * FROM consultas;
```

### Listar pacientes que já tiveram consultas realizadas

```sql
SELECT p.nome AS nome_paciente, m.nome AS nome_medico, c.data_consulta, m.especialidade
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id_paciente
JOIN medicos m ON c.id_medico = m.id_medico
WHERE c.data_consulta <= CURRENT_DATE;
```

### Mostrar todos os pacientes que não realizaram nenhuma consulta (passadas ou futuras)

```sql
SELECT p.nome AS paciente, p.cpf, p.data_nascimento, p.email
FROM pacientes p
LEFT JOIN consultas c ON p.id_paciente = c.id_paciente
WHERE c.id_paciente IS NULL;
```

### Listar médicos que ainda não realizaram nenhuma consulta

```sql
SELECT m.nome AS nome_medico, m.especialidade
FROM medicos m
LEFT JOIN consultas c ON m.id_medico = c.id_medico
WHERE c.id_medico IS NULL;
```

## Inserção de Dados

### Inserir dados na tabela `pacientes`

```sql
INSERT INTO pacientes (nome, cpf, data_nascimento, email) VALUES 
('Samuel', '12345682501', '1995-06-01', 'samuel@exemplo.com'),
('Nathalia', '12345682501', '1995-06-01', 'nathalia@exemplo.com'),
('Fernanda', '83764232109', '1990-01-01', 'fernanda@exemplo.com');
```

### Inserir dados na tabela `medicos`

```sql
INSERT INTO medicos (nome, cpf, especialidade, email) VALUES 
('Felipe', '11931745901', 'Clínico Geral', 'felipe@exemplo.com'),
('Eduardo', '98291264210', 'Pediatra', 'eduardo@exemplo.com'),
('Marcelo', '45647295305', 'Dermatologista', 'marcelo@exemplo.com');
```

### Inserir dados na tabela `consultas`

```sql
INSERT INTO consultas (id_paciente, id_medico, data_consulta, horario, valor) VALUES 
(2, 2, '2022-10-15', '09:30', 200.00),
(3, 1, '2021-07-23', '10:00', 250.00),
(1, 3, '2024-01-27', '10:30', 400.00);
```
