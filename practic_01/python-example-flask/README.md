# python-flask-example
Code example used in [Building Python applications](https://cloud.google.com/build/docs/building/build-python). For instructions on running this code sample, see the documentation.

gcloud builds submit --region=us-central1 --config cloudbuild.yaml --substitutions=_ARTIFACT_REGISTRY_REPO="cloud-run-source-deploy",_BUCKET_NAME="${GOOGLE_CLOUD_PROJECT}_cloudbuild",_PROJECT_ID="${GOOGLE_CLOUD_PROJECT}",_SHORT_SHA="mi-nombre" .


## Esquema de configuración

steps:
- name: string
  args: [string, string, ...]
  env: [string, string, ...]
  dir: string
  id: string
  waitFor: [string, string, ...]
  entrypoint: string
  secretEnv: string
  volumes: object(Volume)
  timeout: string (Duration format)
  script: string
- name: string
  ...
- name: string
  ...
timeout: string (Duration format)
queueTtl: string (Duration format)
logsBucket: string
options:
 env: [string, string, ...]
 secretEnv: string
 volumes: object(Volume)
 sourceProvenanceHash: enum(HashType)
 machineType: enum(MachineType)
 diskSizeGb: string (int64 format)
 substitutionOption: enum(SubstitutionOption)
 dynamicSubstitutions: boolean
 logStreamingOption: enum(LogStreamingOption)
 logging: enum(LoggingMode)
 pool: object(PoolOption)
 requestedVerifyOption: enum(RequestedVerifyOption)
substitutions: map (key: string, value: string)
tags: [string, string, ...]
serviceAccount: string
secrets: object(Secret)
availableSecrets: object(Secrets)
artifacts: object (Artifacts)
images:
- [string, string, ...]