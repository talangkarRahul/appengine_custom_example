FROM gcr.io/google-appengine/python
RUN apt-get update
RUN apt-get -y install binutils libproj-dev gdal-bin  # here you can add your packages
LABEL python_version=python3.6
RUN virtualenv --no-download /env -p python3.6
ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH
ADD requirements.txt /app/
RUN pip install -r requirements.txt
ADD . /app/
CMD exec gunicorn -b :$PORT myproject.wsgi --log-level=DEBUG
