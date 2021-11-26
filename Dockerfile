FROM python:3.8
COPY . ./app
WORKDIR /app
RUN apt-get update && apt-get install \
	&& apt-get install curl 
RUN pip install -r requirements.txt 
EXPOSE 8080
CMD ["python", "app.py"]


