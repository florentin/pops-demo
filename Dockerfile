FROM python:3.7.4-slim as base

FROM base as builder

WORKDIR /wheels
COPY requirements.txt /
RUN pip wheel -r /requirements.txt

# ---

FROM base

COPY --from=builder /wheels /wheels

COPY requirements.txt /app/
RUN pip install --find-links /wheels -r /app/requirements.txt \
    && rm -rf /root/.cache/pip/*

WORKDIR /app
