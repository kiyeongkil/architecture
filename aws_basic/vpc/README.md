## **사전준비**

### **AWS CLI 설치**

- linux [URL](https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/install-cliv2-mac.html)
- windows [URL](https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/install-cliv2-windows.html)

터미널에서 AWS CLI 버전을 확인

```
$ aws --version
aws-cli/2.1.27 Python/3.7.4 Darwin/20.1.0 exe/x86_64 prompt/off
```

### **AWS Configure 설정**

Terraform 으로 AWS 리소스를 관리하기 위해서는 AWS CLI에 모든 리소스의 접근 권한을 가진 AWS IAM User 와 연동이 필요하다. 그러기 위해 AWS 리소스를 관리할 수 있는 권한을 가진 유저를 생성.

기존 정책 집적연결 중 **AdministratorAccess** 을 추가

생성된 사용자 정보는 한번만 나오지 잘 저장할 것

```
$ aws configure
AWS Access Key ID [None]: <액세스 키 ID>
AWS Secret Access Key [None]: <비밀 액세스 키>
Default region name [ap-northeast-2]: ap-northeast-2
Default output format [None]: json
```

---

## Inputs

| Name             | Description                                 |  Type  | Default | Required |
| ---------------- | ------------------------------------------- | :----: | :-----: | :------: |
| azs              | 사용할 availability zones 리스트            |  list  |    -    |   yes    |
| cidr             | VPC에 할당한 CIDR block                     | string |    -    |   yes    |
| database_subnets | Database Subnet IP 리스트                   |  list  |    -    |   yes    |
| name             | 모듈에서 정의하는 모든 리소스 이름의 prefix | string |    -    |   yes    |
| private_subnets  | Private Subnet IP 리스트                    |  list  |    -    |   yes    |
| public_subnets   | Public Subnet IP 리스트                     |  list  |    -    |   yes    |
| tags             | 모든 리소스에 추가되는 tag 맵               |  map   |    -    |   yes    |

## Outputs

| Name                      | Description                     |
| ------------------------- | ------------------------------- |
| database_subnet_group_id  | Database Subnet Group ID        |
| database_subnets_ids      | Database Subnet ID 리스트       |
| default_network_acl_id    | VPC default network ACL ID      |
| default_security_group_id | VPC default Security Group ID   |
| igw_id                    | internet gateway                |
| nat_ids                   | NAT gateway                     |
| nat_public_ips            | NAT Gateway에 할당된 EIP 리스트 |
| natgw_ids                 | NAT Gateway ID 리스트           |
| private_route_table_ids   | Private Route Table ID 리스트   |
| private_subnets_ids       | subnets                         |
| public_route_table_ids    | route tables                    |
| public_subnets_ids        | Public Subnet ID 리스트         |
| vpc_cidr_block            | VPC에 할당한 CIDR block         |
| vpc_id                    | VPC                             |
