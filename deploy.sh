
set -e

# check is a var is empty
check_empty(){

	if [[ -z "$1" ]]; then
   		echo $2 is empty
		exit 5
	fi
}

check_empty $IMAGE_REPOSITORY IMAGE_REPOSITORY
check_empty $DB_CONNECTION_STRING DB_CONNECTION_STRING

COMMIT_ID=$(git log -1 --format=format:"%H")

# build docker image
echo "printing current directory contents"
ls -la

echo "Building docker image atmagic-strapi:$COMMIT_ID in directory $(pwd)"
docker build -t atmagic-strapi:$COMMIT_ID .
echo "Tagging docker image $IMAGE_REPOSITORY/atmagic-strapi:$COMMIT_ID"
docker tag atmagic-strapi:$COMMIT_ID $IMAGE_REPOSITORY"/atmagic-strapi":$COMMIT_ID

# login to ecr
echo "Login to ecr"
aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin $IMAGE_REPOSITORY

# push image to ecr
echo "Puhing image to ecr"
docker push $IMAGE_REPOSITORY"/atmagic-strapi":$COMMIT_ID

# remove local image
docker rmi $IMAGE_REPOSITORY"/atmagic-strapi":$COMMIT_ID
docker rmi atmagic-strapi:$COMMIT_ID

# print disk free space
df -h

# run migration
migrate -database mysql://$DB_CONNECTION_STRING -path db/migrations up

helm upgrade --install atmagic-strapi ./build/atmagic-strapi -n ai-v1 \
    --create-namespace \
    --set image.repository=$IMAGE_REPOSITORY/atmagic-strapi \
    --set image.tag=$COMMIT_ID \
    -f /home/ubuntu/ai/strapi-values.yaml
