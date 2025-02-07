# Exit immediately if a command exits with a non-zero status
# 1. Export AWS_ACCOUNT_ID (if not already set)
echo "Fetching AWS account ID..."
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

# 2. Authenticate Docker to ECR
echo "Logging into ECR..."
aws ecr get-login-password --region us-east-1 \
  | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com"

# 3. Define your image and tag
IMAGE_NAME="$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/gsa-comet-prod-react-frontend"
IMAGE_TAG="latest"
FULL_IMAGE="$IMAGE_NAME:$IMAGE_TAG"

# 4. Stop and remove any existing container named "react-app"
echo "Stopping and removing old container if it exists..."
if [ "$(docker ps -aq -f name=react-app)" ]; then
  docker rm -f react-app
fi

# 5. Remove the old image if it exists (ignore errors with "|| true")
# echo "Removing old image: $FULL_IMAGE"
# docker rmi -f "$FULL_IMAGE" || true

# 6. Pull the new image from ECR
echo "Pulling image: $FULL_IMAGE"
docker pull "$FULL_IMAGE"

# 7. Run the container
echo "Starting container..."
docker run -d --name react-app -p 3000:80 "$FULL_IMAGE"

echo "Container 'react-app' is now running the image $FULL_IMAGE."
