FROM openjdk:21-slim

# Establecer variables de entorno necesarias
ENV DROID_VERSION=6.9.4
ENV DROID_HOME=/opt/droid

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    libxext6 libxrender1 libxtst6 libxi6 libxrandr2 libasound2 libatk1.0-0 libcups2 libgtk-3-0 libnss3 libxcomposite1 libxdamage1 libxfixes3 libx11-xcb1 libxss1 libxinerama1 libpango-1.0-0 libpangocairo-1.0-0 \
    wget unzip \
    && rm -rf /var/lib/apt/lists/*

# Descargar DROID (ajustar versión según la última disponible)
RUN mkdir -p $DROID_HOME && \
    wget -q https://github.com/digital-preservation/droid/releases/download/$DROID_VERSION/droid-binary-$DROID_VERSION-bin.zip -O /tmp/droid.zip && \
    unzip /tmp/droid.zip -d $DROID_HOME && \
    rm /tmp/droid.zip

# Ajustar permisos (si es necesario)
RUN chmod +x $DROID_HOME/droid.sh

# Añadir droid al PATH
ENV PATH="$DROID_HOME:$PATH"

# Definir directorio de trabajo
WORKDIR $DROID_HOME

# Puerto para interfaz web si es que se utiliza (DROID puede funcionar con GUI o comandos)
EXPOSE 8080

# Comando por defecto: mostrar ayuda de droid
CMD ["./droid.sh", "-h"]
