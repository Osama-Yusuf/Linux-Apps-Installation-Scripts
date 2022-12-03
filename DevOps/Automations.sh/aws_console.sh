# This app creates a url that logs in to your aws account from the .aws/credentials
# But before that, it checks if the tool is installed and if the credentials are set
install_awsC(){
    # 1. Download the PKG
    wget https://github.com/joshdk/aws-console/releases/download/v0.3.0/aws-console-linux-amd64.tar.gz
    # 2. Untar it
    tar -xf aws-console-linux-amd64.tar.gz
    # 3. Install it in /usr/bin
    sudo install aws-console /usr/bin/aws-console
    # 4. Finally delete unnecessary
    rm -fr aws-console aws-console-linux-amd64.tar.gz README.md LICENSE.txt
}

# ------ Lets check if aws-console is installed in /usr/bin/aws-console ------ #
if [ ! -f /usr/bin/aws-console ]; then
    echo "aws-console is not installed"
    echo
    echo "installing aws-console"
    install_awsC
    clear
    echo "aws-console has been installed in /usr/bin/aws-console"
    echo
fi
# ---------------------------------------------------------------------------- #

# ----------------- Now lets check if the credentials are set ---------------- #
if [ ! -f ~/.aws/credentials ]; then
    echo "Credentials are not set, Please set the credentials first"
    exit 1
fi
# ---------------------------------------------------------------------------- #

# ------------- Now lets check if the profile is passed and valid ------------ #
# if the sescond argument is not set, then we will use the default profile
if [ -z $2 ]; then
    prof="Default"
else
    # check if the second argument is a valid profile name
    pfs=$(grep -oP '(?<=\[).*(?=\])' ~/.aws/credentials)
    # first get all the profile names, then create an array of them
    pfs_arr=($pfs)
    # if the for loop does not execute the arg22 variable will be false which means the profile name is not valid and the script will exit
    arg22="false"
    for i in "${pfs_arr[@]}"; do
        if [ $i = $2 ]; then
            echo "Profile name is $2">/dev/null
            prof=$2
            arg22="true"
        fi
    done
    if [ $arg22 = "false" ]; then
        echo "This profile $2 does not exist"
        exit 1
    fi
fi
# ---------------------------------------------------------------------------- #

# ------------- Now lets check if there is any browser installed ------------- #
# UsBr=$1
# check_browsers(){
#     browsers=("google-chrome" "chrome" "edge" "microsoft-edge" "brave" "brave-browser" "safari" "firefox" "chromium" "chromium-browser" "opera")
#     for browser in "${browsers[@]}"; do
#         if [ ! -f /usr/bin/$browser ]; then
#             if [ $browser = $UsBr ]; then
#                 echo "$UsBr is not installed"
#                 echo
#                 echo -e "here's the url:\n\n$(aws-console $2)"
#                 exit 1
#             fi
#         elif [ -f /usr/bin/$UsBr ]; then
#             echo "$UsBr is installed">/dev/null
#         else 
#             echo "$UsBr is not installed"
#             echo
#             echo -e "here's the url:\n\n$(aws-console $2)"
#             exit 1
#         fi
#     done
#     echo "Opening $prof aws-console in $UsBr"
# }
# ---------------------------------------------------------------------------- #

if [ $1 = "edge" ] || [ $1 = "microsoft-edge" ] ; then
    # check_browsers
    microsoft-edge $(aws-console $2) &
elif [ $1 = "firefox" ]; then
    # check_browsers
    firefox $(aws-console $2) &
    echo done
elif [ $1 = "safari" ]; then
    # check_browsers
    safari $(aws-console $2) &
elif [ $1 = "chrome" ] || [ $1 = "google-chrome" ]; then
    # check_browsers
    google-chrome $(aws-console $2) &
elif [ $1 = "brave" ] || [ $1 = "brave-browser" ]; then
    # check_browsers
    brave-browser $(aws-console $2) &
# check if only one argument is passed
elif [ $# -eq 2 ]; then
    # check_browsers
    echo -e "here's the url:\n\n$(aws-console $2)"
elif [ $# -eq 1 ]; then
    # check_browsers
    echo -e "here's the url:\n\n$(aws-console)"
else
    echo "No browser or profile was passed, opening in firefox"
    firefox $(aws-console) &
    echo -e "here's the url:\n\n$(aws-console)"
fi
# ---------------------------------------------------------------------------- #