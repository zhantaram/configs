FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color
ENV LANG=en_IN.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# System packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  clang clangd bear cmake python3 python3-pip tmux git curl unzip sudo ca-certificates build-essential lua5.4 ripgrep \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-arm64.tar.gz \
  && echo "1aa5ca085249580ae0f91eb14f27ec0919773ff2d99a163d03f3d6c21ac29725  /tmp/nvim.tar.gz" | sha256sum -c - \
  && tar -xzvf /tmp/nvim.tar.gz -C /usr/local --strip-components=1 && rm /tmp/nvim.tar.gz

# non-root user so you're not living as root in the container
ARG USERNAME=dev
RUN useradd -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN mkdir -p /home/dev/.local/bin \
  && curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /home/dev/.local/bin \
  && echo 'eval "$(/home/dev/.local/bin/oh-my-posh init bash --config /home/dev/.cache/oh-my-posh/themes/tokyo.omp.json)"' >> /home/dev/.bashrc

RUN git clone https://github.com/zhantaram/configs.git /tmp/configs \
  && cp /tmp/configs/tmux.conf /home/dev/.tmux.conf && mkdir -p /home/dev/.config \
  && cp /tmp/configs/clang/clang-format /home/dev/.clang-format && cp -r /tmp/configs/nvim /home/dev/.config/nvim \
  && rm -rf /tmp/configs

CMD ["bash"]
