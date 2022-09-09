# Getting started with Django on Cloud Run

[![Open in Cloud Shell][shell_img]][shell_link]

[shell_img]: http://gstatic.com/cloudssh/images/open-btn.png
[shell_link]: https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/GoogleCloudPlatform/python-docs-samples&page=editor&open_in_editor=run/django/README.md

This repository is an example of how to run a [Django](https://www.djangoproject.com/) 
app on Google Cloud Run (fully managed). 

The Django application used in this tutorial is the [Writing your first Django app](https://docs.djangoproject.com/en/3.2/#first-steps),
after completing [Part 1](https://docs.djangoproject.com/en/3.2/intro/tutorial01/) and [Part 2](https://docs.djangoproject.com/en/3.2/intro/tutorial02/).


# Tutorial
See our [Running Django on Cloud Run (fully managed)](https://cloud.google.com/python/django/run) tutorial for instructions for setting up and deploying this sample application.

## Comandos a utilizar
django-admin startproject mysite
python manage.py startapp polls

gcloud sql instances create pg-test \
    --project $GOOGLE_CLOUD_PROJEC \
    --database-version POSTGRES_13 \
    --tier db-f1-micro \
    --region $LOCATION


    gcloud sql databases create db-izzi-jn \
    --instance pg-test

    gcloud sql users create user-izzi \
    --instance pg-test \
    --password test123


gsutil mb -l $LOCATION gs://${GOOGLE_CLOUD_PROJEC}_bucket

echo DATABASE_URL=postgres://DB_USERNAME:PASSWORD@//cloudsql/${GOOGLE_CLOUD_PROJEC}:${LOCATION}:pg-test/DATABASE_NAME > .env
echo GS_BUCKET_NAME=${GOOGLE_CLOUD_PROJEC}_bucket >> .env
echo SECRET_KEY=$(cat /dev/urandom | LC_ALL=C tr -dc '[:alpha:]'| fold -w 50 | head -n1) >> .env


$ gcloud secrets create django_settings --data-file .env

$ gcloud secrets describe django_settings
$ gcloud secrets versions access latest --secret django_settings

export PROJECTNUM=$(gcloud projects describe ${GOOGLE_CLOUD_PROJEC} --format='value(projectNumber)')

rm .env

gcloud secrets add-iam-policy-binding django_settings \
    --member serviceAccount:${PROJECTNUM}-compute@developer.gserviceaccount.com \
    --role roles/secretmanager.secretAccessor

gcloud secrets add-iam-policy-binding django_settings \
    --member serviceAccount:${PROJECTNUM}@cloudbuild.gserviceaccount.com \
    --role roles/secretmanager.secretAccessor

echo -n "$(cat /dev/urandom | LC_ALL=C tr -dc '[:alpha:]'| fold -w 30 | head -n1)" | gcloud secrets create superuser_password --data-file -

gcloud secrets add-iam-policy-binding superuser_password \
    --member serviceAccount:${PROJECTNUM}@cloudbuild.gserviceaccount.com \
    --role roles/secretmanager.secretAccessor

gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT \
    --member serviceAccount:${PROJECTNUM}@cloudbuild.gserviceaccount.com \
    --role roles/cloudsql.client

Windows: cloud_sql_proxy.exe -instances="${GOOGLE_CLOUD_PROJECT}:${$LOCATION}:pg-test"=tcp:5432
Mac: ./cloud_sql_proxy -instances="innate-bonfire-361004:us-central1:pg-test"=tcp:5432

export USE_CLOUD_SQL_AUTH_PROXY=true

python manage.py makemigrations
python manage.py makemigrations polls
python manage.py migrate
python manage.py collectstatic

python manage.py runserver

gcloud builds submit --config cloudmigrate.yaml \
    --substitutions _INSTANCE_NAME=pg-test,_REGION=us-central1,_SERVICE_NAME=polls-service-jhoan

gcloud run deploy polls-service-jhoan \
    --platform managed \
    --region ${LOCATION} \
    --image gcr.io/${GOOGLE_CLOUD_PROJECT}/polls-service-jhoan \
    --add-cloudsql-instances ${GOOGLE_CLOUD_PROJECT}:${LOCATION}:pg-test \
    --allow-unauthenticated

SERVICE_URL=$(gcloud run services describe polls-service-jhoan --platform managed \
    --region $LOCATION --format "value(status.url)")

gcloud run services update polls-service-jhoan \
    --platform managed \
    --region $LOCATION \
    --set-env-vars CLOUDRUN_SERVICE_URL=$SERVICE_URL

gcloud sql connect pg-test --user postgres

CREATE USER "user-jhoan" WITH PASSWORD '123';
GRANT ALL PRIVILEGES ON DATABASE "db-izzi-jn" TO "user-jhoan";


gcloud iam service-accounts create polls-service-account
SERVICE_ACCOUNT=polls-service-account@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com

# Cloud Run Invoker
gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT} \
    --role roles/run.invoker

# Cloud SQL Client
gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} \
    --member serviceAccount:${SERVICE_ACCOUNT} \
    --role roles/cloudsql.client

# Storage Admin, on the media bucket
gsutil iam ch \
    serviceAccount:${SERVICE_ACCOUNT}:roles/storage.objectAdmin \
    gs://MEDIA_BUCKET

# Secret Accessor, on the Django settings secret.
gcloud secrets add-iam-policy-binding django_settings \
    --member serviceAccount:${SERVICE_ACCOUNT} \
    --role roles/secretmanager.secretAccessor


gcloud run services update polls-service-jhoan \
    --platform managed \
    --region $LOCATION \
    --service-account ${SERVICE_ACCOUNT}



innate-bonfire-3\q61004


