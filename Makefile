export JULIA_VER    := 1.3.0
export JULIA_URL    := https://julialang-s3.julialang.org/bin/linux/x64/1.3
export USER_ID      := $(shell id -u)
export PROJ_NAME    := julia-jupyter
export JUPYTER_PORT := 7654
export COMPOSE_CMD  := docker-compose -f docker/docker-compose.yaml -p ${PROJ_NAME}

check-gpu:
	nvidia-smi

check-env:
	ifndef NVIDIA_VISIBLE_DEVICES
	  $(error NVIDIA_VISIBLE_DEVICES environment variable is undefined)
	endif

build:
	$(COMPOSE_CMD) build

up: #check-env
	$(COMPOSE_CMD) up --detach

down:
	$(COMPOSE_CMD) down

connect: up
	${COMPOSE_CMD} exec jupyter tmux new-session -As main

logs:
	${COMPOSE_CMD} logs 
