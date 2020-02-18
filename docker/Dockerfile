FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
ARG JULIA_VER
ARG JULIA_URL
ARG USER_ID
ARG USER_NAME

EXPOSE 8888
USER root
WORKDIR /

# ========== Install system dependencies ========== 

RUN apt-get update && apt-get install -y \
	curl tar tmux

# ========== Install Jupyter ==========

# Install Miniconda
RUN curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
	bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b && \
	rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}	

# Install Jupyter
RUN conda update -y conda && \
	conda install -y -c conda-forge jupyterlab
RUN mkdir /.local && \
	chown ${USER_ID} /.local

# ========== Install Julia ==========

# Download Julia binary
RUN curl -LO ${JULIA_URL}/julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	tar -xf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	rm -rf julia-${JULIA_VER}-linux-x86_64.tar.gz && \
	ln -s /julia-${JULIA_VER}/bin/julia /usr/local/bin/julia
RUN mkdir /.julia && \
	chown ${USER_ID} /.julia

# ========== Add application user ==========

RUN useradd --no-log-init --system --uid ${USER_ID} \
	--create-home --shell /bin/bash ${USER_NAME} 

USER ${USER_NAME}

# ========== Install Julia packages as application user ==========

RUN julia -e "using Pkg; Pkg.add.([ \
	\"Flux\", \ 
	\"DiffEqFlux\", \ 
	\"DifferentialEquations\", \
	\"CuArrays\", \ 
	\"CUDAapi\", \ 
	\"BSON\", \ 
	\"CSV\", \ 
	\"Formatting\", \ 
	\"Distributions\", \
	\"Plots\", \
	\"Tables\", \
	\"DataFrames\", \
	\"ProgressMeter\", \
	\"StatsPlots\", \ 
	\"MLDataUtils\", \
	\"IJulia\", \
	\"Conda\" \
]); Pkg.update;"

# Pre compile
RUN julia -e "using DataFrames, CSV, Plots, StatsPlots, MLDataUtils, IJulia, Conda;"
#ENTRYPOINT ["jupyter", "lab", "--ip=*", "--no-browser"]
