# vpcandflowlogs

Infrastructure-as-Code (IaC) templates for deploying a secure AWS VPC and enabling encrypted VPC Flow Logs to CloudWatch Logs using KMS and IAM roles. Designed for sandbox or production environments in `us-west-1`.

---

## Ì≥Å Files Included

| File | Description |
|------|-------------|
| `vpc.yaml` | Creates a secure VPC with private subnets, custom NACLs, SSM endpoints, and IAM roles for EC2 access. |
| `vpc-flowlogs-encrypted.yaml` | Provisions a KMS key, CloudWatch log group, IAM roles, and enables VPC Flow Logs for a given VPC. |
| `deploy-flowlogs.sh` | Bash script to discover the VPC by tag and deploy `vpc-flowlogs-encrypted.yaml` with the appropriate parameters. |

---

## Ì∫Ä Quickstart

### Deploy VPC:
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
```

### Deploy VPC Flow Logs:
```bash
chmod +x deploy-flowlogs.sh
./deploy-flowlogs.sh
```

---

## Ì≥å Tags Used

Make sure your VPC is tagged:
```
Key:   Name
Value: SANDBOX-prod-w-vpc
```

---

## Ì≥ú License

This project is licensed under the MIT License.
