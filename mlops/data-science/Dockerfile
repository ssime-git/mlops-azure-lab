FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn flask
COPY mlops/data-science/src/ ./src/
COPY outputs/model/ ./model/
COPY mlops/data-science/server.py .
ENV AZUREML_MODEL_DIR=/app/model
ENV PORT=5001
EXPOSE 5001
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5001", "server:app"]
