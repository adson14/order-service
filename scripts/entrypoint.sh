#!/bin/bash

echo "🔧 Configurando Git..."
if [ -f "setup-git.sh" ]; then
  chmod +x setup-git.sh
  ./setup-git.sh
fi


echo "🔧 Configurando permissões..."
sudo chown -R node:node /app

echo "📦 Verificando dependências..."
if [ ! -d "node_modules" ] || [ -z "$(ls -A node_modules)" ]; then
  echo "📦 Instalando dependências..."
  npm install
else
  echo "✅ Dependências já instaladas."
fi


if [ ! -f .env ]; then
  echo "Criando arquivo .env a partir do .env.example..."
  cp .env.example .env
  echo "Arquivo .env criado com sucesso!"
else
  echo "Arquivo .env já existe. Usando o existente."
fi


echo "🧹 Limpando cache de build..."
rm -rf dist

echo "🔨 Compilando TypeScript..."
npm run build

echo "🚀 Iniciando em modo desenvolvimento (hot reload)..."
npm run start:dev