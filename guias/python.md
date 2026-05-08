# Guia passo a passo — Executando Testcontainers com Python

## O que é o Testcontainers

**Testcontainers** é uma biblioteca/framework que permite criar ambientes reais de teste usando containers Docker durante a execução dos testes automatizados.

Em vez de usar bancos em memória ou mocks, ele sobe dependências reais — como PostgreSQL, Redis, Kafka ou Elasticsearch — dentro de containers temporários.

Exemplo:

* Sua aplicação Python precisa de PostgreSQL
* O Testcontainers inicia um container PostgreSQL automaticamente
* Os testes executam usando esse banco real
* Ao finalizar, o container é removido

---

# Pré-requisitos

Antes de executar o Testcontainers, é necessário configurar o ambiente.

---

## 1. Instalar o Docker

O Testcontainers depende do Docker para criar os containers de teste.

### Windows/Mac

[Docker Desktop](https://www.docker.com/products/docker-desktop/?utm_source=chatgpt.com)

### Linux

[Docker Engine](https://docs.docker.com/engine/install/?utm_source=chatgpt.com)

---

## 2. Verificar se o Docker está funcionando

Após a instalação, execute no terminal:

```bash
docker --version
```

Exemplo esperado:

```bash
Docker version 29.x.x
```

Agora valide se o serviço está ativo:

```bash
docker ps
```

Se o comando responder normalmente, o Docker está pronto.

---

## 3. Instalar o Python

Verifique a versão instalada:

```bash id="0vgffn"
python --version
```

ou

```bash id="3m0dmr"
python3 --version
```

Caso necessário:

[Python Downloads](https://www.python.org/downloads/?utm_source=chatgpt.com)

---

## 4. Criar um ambiente virtual (recomendado)

### Linux/Mac

```bash
python3 -m venv venv
source venv/bin/activate
```

### Windows

```bash
python -m venv venv
venv\Scripts\activate
```

---

## 5. Instalar as dependências

Instale o Testcontainers, pytest e o driver PostgreSQL:

```bash
pip install testcontainers pytest psycopg2-binary
```

---

# Passo a passo para executar o Testcontainers

## Passo 1 — Estrutura do projeto

Exemplo:

```text
meu-projeto/
│
├── tests/
│   └── test_database.py
│
└── requirements.txt
```

---

## Passo 2 — Criar um teste com PostgreSQL

Arquivo:

```text
tests/test_database.py
```

Conteúdo:

```python
from testcontainers.postgres import PostgresContainer
import psycopg2


def test_conexao_postgres():

    with PostgresContainer("postgres:16") as postgres:

        connection = psycopg2.connect(
            host=postgres.get_container_host_ip(),
            port=postgres.get_exposed_port(5432),
            database=postgres.dbname,
            user=postgres.username,
            password=postgres.password,
        )

        cursor = connection.cursor()

        cursor.execute("SELECT version();")

        resultado = cursor.fetchone()

        print(resultado)

        assert resultado is not None

        connection.close()
```

---

# Como funciona esse teste

Quando o teste inicia:

1. O Testcontainers cria um container PostgreSQL
2. O PostgreSQL sobe automaticamente
3. O Python conecta no banco real
4. O teste executa comandos SQL reais
5. O container é removido automaticamente

---

# Passo 3 — Executar os testes

Execute:

```bash
pytest -v
```

---

# Resultado esperado

Exemplo de saída:

```bash
================= test session starts =================

tests/test_database.py::test_conexao_postgres PASSED

================= 1 passed =================
```

---

# Validando os containers em execução

Durante o teste você pode verificar:

```bash
docker ps
```

Você verá um container PostgreSQL temporário sendo executado.

---

# O que acontece internamente

Fluxo completo:

1. O pytest inicia
2. O Testcontainers conversa com o Docker
3. O Docker baixa a imagem `postgres:16`
4. O container PostgreSQL sobe
5. O teste conecta usando `psycopg2`
6. O teste executa
7. O container é destruído automaticamente

---

# Problemas comuns

## Docker não iniciado

Erro comum:

```bash
Could not find a valid Docker environment
```

Solução:

* Abrir o Docker Desktop
* Verificar:

```bash
docker ps
```

---

## Dependência não instalada

Erro:

```bash
ModuleNotFoundError: No module named 'testcontainers'
```

Solução:

```bash
pip install testcontainers
```

---

## PostgreSQL não conecta

Erro:

```bash
connection refused
```

Possíveis causas:

* Docker não iniciado
* Imagem não baixada corretamente
* Firewall bloqueando Docker

---

## Imagem Docker inexistente

Erro:

```bash
manifest for postgres:16 not found
```

Solução:

* Verificar a versão da imagem PostgreSQL

---

# Benefícios do Testcontainers com Python

* Testes mais próximos da produção
* Containers isolados
* Ambiente reproduzível
* Menos mocks
* Fácil integração com CI/CD
* Execução automatizada
* Banco de dados real durante os testes

---

# Tecnologias suportadas

O Testcontainers para Python suporta:

* PostgreSQL
* MySQL
* MongoDB
* Redis
* Kafka
* Elasticsearch
* RabbitMQ
* LocalStack
* Neo4j

---

# Documentação oficial

* [Testcontainers for Python](https://testcontainers-python.readthedocs.io/?utm_source=chatgpt.com)
* [Pytest Documentation](https://docs.pytest.org/?utm_source=chatgpt.com)
* [psycopg2 Documentation](https://www.psycopg.org/docs/?utm_source=chatgpt.com)
