# O que é o Testcontainers

**Testcontainers** é uma biblioteca/framework que permite criar ambientes reais de teste usando containers Docker durante a execução dos testes automatizados.

Em vez de usar bancos em memória ou mocks, ele sobe dependências reais — como PostgreSQL, Redis, Kafka ou Elasticsearch — dentro de containers temporários.

Exemplo:

* Sua aplicação Python precisa de PostgreSQL
* O Testcontainers inicia um container PostgreSQL automaticamente
* Os testes executam usando esse banco real
* Ao finalizar, o container é removido