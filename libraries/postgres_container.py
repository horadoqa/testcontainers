from testcontainers.postgres import PostgresContainer

class PostgresLibrary:

    def __init__(self):
        self.postgres = None

    def start_postgres_container(self):
        self.postgres = PostgresContainer("postgres:16")
        self.postgres.start()

        return {
            "host": self.postgres.get_container_host_ip(),
            "port": self.postgres.get_exposed_port(5432),
            "dbname": self.postgres.dbname,
            "user": self.postgres.username,
            "password": self.postgres.password
        }

    def stop_postgres_container(self):
        if self.postgres:
            self.postgres.stop()