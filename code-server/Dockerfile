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

ENV PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:/root/.bun/bin:$PATH"

RUN curl -fsSL https://opencode.ai/install | bash \
    || npm install -g opencode-ai

ENV PATH="/root/.opencode/bin:/root/.local/bin:$PATH"

RUN npm install -g shadcn@latest \
    && ln -sf $(which shadcn) /usr/local/bin/shadcn

RUN code-server --install-extension dbaeumer.vscode-eslint || true \
    && code-server --install-extension esbenp.prettier-vscode || true \
    && code-server --install-extension bradlc.vscode-tailwindcss || true \
    && code-server --install-extension christian-kohler.path-intellisense || true \
    && code-server --install-extension github.github-vscode-theme || true \
    && code-server --install-extension dsznajder.es7-react-js-snippets || true \
    && code-server --install-extension vscode-icons-team.vscode-icons || true \
    && code-server --install-extension formulahendry.auto-rename-tag || true

RUN mkdir -p /root/.config/opencode && \
    echo '{\n\
  "$schema": "https://opencode.ai/config.json",\n\
  "mcp": {\n\
    "shadcn": {\n\
      "type": "local",\n\
      "command": ["shadcn", "mcp"],\n\
      "enabled": true\n\
    }\n\
  }\n\
}' > /root/.config/opencode/opencode.json

RUN mkdir -p /home/dev
WORKDIR /home/dev

EXPOSE 9000 3000

CMD ["code-server", "--bind-addr", "0.0.0.0:9000", "--auth", "password", "/home/dev"]