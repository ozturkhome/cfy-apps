FROM oven/bun:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR=/root/.nvm

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
    && nvm install node \
    && nvm alias default node \
    && nvm use default

ENV PATH="$NVM_DIR/versions/node/$(ls $NVM_DIR/versions/node 2>/dev/null | tail -n 1)/bin:/root/.bun/bin:$PATH"

RUN npm install -g @openai/codex || npm install -g codex-cli || true

RUN npm install -g shadcn@latest \
    && ln -sf $(which shadcn) /usr/local/bin/shadcn

RUN code-server --install-extension dbaeumer.vscode-eslint || true \
    && code-server --install-extension esbenp.prettier-vscode || true \
    && code-server --install-extension bradlc.vscode-tailwindcss || true \
    && code-server --install-extension christian-kohler.path-intellisense || true \
    && code-server --install-extension github.github-vscode-theme || true \
    && code-server --install-extension dsznajder.es7-react-js-snippets || true \
    && code-server --install-extension vscode-icons-team.vscode-icons || true \
    && code-server --install-extension formulahendry.auto-rename-tag || true \
    && code-server --install-extension openai.codex || true

RUN mkdir -p /home/dev
WORKDIR /home/dev

EXPOSE 9000 3000

CMD ["code-server", "--bind-addr", "0.0.0.0:9000", "--auth", "password", "/home/dev"]