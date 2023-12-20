FROM python:3.10

RUN apt update && apt install -y g++ git && pip install --upgrade pip

RUN useradd modmail
USER modmail
WORKDIR /home/modmail

RUN pip install --user pipenv

ENV PATH="/home/modmail/.local/bin:${PATH}"

COPY --chown=modmail:modmail Pipfile Pipfile.lock ./
RUN pipenv install

COPY --chown=modmail:modmail . .

ENV USING_DOCKER yes

CMD ["pipenv", "run", "bot"]
