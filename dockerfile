# Utilise une image légère basée sur Python
FROM python:3.10-slim

# Empêche les interactions pendant les installations
ENV DEBIAN_FRONTEND=noninteractive

# Installation des dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libprotobuf-dev \
    protobuf-compiler \
    git \
    && rm -rf /var/lib/apt/lists/*

# Crée un dossier de travail dans le conteneur
WORKDIR /app

# Copie les fichiers dans le conteneur
COPY . /app

# Installe les dépendances Python
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Expose le port de l'application FastAPI
EXPOSE 8000

# Commande pour démarrer l'application
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]
