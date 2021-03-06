This is a very simple demo application that is used to show an ASP.Net
applicatoin and a Java application executing in Docker containers. The
application is very simple, an ASP.Net web application communicates
with a Java REST API and returns the information to the user.

This is not a real application. It doesn't do anything useful and it
isn't intended to do so. Neither is it a demonstration of best
practice application management. It is merely an introduction to using
containerized applications on Microsoft Azure.

# Setup #

There are a few tihngs you need to do to setup your environment. Take
a look at the file environmentSetup.md and come back here when you are 
done.

# Development #

Development is supported by a pre-configured development container.
See the environemntSetup.md file for more information on how to 
configure your development docker machine. 

In the root directory of the project there is a Dockerfile which defines
a preconfigured development environment. To build and run the development 
container run:

$ script/dev.sh

This command will build and start a devleopment container on your 
designated dev machine (see DEV_MAHCINE_NAME in config.sh). Once the 
container is started two containers inside this dev one will be started,
one for each of the apps (Java and ASP.Net).

You can execute commands on the remote machine using the 'docker exec'
command. For example, to check your two dev containers are running try:

    $ docker exec dev docker ps

Note that this script will remove a previously running dev container.
This means that each time your run this script the ASP.Net and Java
dev containers need to be rebuilt from scratch. This can be slow. For
this reason you probably only want to run this script when you want to
ensure you are working in a clean environment.

If you just want to restart the Java or ASP.Net containers run the
following commands:

    $ docker exec dev bash -ci script/dev_asp.sh
    $ docker exec dev bash -ci script/dev_java.sh

--- FIXME: make the watcher file work (see below para)

The development container will watch for changes in your configuration files and 
rebuild/restart development versions of your application containers whenever
necessary. See the readme.md file for more information.


## A Note on Debugging ##

If deploying your containers fails for some reason it can sometimes be
difficult finding out why. So here's a couple of useful tips:

You can view the logs of the container with "docker logs MACHINE_NAME"

If things don't work as expected you can connect to a running container 
with "docker exec -it MACHINE_NAME bash". Once connected you can work
inspect the machine directly.

# Staging #

To build and stage the ASP.Net application run script/stage_asp.sh.

To build and stage the Java application run script/stage_java.sh

For convenience you can build and stage all components at the same time
using 'script/stage.sh'

Once both applications are staged you can visit:
  * Java REST API: http://tutorialstage.cloudapp.net:5050/JerseyHelloWorld/rest/helloworld 
  * ASP Front-End: http://tutorialstage.cloudapp.net:8080

# Scripts #

The /script directory contains a number of helper scripts for managing
our build and development environments.

## Variables ##

Variables are used to configuring the various scripts.

STAGE_VERSION - the version number for the staged builds

# ASP.net Hello Web #

Based on the Hello world using Nancy framework. See https://github.com/NancyFx/Nancy/wiki/Introduction
Initial project created using Yeoman: npm install -g yo grunt-cli generator-aspnet bower; yo aspnet
This async tutorial was really useful too: http://blog.jonathanchannon.com/2013/08/24/async-route-handling-with-nancy/


# Java Hello REST API #

Based on http://javahash.com/jersey-hello-world-example/

# TODO

  * Make the Dev environment be a container host environment too (i.e. the dev should be a meta-host)
    * 
  * Create a single script to run both the Java and ASP applications
  * Create a configuration file for both the Java and ASP applications so we can see the difference between dev and prod
