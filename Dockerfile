# Usar imagem base oficial do Python
FROM python:3.12-slim as python-base
# Definindo variáveis de ambiente
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
# Atualizar e instalar dependências necessárias
RUN apt-get update \
    && apt-get install -y curl build-essential libpq-dev \
    && apt-get clean
# Instalar Poetry usando o novo script
RUN curl -sSL https://install.python-poetry.org | python3 -
# Adicionar Poetry ao PATH
ENV PATH="/root/.local/bin:$PATH"
# Definir o diretório de trabalho no contêiner
WORKDIR /app
# Copiar os arquivos de requisitos e instalá-los
COPY poetry.lock pyproject.toml /app/
RUN poetry install --no-root
# Copiar o restante do código da aplicação
COPY . /app/
# Expor a porta que a aplicação irá rodar
EXPOSE 8000
# Comando para rodar a aplicação
CMD ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]
