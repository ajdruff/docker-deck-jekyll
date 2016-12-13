# docker-deck-jekyll

A [Docker](https://www.docker.com/what-docker) Deck that provides a [Docker compose file](https://docs.docker.com/compose/compose-file/) to create a [Jekyll](https://jekyllrb.com/) container using the standard [Docker Jekyll image](https://hub.docker.com/_/jekyll/).


### Quick Start


    curl -L https://github.com/ajdruff/docker-deck-jekyll/archive/master.tar.gz | tar -zx
    mv docker-deck-jekyll* example.com
    cd example.com
    cp docker/config.env-sample docker/config.env

Now start the container:

    docker-compose up

In your browser, browse to the IP of your Container Host and you'll see the default Jekyll site.


### Configuration

Edit `docker/config.env` file with any desired changes. 

    #jekyll
    JEKYLL_PORT=80
    JEKYLL_SOURCE=jekyll_source
    JEKYLL_SITE=jekyll_site

**JEKYLL_PORT**

Set this to the port that you'd like to access your Jekyll site. 

**JEKYLL_SOURCE**

This is the location to where the container's Jekyll source directory `/srv/jekyll` points.

This directory contains your site's source files. Source files are the editable files that make up your site, and will be processed by Jekyll into html and copied to the `/srv/jekyll/_site` directory to be served by the web server.

**JEKYLL_SITE**

This is the location to where the container's Jekyll build directory `/srv/jekyll/_site` points. 

This directory contains your site's static files. These are the html and other Jekyll generated files that are served by the Jekyll web server and that you'll upload to your live site's web root.

**About Volumes**

By default, `docker-compose.yml` sets `JEKYLL_SOURCE` and `JEKYLL_SITE` to internal volumes called `jekyll_source` and `jekyll_site` respectively. 

To find the location of these volumes, you can do:

    docker inspect -f '{{ json .Mounts }}' CONTAINER_ID | python -m json.tool

 or
 
    docker inspect CONTAINER_ID | grep Source

To get the CONTAINER_ID :

    docker ps

while the container is running.


### FAQS

#### How do I change the location of  `/srv/jekyll` and `/srv/jekyll/_site` so I can easily access them with my native editor or ftp client?

**Using Native Linux**

If you are using Linux natively as the Container Host (not via a Virtual Machine), you can access these locations by navigating your file system to their default internal volume locations (see 'About Volumes' section to find their location). Alternately, you can map them using the `JEKYLL_SOURCE` and `JEKYLL_SITE` settings , similarly to what's required when using Windows or Mac.

**Using Windows or Mac with VirtualBox**

If you are using Windows/Mac with VirtualBox , you can map the locations to a share on your VirtualBox Host, and change the `${JEKYLL_SOURCE}` and `${JEKYLL_SITE}` settings in `docker/config.env` to point to the mapped locations.

For example, if you create a shared VirtualBox folder `dev` which is mounted on the VirtualBox Host at `/media/vmhost/dev`, you could configure your settings like this :

    JEKYLL_SOURCE=/media/vmhost/dev/example.com/_jekyll/source
    JEKYLL_SITE=/media/vmhost/dev/example.com/_jekyll/www





## About Docker Decks

Docker Decks consist of a Docker compose file, an environmental variable file that supplies default environmental variables to the host, and any associated helper scripts for easy Docker container installation.

*Docker Decks try to adhere to the following:*

* most configuration is done using an environmental file, avoiding unneccesarily editing the docker-compose.yml file
* defaults to using persistent volumes
* defaults to using standard ports for webserver and database services
* should work 'out of the box' with little to no configuration


### Prerequisites

The following is installed locally 

* [Docker Engine](https://docs.docker.com/engine/installation/) is installed locally or within a Virtual Machine (e.g: Virtual Box)
* [Docker Compose](https://docs.docker.com/compose/) is installed locally or within a Virtual Machine (e.g: Virtual Box)
* you are logged into the container host and are either root or are a member of the docker group

### Terminology

* *VirtualBox Host* refers to the machine that hosts the VirtualBox runtime. 
* *VirtualBox Guest* refers to the virtual machine running on the VirtualBox Host.
* *Container Host* refers to the machine in which Docker and Docker Compose is installed. It can be your local machine or a Virtual Machine (e.g: VirtualBox Guest).
* *Docker Container* refers to the instance of the Docker image that is running on the Container host 
* *Docker Image* refers to the image pulled from a repository (such as the Docker Hub) or locally which defines the container.

**Example #1**

You are using a Windows 10 laptop with VirtualBox. We'll call your laptop 'Windows'.

You install the docker engine & docker compose on a VirtualBox Linux Virtual Machine. We'll call the Virtual Machine 'Debian'
You use a Docker Deck to install a jekyll container on 'debian'. We'll call the container 'jekyll'. 

* VirtualBox Host=Windows
* VirtualBox Guest=Debian
* Container Host=Debian
* Docker Container=jekyll

**Example #2**

You are using a Debian laptop (with name 'Debian') with docker engine and docker-compose installed. 

You install a jekyll container with name 'Jekyll'

* Docker Container=Jekyll
* Container Host=Debian





### Detailed Installation Steps

#### Download and Extract
**download manually
**
Go to https://github.com/ajdruff/docker-deck-wp and click 'Clone or Download' and click the 'Download ZIP' link, or download from [https://github.com/ajdruff/docker-deck-wp/archive/master.zip](https://github.com/ajdruff/docker-deck-wp/archive/master.zip)

Extract docker-deck-wp-master.zip

Rename the parent directory from docker-deck-wp-master to `example.com` where `example.com` is the domain of your new website.

**download using git clone**


    git clone https://github.com/ajdruff/docker-deck-wp.git
    mv docker-deck-wp example.com
    cd example.com

where `example.com` is the domain of your new website.

**download using wget**


     wget -qO- https://github.com/ajdruff/docker-deck-wp/archive/master.tar.gz | tar -zx
     mv docker-deck-wp* example.com

where `example.com` is the domain of your new website.

**download using curl**


    curl -L https://github.com/ajdruff/deck-wp/archive/master.tar.gz | tar -zx
    mv deck-wp* example.com
    cd example.com

where `example.com` is the domain of your new website.

#### Configuration

Configuration of the container should be done primarily using the `.env` file.

    mv .env-sample .env

Edit the `.env` file with your favorite editor. 

At a minimum, you should change the following:

* `MYSQL_ROOT_PASSWORD`
* `WORDPRESS_DB_PASSWORD`



>The `.env` file should never be committed to a git repo since it contains passwords and configuration for your container. By default, `.env` file is in the .gitignore file to be ignored if you clone the repo.







#### Creating the Container



## Contributing

1. Fork it!
2. Create your feature branch: git checkout -b my-new-feature
3. Commit your changes: git commit -am 'Add some feature'
4. Push to the branch: git push origin my-new-feature
5. Submit a pull request :D




## Authors

* **Andrew Druffner** andrew@nomstock.com

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

