#!/bin/bash

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
# array of arguments
args=("$@")

# ---------------------- Displays help and exit ---------------------- #
if [ -z $1 ] || [ $1 == '-h' ] || [ $1 == '--help' ]; then
    echo
    echo "Removes none images and none containers"
    echo "Usage: clean_none.sh [OPTION]"
    echo
    echo "  -l, --last      remove last image created"
    echo "  -e, --exited    remove all exited containers"
    echo "  -i, --image     remove specific image/s by id"
    echo "  -c, --container remove specific container/s by id"
    echo "  -h, --help      display this help and exit"
    exit 1

# ---------------------- Deletes last image created ---------------------- #
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

# ---------------------- Deletes all exited containers ---------------------- #
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

# ---------------------- Deletes specific image/s by id ---------------------- #
elif [ $1 == '-i' ] || [ $1 == '--image' ]; then
    # variable that stores all arguments except the first one
    images=${args[@]:1}
    echo
    echo "Deleting image/s ${args[@]:1}"
    if [ -n "$images" ]; then
        docker rmi -f $images
    else
        echo
        echo "No images was given"
    fi

# -------------------- Deletes specific container/s by id -------------------- #
elif [ $1 == '-c' ] || [ $1 == '--container' ]; then
    # variable that stores all arguments except the first one
    conts=${args[@]:1}
    echo
    echo "Deleting container $conts"
    if [ -n "$conts" ]; then
        docker rm -f $conts
    else
        echo
        echo "No container supplied"
    fi
fi
