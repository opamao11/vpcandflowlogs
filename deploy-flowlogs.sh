# This will create and encrypt VPC flowlogs, create cloudwatch logs
# This will fetch vpc id by tags


#!/bin/bash

# === CONFIGURATION ===
REGION="us-west-1"
STACK_NAME="encrypted-flowlogs-sandbox-test"
ENV="test"
PROGRAM_NAME="sandbox"
REGION_TAG="west"
VPC_NAME_TAG="SANDBOX-prod-w-vpc"
TEMPLATE_FILE="vpc-flowlogs-encrypted.yaml"

# === GET VPC ID BY TAG ===
echo "🔍 Searching for VPC with tag Name=$VPC_NAME_TAG in region: $REGION..."
VPC_ID=$(aws ec2 describe-vpcs \
  --region "$REGION" \
  --filters "Name=tag:Name,Values=$VPC_NAME_TAG" \
  --query "Vpcs[0].VpcId" \
  --output text)

# === VALIDATE VPC ID ===
if [[ "$VPC_ID" == "None" || -z "$VPC_ID" ]]; then
  echo "❌ No VPC found with tag Name=$VPC_NAME_TAG in region $REGION."
  exit 1
fi
echo "✅ Found VPC: $VPC_ID"

# === DEPLOY CLOUDFORMATION STACK ===
echo "🚀 Deploying CloudFormation stack: $STACK_NAME..."
aws cloudformation deploy \
  --template-file "$TEMPLATE_FILE" \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    VpcId="$VPC_ID" \
    Env="$ENV" \
    ProgramName="$PROGRAM_NAME" \
    RegionTag="$REGION_TAG"

echo "✅ Deployment finished for stack: $STACK_NAME"
