


#!/bin/bash


group_name='docker'
echo "finding security group id of ${group_name}"

aws ec2 describe-security-groups \
    --query "SecurityGroups[?GroupName == '${group_name}'].GroupId"




# lets fail the scrip if number of arguments is not six
number=$#

if [[ $number -ne 6 ]]; then
    echo "wrong usage you are supposed to 6 arguments"
    echo ''' Try following command
    ./manageec2.sh ami-00bb6a80f01f03502 t2.micro my_idrsa subnet-067813a42fb6cbebe from-cli sg-077690d1b4c7e9836
    '''
    exit 1
fi

image_id=$1
instance_type=$2
key_name=$3
subnet_id=$4
name=$5
sg_id=$6


echo "number of arguments passed are ${number}"


 aws ec2 run-instances \
    --image-id "ami-00bb6a80f01f03502" \
    --instance-type "t2.micro" \
    --key-name "my_idrsa" \
    --subnet-id "subnet-067813a42fb6cbebe" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=from-cli}]" \
    --associate-public-ip-address \
    --security-group-ids "sg-077690d1b4c7e9836"


aws ec2 run-instances \
    --image-id ${image_id} \
    --instance-type ${instance_type} \
    --key-name ${key_name} \
    --subnet-id ${subnet_id} \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${name}}]" \
    --associate-public-ip-address \
    --security-group-ids ${sg_id}