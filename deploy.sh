#!/bin/bash

terraform -chdir=./infra init && terraform -chdir=./infra plan && terraform -chdir=./infra apply -auto-approve