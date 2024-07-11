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

# Expondo a porta 8000 para o serviço web.
EXPOSE 8000

# Comando padrão para iniciar o servidor Django.
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
