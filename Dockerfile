FROM python:3.13-alpine AS builder

WORKDIR /app

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && find /opt/venv -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true

FROM python:3.13-alpine

WORKDIR /app

ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

RUN adduser -D -u 1000 sem7-usr && chown -R sem7-usr:sem7-usr /app

COPY --from=builder /opt/venv /opt/venv
COPY --chown=sem7-usr:sem7-usr main.py /app/

USER sem7-usr

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
