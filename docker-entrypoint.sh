#!/bin/bash
set -e

# Remove o arquivo de PID do servidor se existir
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# Criar banco de dados se não existir
bundle exec rails db:create 2>/dev/null || true

# Executar migrations
bundle exec rails db:migrate 2>/dev/null || true

# Executar o comando passado para o container
exec "$@"
