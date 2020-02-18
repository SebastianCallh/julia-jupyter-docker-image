# julia-jupyter-docker-image
A basic Docker setup for running Julia on a Jupyter server. The Docker
image comes configured with a bunch of handy packages for data science
and machine learning (see `docker/Dockerfile`), but it is easy to add your own.

## Usage
Most tasks are performed through the Makefile. To get going, run `make
build` and then `make up` to start the Jupyter server. You can
retrieve the login token for the server by running `make
logs`. Connect to the server on the port specified by `JUPYTER_PORT`
in the Makefile.

Happy coding!
