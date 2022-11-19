#!/bin/bash

# Remove all none images & none containers
# Usage: ./clean_none.sh [OPTION]
#   -l, --last      remove last image created
#   -i, --image     remove specific image by id
#   -e, --exited    remove all exited containers
#   -c, --container remove specific container by id
#   -h, --help      display this help and exit

images=$(docker images | grep '^<none>' | awk '{print $3}')
conts=$(docker ps -a | grep '^<none>' | awk '{print $1}')

if [ -n "$images" ]; then
    docker rmi -f $images
else 
    echo "No none images"
fi

if [ -n "$conts" ]; then
    docker rm -f $conts
else
    echo "No none containers"
fi

# --------------------------------[ARGS]-------------------------------- #

if [ $# -eq 0 ]; then
    echo
    # echo "No argument supplied"
    exit 1

elif [ $1 == '-l' ] || [ $1 == '--last' ]; then
    # Cecking if there's any images exists
    if [[ "$(docker images -q)" == "" ]]; then
        echo
        echo "No images to delete"
    else 
        echo
        echo "Deleting last image created"
        last=$(docker images | head -n 2 | tail -n 1 | awk '{print $3}')
        docker rmi -f $last
        # Checking if the last image is deleted or not
        if [ $? -eq 0 ]; then
            echo
            echo "Last image deleted"
        else
            echo
            echo "Last image not deleted"
            echo
            read -p "Do you want to stop and delete the container? [y/n] " ans
            if [ $ans == 'y' ]; then
                docker ps
                echo
                read -p "Enter container ID: " cont_id
                docker stop $cont_id
                docker rm $cont_id
                docker rmi -f $last
                echo
                echo "Last image deleted"
            else
                echo
                echo "Last image not deleted"
            fi
        fi
    fi

elif [ $1 == '-i' ] || [ $1 == '--image' ]; then
    echo
    echo "Deleting image $2"
    image=$2
    if [ -n "$image" ]; then
        docker rmi -f $image
    else
        echo
        echo "No image supplied"
    fi

elif [ $1 == '-e' ] || [ $1 == '--exited' ]; then
    echo
    echo "Deleting all exited containers"
    conts=$(docker ps -a | grep 'Exited' | awk '{print $1}')
    if [ -n "$conts" ]; then
        docker rm -f $conts
    else
        echo
        echo "No exited containers"
    fi

elif [ $1 == '-c' ] || [ $1 == '--container' ]; then
    echo
    echo "Deleting container $2"
    cont=$2
    if [ -n "$cont" ]; then
        docker rm -f $cont
    else
        echo
        echo "No container supplied"
    fi
    
elif [ $1 == '-h' ] || [ $1 == '--help' ]; then
    echo
    echo "Usage: clean_none.sh [OPTION]"
    echo "Remove none images and none containers"
    echo
    echo "  -l, --last      remove last image created"
    echo "  -i, --image     remove specific image by id"
    echo "  -e, --exited    remove all exited containers"
    echo "  -c, --container remove specific container by id"
    echo "  -h, --help      display this help and exit"
    echo
else
    echo
    echo "Invalid argument"
fi