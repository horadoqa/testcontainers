---
name: testcontainers-robot-pipeline
description: >
  Use esta skill para criar projetos completos com Python, Robot Framework,
  Testcontainers e CI/CD com GitHub Actions. Acione sempre que o usuário
  mencionar: Testcontainers, Robot Framework com banco de dados isolado,
  pipeline CI/CD com testes de integração, seed de dados com Faker,
  FastAPI/Flask com PostgreSQL em container, frontend consumindo API com
  tabela de registros, GitHub Actions com GitHub Pages, Docker Compose para
  testes locais, ou qualquer combinação dessas tecnologias. Também acione
  quando o usuário pedir "projeto completo de testes", "pipeline de qualidade",
  "backend + testes + frontend" ou "infraestrutura de testes com containers".
---

# Pipeline Completo: Testcontainers + Robot Framework + CI/CD

## Visão Geral

Esta skill gera um projeto production-ready com:
- **Backend**: FastAPI + PostgreSQL via Testcontainers
- **Testes**: Robot Framework com container isolado
- **Seed**: 100 registros fictícios com Faker
- **Frontend**: HTML/JS consumindo a API
- **CI/CD**: GitHub Actions → GitHub Pages
- **Extras**: Docker Compose, logs estruturados, lint (ruff/flake8)

---

## Estrutura do Projeto Gerado

```
project-root/
├── backend/
│   ├── main.py              # FastAPI app
│   ├── database.py          # Conexão e ORM
│   ├── models.py            # Modelo Usuario
│   ├── seed.py              # Gerador de 100 registros com Faker
│   └── requirements.txt
├── tests/
│   ├── robot/
│   │   ├── usuarios.robot   # Test suites Robot Framework
│   │   └── resources/
│   │       └── db_keywords.robot
│   └── conftest.py          # Fixtures Testcontainers
├── frontend/
│   ├── index.html
│   └── app.js
├── docker-compose.yml
├── .github/
│   └── workflows/
│       └── pipeline.yml
├── pyproject.toml           # ruff + flake8 config
└── README.md
```

---

## Passo a Passo de Geração

### 1. Backend (FastAPI + PostgreSQL)

Leia `references/backend.md` para os templates completos de código.

**Pontos-chave:**
- Usar `SQLAlchemy` com `psycopg2-binary`
- Variável de ambiente `DATABASE_URL` para configurar conexão
- Endpoint `GET /usuarios` retorna lista paginável
- Endpoint `POST /seed` dispara criação dos 100 registros
- Logs estruturados com `structlog` ou `logging` com formato JSON

### 2. Testcontainers + Robot Framework

Leia `references/tests.md` para fixtures e keywords completas.

**Pontos-chave:**
- `testcontainers[postgres]` provisiona PostgreSQL limpo por suite
- `conftest.py` expõe `DATABASE_URL` via variável de ambiente
- Robot Framework usa `DatabaseLibrary` para validações SQL
- Três suites: criação de tabela, inserção de registros, consulta

### 3. Seed com Faker

```python
from faker import Faker
fake = Faker('pt_BR')

def gerar_usuario():
    return {
        "nome": fake.name(),
        "data_nascimento": str(fake.date_of_birth(minimum_age=18, maximum_age=80)),
        "sexo": fake.random_element(['M', 'F']),
        "estado_civil": fake.random_element(['Solteiro', 'Casado', 'Divorciado', 'Viúvo']),
        "naturalidade": fake.city(),
        "nacionalidade": "Brasileira",
    }
```

### 4. Frontend (HTML + JS)

Leia `references/frontend.md` para o template completo.

**Pontos-chave:**
- Fetch para `GET /usuarios`
- Tabela responsiva com todos os campos
- Loading state e tratamento de erro
- Deploy via GitHub Pages (pasta `/frontend` ou branch `gh-pages`)

### 5. GitHub Actions Pipeline

Leia `references/cicd.md` para o workflow completo.

**Sequência obrigatória:**
1. `actions/checkout`
2. Setup Python + cache pip
3. Instalar dependências (incluindo Testcontainers)
4. Subir serviço Docker-in-Docker ou usar `services: postgres`
5. Rodar `robot --outputdir results tests/robot/`
6. Executar `python backend/seed.py`
7. Build frontend (copiar para `/docs` ou usar artifact)
8. Deploy GitHub Pages com `peaceiris/actions-gh-pages`

---

## Dependências Principais

```
# backend/requirements.txt
fastapi>=0.111.0
uvicorn[standard]>=0.29.0
sqlalchemy>=2.0.0
psycopg2-binary>=2.9.9
faker>=25.0.0
structlog>=24.1.0
python-dotenv>=1.0.0

# tests/requirements-test.txt
testcontainers[postgres]>=4.7.0
robotframework>=7.0
robotframework-databaselibrary>=1.4.3
pytest>=8.0.0
ruff>=0.4.0
```

---

## Docker Compose (execução local)

```yaml
version: "3.9"
services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: usuario
      POSTGRES_PASSWORD: senha
      POSTGRES_DB: appdb
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U usuario -d appdb"]
      interval: 5s
      timeout: 5s
      retries: 5

  backend:
    build: ./backend
    depends_on:
      db:
        condition: service_healthy
    environment:
      DATABASE_URL: postgresql://usuario:senha@db:5432/appdb
    ports:
      - "8000:8000"
    command: uvicorn main:app --host 0.0.0.0 --port 8000

  frontend:
    image: nginx:alpine
    volumes:
      - ./frontend:/usr/share/nginx/html:ro
    ports:
      - "3000:80"
    depends_on:
      - backend
```

---

## Checklist de Geração

Ao usar esta skill, siga esta ordem:

- [ ] Criar estrutura de diretórios
- [ ] Gerar `backend/` com FastAPI, models, seed
- [ ] Gerar `tests/` com conftest Testcontainers e suites Robot
- [ ] Gerar `frontend/` com HTML/JS consumindo API
- [ ] Gerar `docker-compose.yml`
- [ ] Gerar `.github/workflows/pipeline.yml`
- [ ] Gerar `pyproject.toml` com config ruff
- [ ] Gerar `README.md` completo
- [ ] Validar que todos os arquivos têm conteúdo real (não placeholders)

---

## Referências

- `references/backend.md` — Código completo FastAPI + SQLAlchemy + seed
- `references/tests.md` — Fixtures Testcontainers + keywords Robot Framework
- `references/frontend.md` — HTML/JS template com fetch e tabela
- `references/cicd.md` — GitHub Actions workflow completo