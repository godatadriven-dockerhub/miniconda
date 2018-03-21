# Miniconda in Docker

Miniconda container based on Debian stretch-slim

[![](https://images.microbadger.com/badges/image/godatadriven/miniconda.svg)](https://microbadger.com/images/godatadriven/miniconda "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/godatadriven/miniconda.svg)](https://microbadger.com/images/godatadriven/miniconda "Get your own version badge on microbadger.com") 

## Running the container
By default conda --help is run:

```
docker run godatadriven/miniconda 
```

To run your own conda command:

```
docker run godatadriven/miniconda [-h] [-V] command ...
```