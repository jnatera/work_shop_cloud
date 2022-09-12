export GOOGLE_CLOUD_PROJECT=innate-bonfire-361004
export USE_CLOUD_SQL_AUTH_PROXY=true
LOCATION=us-central1

export PROJECTNUM=$(gcloud projects describe ${GOOGLE_CLOUD_PROJECT} --format='value(projectNumber)')

