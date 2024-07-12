# Usando uma imagem base oficial do Python.
FROM python:3.10

# Configurando o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copiando o arquivo de configuração do Poetry para o contêiner.
COPY poetry.lock pyproject.toml /app/

# Instalando o Poetry.
RUN pip install poetry

# Instalando as dependências do projeto.
RUN poetry config virtualenvs.create false && poetry install

# Copiando o restante do código do aplicativo.
COPY . /app/

# Definindo as variáveis de ambiente
ENV DEBUG=1
ENV SECRET_KEY=foo
ENV DJANGO_ALLOWED_HOSTS="localhost 127.0.0.1"
ENV SQL_ENGINE=django.db.backends.postgresql
ENV SQL_DATABASE=bookstore_dev_db
ENV SQL_USER=bookstore_dev
ENV SQL_PASSWORD=bookstore_dev
ENV SQL_HOST=db
ENV SQL_PORT=5432

# Coletando os arquivos estáticos
RUN python manage.py collectstatic --noinput

# Expondo a porta 8000 para o serviço web.
EXPOSE 8000

# Comando padrão para iniciar o servidor usando Gunicorn.
CMD ["gunicorn", "bookstore.wsgi:application", "--bind", "0.0.0.0:8000"]
