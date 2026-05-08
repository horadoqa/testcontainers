# 📌 Projeto: Pipeline completo com Testcontainers, Robot Framework e CI/CD

Crie um projeto completo utilizando **Python, Robot Framework, Testcontainers e GitHub Actions**, contendo backend, testes automatizados e frontend simples.

---

## 🧱 1. Backend + Banco de Dados

* Utilizar **Python (FastAPI ou Flask)**

* Utilizar **Testcontainers** para provisionar um banco de dados PostgreSQL em ambiente de teste

* Criar uma tabela chamada `usuarios` com os campos:

  * id (auto incremento)
  * nome (string)
  * data_nascimento (date)
  * sexo (string)
  * estado_civil (string)
  * naturalidade (string)
  * nacionalidade (string)

* Criar um script que:

  * Gere **100 registros fictícios**
  * Insira esses registros na tabela

---

## 🧪 2. Testes Automatizados

* Utilizar **Robot Framework**

* Validar:

  * Criação da tabela
  * Inserção dos 100 registros
  * Consulta dos dados no banco

* Os testes devem rodar usando **Testcontainers (container isolado de banco)**

---

## 🌐 3. Frontend

* Criar um frontend simples (HTML + JavaScript ou React)
* Consumir uma API do backend
* Exibir uma tabela com os 100 registros da tabela `usuarios`

---

## ⚙️ 4. CI/CD com GitHub Actions

O pipeline deve:

1. Subir ambiente de testes com Testcontainers
2. Executar testes Robot Framework
3. Executar seed de dados (100 registros)
4. Build do frontend
5. Publicar frontend (GitHub Pages)

---

## 📄 5. README

O README deve conter:

* Pré-requisitos (Python, Docker, etc.)
* Como rodar localmente
* Como rodar testes
* Como funciona o pipeline
* Como acessar o frontend
* Diagrama simples da arquitetura (opcional, mas recomendado)

---

## ⭐ Extras (diferencial)

* Faker para gerar dados realistas
* Logs estruturados
* Docker Compose para execução local
* Cobertura de testes
* Lint (flake8/ruff)

---
