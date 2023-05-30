FROM ghcr.io/helmfile/helmfile:v0.154.0 AS base

# add kubectl
RUN curl -o /usr/local/bin/kubectl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# add sopssecretgenerator
RUN mkdir -vp "/github/home/.config/kustomize/plugin/goabout.com/v1beta1/sopssecretgenerator" && \
    curl -L -o "/github/home/.config/kustomize/plugin/goabout.com/v1beta1/sopssecretgenerator/SopsSecretGenerator" $(curl -Ls https://api.github.com/repos/goabout/kustomize-sopssecretgenerator/releases/latest | jq -r '.assets[] | select(.name | test("^SopsSecretGenerator_.+_linux_amd64$")) | .browser_download_url') && \
    chmod +x "/github/home/.config/kustomize/plugin/goabout.com/v1beta1/sopssecretgenerator/SopsSecretGenerator"

# add sops
RUN curl -s -L -o /usr/local/bin/sops $(curl -Ls https://api.github.com/repos/mozilla/sops/releases/latest | jq -r '.assets[] | select(.name | test("^sops-v.+\\.linux\\.amd64$")) | .browser_download_url') && \
    chmod +x /usr/local/bin/sops
