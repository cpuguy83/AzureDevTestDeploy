###########################################
# Build and run the ASP.Net application
#
# If docker-machine is present assume that
# docker-machine is managing the docker
# hosts and us that. Otherwise use the same
# machine that this script is running on.
###########################################

source script/config.sh

echo "Staging ASP application version $ASP_STAGE_VERSION on $STAGE_MACHINE_NAME"
eval "$(docker-machine env $STAGE_MACHINE_NAME)"

cd asp

# Build the container to ensure we pick up any changes
docker build -f stage-Dockerfile -t asp:$ASP_STAGE_VERSION .

# Stop, remove and restart the container
echo "Stopping any running staged container"
docker stop stage_asp
echo "Removing any previously staged container"
docker rm stage_asp
echo "Running a container"
docker run -t -d -p 8080:8080 --name=stage_asp asp:$ASP_STAGE_VERSION

cd ..