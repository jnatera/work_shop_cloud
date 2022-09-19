#!/usr/bin/env bash
gcloud api-gateway api-configs create my-config-izzi4 \                                       
--api=api-zzi --openapi-spec=openapi.yml \            
--project=$GOOGLE_CLOUD_PROJECT --backend-auth-service-account=${PROJECTNUM}-compute@developer.gserviceaccount.com

gcloud api-gateway gateways update gw-izzi \
  --api=api-zzi --api-config=my-config-izzi4 \
  --location=$LOCATION --project=$GOOGLE_CLOUD_PROJECT