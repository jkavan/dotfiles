FROM debian:latest

# Set noninteractive mode during building
# ENV would persist after the build
ARG DEBIAN_FRONTEND=noninteractive

# Install all the necessary packages
RUN apt-get update -qq && \
    apt-get install -y -qq \
        curl \
        git \
        locales \
        python \
        python-neovim \
        python3 \
        python3-neovim \
        sudo \
        tmux \
        wget \
        zsh \
    && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Generate UTF-8 locales
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

# Download Neovim AppImage instead of building it manually,
# since it creates smaller Docker layers due to all the build dependencies
RUN wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim && \
    chmod a+x nvim && \
    mv nvim /usr/bin/

# Create an user and add it to sudoers
RUN useradd -m -s /bin/zsh testuser && \
    usermod -aG sudo testuser && \
    echo "testuser ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Copy local dotfiles to the image
COPY --chown=testuser:testuser . /home/testuser/.dotfiles

# Switch to testuser
USER testuser

# Automatically extract and run the AppImage when it's executed
ENV APPIMAGE_EXTRACT_AND_RUN 1

# Change working directory to .dotfiles
WORKDIR /home/testuser/.dotfiles

SHELL ["/bin/zsh", "-c"]

# Run the dotfiles installation script
RUN ./install

# Make sure to set the correct TERM
# You can override this when starting the container like this:
# `docker run -it <container> env TERM=tmux-256color /bin/zsh`
ENV TERM xterm-256color

CMD ["/bin/zsh"]
