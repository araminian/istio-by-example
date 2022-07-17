set export

# GIT
GIT_BRANCH := `git rev-parse --abbrev-ref HEAD`
GIT_REV := `git rev-parse --short=16 HEAD`

# DOCKER
DOCKER_REPOSITORY := "rminz"
DOCKER := "docker"
DOCKER_FLAGS := ""
DOCKER_BUILD := "$DOCKER $DOCKER_FLAGS build"
DOCKER_BUILD_FLAGS := ""

DOCKER_PUSH := "$DOCKER $DOCKER_FLAGS push"
DOCKER_PUSH_FLAGS := ""

DOCKER_BACKEND_IMAGE := DOCKER_REPOSITORY+"/mesh-backend"
DOCKER_FRONTEND_IMAGE := DOCKER_REPOSITORY+"/mesh-frontend"
DOCKER_IMAGE_TAG := GIT_BRANCH + "-" + GIT_REV

default:
  @just --list


# Build Backend Docker Image
backend-docker-build ExtraTag="":
    {{DOCKER_BUILD}} {{DOCKER_BUILD_FLAGS}} -t {{DOCKER_BACKEND_IMAGE}}:{{DOCKER_IMAGE_TAG}} {{ if ExtraTag != "" { "-t " + ExtraTag } else { "" } }} ./backend/

# Build Frontend Docker Image
frontend-docker-build ExtraTag="":
    {{DOCKER_BUILD}} {{DOCKER_BUILD_FLAGS}} -t {{DOCKER_FRONTEND_IMAGE}}:{{DOCKER_IMAGE_TAG}} {{ if ExtraTag != "" { "-t " + ExtraTag } else { "" } }} ./frontend/

# Push Backend Docker Image
backend-docker-push:
    {{DOCKER_PUSH}} {{DOCKER_PUSH_FLAGS}} {{DOCKER_BACKEND_IMAGE}}:{{DOCKER_IMAGE_TAG}}

# Push Frontend Docker Image
frontend-docker-push:
    {{DOCKER_PUSH}} {{DOCKER_PUSH_FLAGS}} {{DOCKER_FRONTEND_IMAGE}}:{{DOCKER_IMAGE_TAG}}