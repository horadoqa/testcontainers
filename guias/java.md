# Guia passo a passo — Executando Testcontainers

## O que é o Testcontainers

**Testcontainers** é uma biblioteca/framework que permite criar ambientes reais de teste usando containers Docker durante a execução dos testes automatizados.

Em vez de usar bancos em memória ou mocks, ele sobe dependências reais — como PostgreSQL, Redis, Kafka ou Elasticsearch — dentro de containers temporários.

Exemplo:

* Sua aplicação precisa de PostgreSQL
* O Testcontainers inicia um container PostgreSQL automaticamente
* Os testes executam usando esse banco real
* Ao finalizar, o container é removido

---

# Pré-requisitos

Antes de executar o Testcontainers, é necessário configurar o ambiente.

## 1. Instalar o Docker

O Testcontainers depende do Docker para criar os containers de teste.

Instale o Docker Desktop ou Docker Engine:

* Windows/Mac:
  [Docker Desktop](https://www.docker.com/products/docker-desktop/?utm_source=chatgpt.com)

* Linux:
  [Docker Engine](https://docs.docker.com/engine/install/?utm_source=chatgpt.com)

---

## 2. Verificar se o Docker está funcionando

Após a instalação, execute no terminal:

```bash
docker --version
```

Exemplo esperado:

```bash
Docker version 29.2.1, build a5c7197
```

Agora valide se o serviço está ativo:

```bash
docker ps
```

Se o comando responder normalmente, o Docker está pronto.

---

## 3. Instalar o Java (caso o projeto utilize Java)

Verifique a versão instalada:

```bash
java -version
```

Caso necessário:

* Java/JDK:
  [OpenJDK Downloads](https://jdk.java.net/?utm_source=chatgpt.com)

---

## 4. Instalar o Maven ou Gradle

### Maven

Verifique:

```bash
mvn -version
```

Instalação:

[Apache Maven](https://maven.apache.org/download.cgi?utm_source=chatgpt.com)

### Gradle

Verifique:

```bash
gradle -version
```

Instalação:

[Gradle](https://gradle.org/install/?utm_source=chatgpt.com)

---

# Passo a passo para executar o Testcontainers

## Passo 1 — Adicionar a dependência do Testcontainers

### Maven

No arquivo `pom.xml`:

```xml
<dependencies>
    
    <dependency>
        <groupId>org.testcontainers</groupId>
        <artifactId>junit-jupiter</artifactId>
        <version>1.21.0</version>
        <scope>test</scope>
    </dependency>

    <dependency>
        <groupId>org.testcontainers</groupId>
        <artifactId>postgresql</artifactId>
        <version>1.21.0</version>
        <scope>test</scope>
    </dependency>

</dependencies>
```

---

### Gradle

No arquivo `build.gradle`:

```gradle
testImplementation 'org.testcontainers:junit-jupiter:1.21.0'
testImplementation 'org.testcontainers:postgresql:1.21.0'
```

---

## Passo 2 — Criar um teste com container PostgreSQL

Exemplo usando JUnit 5:

```java
import org.junit.jupiter.api.Test;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

@Testcontainers
public class UsuarioRepositoryTest {

    @Container
    static PostgreSQLContainer<?> postgres =
            new PostgreSQLContainer<>("postgres:16")
                    .withDatabaseName("testdb")
                    .withUsername("admin")
                    .withPassword("admin");

    @Test
    void deveConectarNoBanco() {

        System.out.println(postgres.getJdbcUrl());
        System.out.println(postgres.getUsername());
        System.out.println(postgres.getPassword());

    }
}
```

---

## Passo 3 — Executar os testes

### Maven

```bash
mvn test
```

### Gradle

```bash
gradle test
```

---

# O que acontece durante a execução

Quando o teste inicia:

1. O Testcontainers se conecta ao Docker
2. O container PostgreSQL é baixado (se ainda não existir)
3. O banco sobe automaticamente
4. O teste executa usando o banco real
5. O container é destruído ao final

---

# Validando se funcionou

Durante a execução você verá logs parecidos com:

```bash
Pulling docker image: postgres:16
Container started
Running tests...
Container stopped
```

Também é possível verificar os containers ativos:

```bash
docker ps
```

---

# Problemas comuns

## Docker não iniciado

Erro comum:

```bash
Could not find a valid Docker environment
```

Solução:

* Abrir o Docker Desktop
* Validar com:

```bash
docker ps
```

---

## Porta ocupada

Caso exista conflito de portas:

```bash
Bind for 0.0.0.0:5432 failed
```

O Testcontainers normalmente resolve isso automaticamente usando portas aleatórias.

---

## Imagem não encontrada

Erro:

```bash
manifest for postgres:16 not found
```

Solução:

* Verificar o nome e versão da imagem Docker

---

# Benefícios do Testcontainers

* Ambiente de teste real
* Isolamento entre testes
* Menos problemas de ambiente
* Fácil integração com CI/CD
* Containers temporários e limpos
* Reproduz comportamento de produção

---

# Tecnologias suportadas

O Testcontainers possui módulos prontos para:

* PostgreSQL
* MySQL
* MongoDB
* Redis
* Kafka
* Elasticsearch
* RabbitMQ
* LocalStack
* Oracle
* Neo4j

Documentação oficial:

[Testcontainers Documentation](https://testcontainers.com/?utm_source=chatgpt.com)
