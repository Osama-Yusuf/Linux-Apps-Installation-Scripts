#!/bin/bash

# check if argument is help or -h or --help or none
if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ -z "$1" ]; then
    echo """This script scans, saves and starts/stops/terminates instances in AWS.

Usage:
  1. bash aws_ec2.sh scan save
  2. bash aws_ec2.sh check [region]
  3. bash aws_ec2.sh [start|stop|terminate|ip] [region] [instance_id]

./aws_ec2.sh
    scan                                scans all regions and saves only scan result in $rgs_dir/scan
    scan save                           scans and saves the instances ids for further use in $rgs_dir

    regions                             lists all saved regions, but you must first scan and save the instances
    [region]                            print info about instances inside passed region

    [command] [region] [instance_id]    [start|stop|terminate|ip|check] but you must first scan and save the instances

Eg: ./aws_ec2.sh start us-east-1                         starts all instances in us-east-1
Eg: ./aws_ec2.sh start us-east-1 i-050b7d36ad76bddea     starts a specific instance in us-east-1
    """
	exit 1
fi

# check if aws cli is installed
if ! [ -x "$(command -v aws)" ]; then
	echo "Error: aws cli is not installed." >&2 && echo
	echo """To install aws cli do the following:
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
	sudo ./aws/install && rm -rf aws awscliv2.zip
	"""
	exit 1
fi

# create a directory to store the scan result and the regions
rgs_dir="$HOME/.aws/regions"
# check if rgs_dir exists
if [ ! -d "$rgs_dir" ]; then
	mkdir -p "$rgs_dir"
fi

