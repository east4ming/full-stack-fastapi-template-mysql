FROM tiangolo/uvicorn-gunicorn-fastapi:python3.10

WORKDIR /app/

RUN python -m pip install --no-cache-dir --upgrade pip
RUN python -m pip install --no-cache-dir --upgrade setuptools

# Copy rye .lock* in case it doesn't exist in the repo
COPY ./pyproject.toml ./requirements*.lock /app/

# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=false
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then sed '/^-e/d' requirements-dev.lock > requirements.txt ; else sed '/^-e/d' requirements.lock > requirements.txt ; fi"

ENV PYTHONPATH=/app

COPY ./start-reload.sh /

COPY ./start.sh /

RUN chmod +x /start-reload.sh && chmod +x /start.sh

COPY ./scripts/ /app/

COPY ./alembic.ini /app/

COPY ./prestart.sh /app/

COPY ./tests-start.sh /app/

COPY ./src/ /app/src/


RUN sed -i 's/requires = \["hatchling"\]/requires = \["setuptools", "setuptools-scm"\]/; s/build-backend = "hatchling.build"/build-backend = "setuptools.build_meta"/' pyproject.toml
RUN sed -i '/\[tool\.hatch\.metadata\]/d; /allow-direct-references = true/d' pyproject.toml

RUN pip install --no-cache-dir -r requirements.txt

RUN pip install .
