# Resmi Bun tabanlı Linux imajı
FROM oven/bun:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=20.18.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    sudo \
    ca-certificates \
    build-essential \
    && curl -fsSL https://code-server.dev/install.sh | sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH"

RUN code-server --install-extension dbaeumer.vscode-eslint \
    && code-server --install-extension esbenp.prettier-vscode \
    && code-server --install-extension bradlc.vscode-tailwindcss \
    && code-server --install-extension christian-kohler.path-intellisense

WORKDIR /home/dev

EXPOSE 9000 3000

CMD ["sh", "-c", "bunx --bun shadcn@latest mcp init --client vscode && code-server --bind-addr 0.0.0.0:9000 --auth password /home/dev"]