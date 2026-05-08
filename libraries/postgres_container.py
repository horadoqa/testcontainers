from testcontainers.postgres import PostgresContainer
import psycopg2

class PostgresContainerLibrary:

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self.postgres = None
        self.conn = None

    def start_postgres_container(self):
        print("STARTING POSTGRES CONTAINER")

        try:
            self.postgres = PostgresContainer("postgres:16")
            self.postgres.start()

            self.conn = psycopg2.connect(
                host=self.postgres.get_container_host_ip(),
                port=self.postgres.get_exposed_port(5432),
                database=self.postgres.dbname,
                user=self.postgres.username,
                password=self.postgres.password
            )

            print("CONTAINER STARTED SUCCESSFULLY")

            return {
                "conn": self.conn,
                "host": self.postgres.get_container_host_ip(),
                "port": self.postgres.get_exposed_port(5432),
                "dbname": self.postgres.dbname,
                "user": self.postgres.username,
                "password": self.postgres.password
            }
        except Exception as e:
            print(f"ERROR STARTING POSTGRES: {e}")
            raise

    def insert_user(self, nome, data_nascimento, sexo, estado_civil, naturalidade, nacionalidade):
        with self.conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO usuarios
                (nome, data_nascimento, sexo, estado_civil, naturalidade, nacionalidade)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
                (nome, data_nascimento, sexo, estado_civil, naturalidade, nacionalidade)
            )
            self.conn.commit()

    def stop_postgres_container(self):
        if self.postgres:
            self.postgres.stop()
    
    def close_connection(self):
        if self.conn:
            self.conn.close()
