# 06 - AWS

Amazon Web Services is the most widely used cloud platform. This module covers the essentials.

## What You'll Learn

- AWS account setup and IAM
- EC2 (virtual machines)
- S3 (object storage)
- VPC (networking)
- RDS (managed databases)
- ECS/EKS (container services)
- CloudWatch (monitoring)
- IAM best practices

## Folder Structure

```
06-aws/
├── notes/       # Your notes from lessons
├── labs/        # Completed lab exercises
└── projects/    # Hands-on projects
```

## Suggested Projects

- [ ] Deploy an EC2 instance with proper security groups
- [ ] Host a static website on S3
- [ ] Set up a VPC with public/private subnets
- [ ] Deploy an application on ECS Fargate

## Key Services

| Service | Purpose |
|---------|---------|
| EC2 | Virtual machines |
| S3 | Object storage |
| VPC | Virtual network |
| RDS | Managed databases |
| ECS | Container orchestration |
| EKS | Managed Kubernetes |
| Lambda | Serverless functions |
| CloudWatch | Monitoring and logs |
| IAM | Identity and access |

## Useful CLI Commands

```bash
aws sts get-caller-identity     # Check who you're logged in as
aws ec2 describe-instances      # List EC2 instances
aws s3 ls                       # List S3 buckets
aws s3 cp file s3://bucket/     # Upload to S3
aws logs tail /aws/log-group    # Tail CloudWatch logs
```

## Cost Warning

AWS charges for resources. Always:
- Use free tier eligible resources when learning
- Set up billing alerts
- Destroy resources when done
- Check the pricing calculator before creating resources

## Resources

- [AWS Documentation](https://docs.aws.amazon.com/)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [AWS Pricing Calculator](https://calculator.aws/)
