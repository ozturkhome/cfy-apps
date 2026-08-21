FROM oven/bun:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    sudo \
    ca-certificates \
    build-essential \
    && curl -fsSL https://code-server.dev/install.sh | sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN code-server --install-extension dbaeumer.vscode-eslint \
    && code-server --install-extension esbenp.prettier-vscode \
    && code-server --install-extension bradlc.vscode-tailwindcss \
    && code-server --install-extension christian-kohler.path-intellisense

WORKDIR /home

EXPOSE 9000 3000

CMD ["code-server", "--bind-addr", "0.0.0.0:9000", "--auth", "password", "/home"]