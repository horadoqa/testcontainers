from testcontainers.postgres import PostgresContainer

postgres = None


def start_postgres_container():
    global postgres
    postgres = PostgresContainer(
        "postgres:16",
        dbname="horadoqa-postgresql",
        username="horadoqa",
        password="1q2w3e4r",
    )
    postgres.start()


def get_host():
    return postgres.get_container_host_ip()


def get_port():
    return postgres.get_exposed_port(5432)


def get_dbname():
    return "horadoqa-postgresql"


def get_user():
    return "horadoqa"


def get_password():
    return "1q2w3e4r"


def stop_postgres_container():
    global postgres
    if postgres:
        postgres.stop()