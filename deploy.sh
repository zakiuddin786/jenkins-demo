
Environment_name=$1
AWS_ACCESS_KEY=$2
AWS_SECRET_ACCESS_KEY=$3
frontend_S3_bucket="temp"
region="ap-south-1"

if [ "$Environment_name" == "beta"]; then
    frontend_S3_bucket="beta-todo-app"
elif ["$Environment_name" == "prod"]; then
    frontend_S3_bucket="prod-todo-app"
else 
    echo "Invalid environment name"
    exit 1
fi

echo "Deploying to frontend s3 bucket $S3_bucket_name"
aws s3 sync ./todo-frontend/build/ s3://$frontend_S3_bucket --delete --region $region