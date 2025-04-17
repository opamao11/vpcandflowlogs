# vpcandflowlogs

Infrastructure-as-Code (IaC) templates for deploying a secure AWS VPC and enabling encrypted VPC Flow Logs to CloudWatch Logs using KMS and IAM roles. Designed for sandbox or production environments in `us-west-1`.

---

## 📁 Files Included

| File                          | Description                                                                                       |
|------------------------------|---------------------------------------------------------------------------------------------------|
| `vpc.yaml`                   | Creates a secure VPC with private subnets, custom NACLs, SSM endpoints, and IAM roles for EC2.     |
| `vpc-flowlogs-encrypted.yaml`| Provisions a KMS key, CloudWatch log group, IAM roles, and enables encrypted VPC Flow Logs.       |
| `deploy-flowlogs.sh`         | Bash script to discover the VPC by tag and deploy `vpc-flowlogs-encrypted.yaml` automatically.     |

---

## 🚀 Quickstart

### Deploy VPC

```bash
aws cloudformation deploy \
  --template-file vpc.yaml \
  --stack-name sandbox-vpc-stack \
  --region us-west-1 \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    RegionAZ1=us-west-1b \
    RegionAZ2=us-west-1c \
    VPCCIDR=10.10.0.0/24