# --------------------- scan all aws regions for instance -------------------- #
scan(){
	regions=("us-east-1" "us-east-2" "us-west-1" "eu-west-2" "ap-south-1" "ap-northeast-1" "ap-northeast-2" "ap-northeast-3" "ap-southeast-1" "ap-southeast-2" "ca-central-1" "eu-central-1" "eu-west-1" "eu-west-2" "eu-west-3" "sa-east-1")
	for region in "${regions[@]}"; do
		aws ec2 describe-instances --region "$region" --query 'Reservations[*].Instances[*].{InstanceType: InstanceType, InstanceId: InstanceId, State: State.Name, Name: Tags[?Key==`Name`].Value|[0]}' --output text | while read -r line; do
			instance_type=$(echo "$line" | awk '{print $2}')
			instance_id=$(echo "$line" | awk '{print $1}')
			state=$(echo "$line" | awk '{print $4}')
			name=$(echo "$line" | awk '{print $3}')
			# if region has more than one instance don't repeat the region name for eahc instance
			if [ "$region" != "$prev_region" ]; then
				echo >> $rgs_dir/scan
				echo "Region: $region" >> $rgs_dir/scan
				prev_region="$region"
			fi
			echo "Name: $name, State: $state, Instance type: $instance_type, Instance id: $instance_id" >> $rgs_dir/scan
			# check if 2nd argument is "save" then save the instance id in a file
			if [ "$2" == "save" ]; then
				echo "$instance_id " | tr -d '\n' >> $rgs_dir/"$region".txt
			fi
		done
	done
}
if [ "$2" == "save" ]; then
    # check if there's any files in $rgs_dir
    if [ "$(ls -A $rgs_dir)" ]; then
        # if there is, then remove them
        rm $rgs_dir/*.txt
    fi
	echo "Scanning in progress..."
	rm $rgs_dir/scan > /dev/null 2>&1
	scan "$@"
	cat $rgs_dir/scan
	exit 1
elif [ "$1" == "scan" ]; then
    cat $rgs_dir/scan
    exit 1
fi
# ---------------------------------------------------------------------------- #

# ------------------ check if there's regions saved & valid ------------------ #
# check if regions file exists
check_rgs(){
	if [ "$(ls -A $rgs_dir)" ]; then
		for i in $(ls $rgs_dir); do
			echo $i > /dev/null
		done
	else
		echo "No regions saved in $rgs_dir, Please run the script with the scan argument"
		exit 1
	fi
}
# check if giving region is valid
check_rgs2(){
		# check if passed region exist in $rgs_dir
	if [ ! -f "$rgs_dir/$1.txt" ]; then
		echo "Region $1 does not exist in $rgs_dir"
		exit 1
	fi
}
# ---------------------------------------------------------------------------- #

if [ $1 == "regions" ]; then
	check_rgs
    ls -rth $rgs_dir | grep -v scan | sed 's/.txt//g' 
	exit 1
fi

# if there is no second argument, then print the instances in the region
if [ $# -eq 1 ]; then
	check_rgs
	check_rgs2 "$1"
	for i in $(cat $rgs_dir/"$1".txt); do
		aws ec2 describe-instances --region "$1" --instance-ids "$i" --query 'Reservations[*].Instances[*].{InstanceType: InstanceType, InstanceId: InstanceId, State: State.Name, Name: Tags[?Key==`Name`].Value|[0]}' --output text
	done
	# cat $rgs_dir/"$1".txt && echo
fi
# if there is a second argument, then check if it is a valid command
if [ $# -eq 2 ]; then
	check_rgs
	if [ "$1" == "stop" ] || [ "$1" == "start" ] || [ "$1" == "terminate" ]; then
		# if the command is valid, then execute it for each instance in the region
		for i in $(cat $rgs_dir/"$2".txt); do
			aws ec2 "$1"-instances --region "$2" --instance-ids "$i" > /dev/null
            aws ec2 describe-instances --region "$2" --instance-ids "$i" --query 'Reservations[*].Instances[*].{InstanceType: InstanceType, InstanceId: InstanceId, State: State.Name, Name: Tags[?Key==`Name`].Value|[0]}' --output text
		done
	elif [ "$1" == "check" ]; then
        # check if the instances are running
        for i in $(cat $rgs_dir/"$2".txt); do
            aws ec2 describe-instances --region "$2" --instance-ids "$i" --query 'Reservations[*].Instances[*].{InstanceType: InstanceType, InstanceId: InstanceId, State: State.Name, Name: Tags[?Key==`Name`].Value|[0]}' --output text
        done
	elif [ "$1" == "ip" ]; then
		# get all the info of the instances
		for i in $(cat $rgs_dir/"$2".txt); do
			aws ec2 describe-instances --region "$2" --instance-ids "$i" --query 'Reservations[*].Instances[*].{InstanceType: InstanceType, InstanceId: InstanceId, State: State.Name, Name: Tags[?Key==`Name`].Value|[0], PublicIp: PublicIpAddress, PrivateIp: PrivateIpAddress}' --output text
		done
	# else
	else
		echo -e "Invalid command, Please use a valid command for help:\n./aws_ec2.sh help" && echo
		echo "Any way, here's your region instances:"
		cat $rgs_dir/"$2".txt && echo
	fi
elif [ $# -eq 3 ]; then
	check_rgs
	# execute start/stop/terminate command for the passed instance in the passed region
	if [ "$1" == "stop" ] || [ "$1" == "start" ] || [ "$1" == "terminate" ]; then
		aws ec2 "$1"-instances --region "$2" --instance-ids "$3" > /dev/null
		aws ec2 describe-instances --region "$2" --instance-ids "$3" --query 'Reservations[*].Instances[*].{InstanceType: InstanceType, InstanceId: InstanceId, State: State.Name, Name: Tags[?Key==`Name`].Value|[0]}' --output text
	elif [ "$1" == "check" ]; then
		aws ec2 describe-instances --region "$2" --instance-ids "$3" --query 'Reservations[*].Instances[*].{InstanceType: InstanceType, InstanceId: InstanceId, State: State.Name, Name: Tags[?Key==`Name`].Value|[0]}' --output text
	elif [ "$1" == "ip" ]; then
		aws ec2 describe-instances --region "$2" --instance-ids "$3" --query 'Reservations[*].Instances[*].{InstanceType: InstanceType, InstanceId: InstanceId, State: State.Name, Name: Tags[?Key==`Name`].Value|[0], PublicIp: PublicIpAddress, PrivateIp: PrivateIpAddress}' --output text
	else
		echo "Invalid command, Please use a valid command for help: ./aws_ec2.sh help"
	fi
fi