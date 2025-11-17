# .devcontainer/Dockerfile
FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

# 基本ツール + 日本語フォント(Noto) + ロケール + TeX Live
RUN apt-get update && apt-get install -y \
    wget curl make perl git python3 ghostscript fontconfig xz-utils ca-certificates \
    locales \
    fonts-noto-cjk \
    latexmk \
    texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-lang-cjk texlive-luatex texlive-xetex \
    texlive-science \
    texlive-bibtex-extra \
 && sed -i 's/# ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen \
 && locale-gen \
 && rm -rf /var/lib/apt/lists/*

ENV LANG=ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8

# フォントキャッシュ
RUN fc-cache -fv

# LuaTeX のフォントキャッシュ更新（失敗してもビルド継続）
RUN luaotfload-tool -u || true

WORKDIR /work

# デフォルトコマンド
CMD ["/bin/bash"]
