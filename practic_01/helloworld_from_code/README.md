## Para probar en docker local
### Crear imagen en docker local
docker build -t hellorun .

### Correr imagen creada
docker run -p 8080:80 hellorun
### Fijar una region 
gcloud config set run/region us-central1

gcloud run deploy --source .

gcloud run deploy hello-nombre --image us-central1-docker.pkg.dev/test-projects-jn/cloud-run-source-deploy/hello-img

gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld-img

docker run -d -p 8080:8080 gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld-img

gcloud run deploy --image gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld-img --allow-unauthenticated --region=$LOCATION

innate-bonfire-361004