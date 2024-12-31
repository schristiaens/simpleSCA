FROM python:3.11-slim

LABEL maintainer="Steve Christiaens<redsteve@gmail.com>"
LABEL version="0.1"
LABEL description="An image for an SCA scanning tool."

WORKDIR /scan

RUN apt-get update && \
    apt-get install -y git nodejs npm curl && \
    npm install -g @cyclonedx/cdxgen && \
    python3 -m pip install semgrep && \
    curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin && \
    curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin && \
    curl -sSfL https://raw.githubusercontent.com/anchore/grype/refs/heads/main/templates/html.tmpl -o /usr/local/share/html.tmpl

COPY ./src /app

RUN chmod +x /app/scan.sh

ENTRYPOINT ["/app/scan.sh"]
