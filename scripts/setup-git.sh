#!/bin/bash

echo "🔧 Configurando Git..."

if git config --global user.name && git config --global user.email; then
    echo "✅ Git já configurado:"
    echo "Nome: $(git config --global user.name)"
    echo "Email: $(git config --global user.email)"
else
    read -p "Digite seu nome para o Git: " git_name
    read -p "Digite seu email para o Git: " git_email
    
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    
    echo "✅ Git configurado com sucesso!"
fi

git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.autocrlf input
git config --global --add safe.directory /usr/src/app

if [ -f ~/.ssh/id_rsa ] || [ -f ~/.ssh/id_ed25519 ]; then
    echo "🔑 Chaves SSH encontradas"
    
    if ! pgrep -x "ssh-agent" > /dev/null; then
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_*
    fi
else
    echo "⚠️  Nenhuma chave SSH encontrada"
    echo "Para clonar repositórios privados, configure SSH ou use HTTPS"
fi

echo "🎉 Configuração Git completa!"