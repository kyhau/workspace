

current_ami="hello"

latest_ami=`aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id --region ap-southeast-2 --query "Parameters[0].Value" | awk -F \" '{print $2}'`

echo $latest_ami


if [[ "$current_ami" = "$latest_ami" ]]; then
    exit 0
else
    exit 1
fi