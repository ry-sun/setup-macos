pkgs: with pkgs; [
  # Shell
  zsh
  bash
  bash-completion
  oh-my-posh

  # Developer Tools
  ## Github Related
  git # Github
  git-lfs # LFS support
  hub
  git-extras
  gh
  gh-eco
  gh-skyline
  gh-notify
  gh-copilot
  gh-dash
  lazygit

  ## Text Editor, File Explorer, & Seesion Controlor
  neovim
  tmux
  ranger

  ## Downloader
  curl
  wget

  ## Terminal Tools (loop up file, parser)
  fd
  ripgrep
  bat
  highlight
  jq
  yq
  exiftool
  mediainfo
  tree
  fzf
  eza
  clock-rs
  thefuck

  ## Archive Tools
  atool
  libarchive
  p7zip
  unrar

  ## PDF Tools
  mupdf
  poppler-utils
  epub-thumbnailer

  ## Torrent Tools
  transmission_4

  ## OpenDocument & Markdown & Document Tools
  odt2txt
  pandoc
  catdoc
  mu

  ## HTML & Browser
  w3m
  lynx
  elinks

  ## Table (csv, xls, xlsx) Tools
  xlsx2csv
  libxls
  csvkit

  ## Image & Video Tools
  librsvg
  imagemagick
  djvulibre
  ffmpeg_6-full
  ffmpegthumbnailer

  ## Font Tools
  fontforge

  ## SSH
  openssh

  ## Monitor Tools
  htop
  btop

  ## Diff Tools
  diffutils
  colordiff
  diff-so-fancy

  ## Utils
  coreutils-full
  ncurses
  reattach-to-user-namespace

  # Programming Lanuage Related
  ## C & Makefile
  gcc
  gnumake
  cmake
  automake
  autoconf

  ## Shell DevTools
  shellcheck
  shfmt

  ## Python
  uv
  python313
  python313Packages.ipython
  python313Packages.nbconvert
  python313Packages.pygments

  ## Swift
  swiftlint
  swiftformat
  xcodegen
  xcbeautify
  ios-deploy
  tuist

  ## Node
  bun
  biome

  # Rust
  rustup

  ## Nix DevTools
  alejandra
  nil
  nixfmt-rfc-style

  ## SQL
  sqlite
  sqlite-utils

  # Ruby
  ruby

  ## Lint & Format
  pre-commit
  addlicense
  enchant
]
