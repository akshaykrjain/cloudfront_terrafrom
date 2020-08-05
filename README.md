# cloudfront_terraform
Setting up CloudFront Distribution using Terraform. 
![infrastructure](architecture.jpg)


# Pre-Requisite
- node.js 
- aws cli
- 

## Dummy App

```
npx create-react-app my-app
cd my-app
npm run build 
```

## Create S3 Buckets
- 

## Copy Scripts to Bucket-1
```
cd my-app
aws s3 cp --recursive build/ s3://xyz-gmbh-app-scripts/  --exclude "*static/*"  (TODO aws s3 sync)
```

## Copy Static Files to Bucket-2
```
aws s3 cp --recursive ./build/static/ s3://xyz-gmbh-static-data/static/  (TODO aws s3 sync)
```

## Test
try this - https://www.intricatecloud.io/2018/04/creating-your-serverless-website-in-terraform-part-2/
or write a python or shell
