#!/bin/bash

set -e

project_path=$(cd $(dirname $0); pwd -P)
project_docker_path="$project_path/docker"
source $project_docker_path/bash.sh                                 # base function
developer_name=$('whoami');

#----------------------
# if has config center .env
#----------------------

app_basic_name=$(read_kv_config .env APP_NAME);               # app base bane

app="$developer_name-$app_basic_name"

ubuntu_image=hoseadevops/ubuntu18.04-gcc:1.0

# container
ubuntu_container=$app-ubuntu

# container dir
project_docker_ubuntu_path="$project_docker_path/ubuntu"

project_docker_runtime_dir="$project_docker_path/runtime"           # app runtime
project_docker_persistent_dir="$project_docker_path/persistent"     # app persistent

#---------- ubuntu container ------------#
source $project_docker_ubuntu_path/container.sh

function run()
{
    run_ubuntu
}

function clean()
{
    rm_ubuntu
}

function restart()
{
    clean
    run
}

function clean_all()
{
    clean
    clean_runtime
    clean_persistent
}

function clean_runtime()
{
    echo 'clean_runtime'
    #run_cmd "rm -rf $project_docker_runtime_dir/app"
}

function clean_persistent()
{
    #run_cmd "rm -f $project_docker_persistent_dir/config"
    #run_cmd "rm -rf $project_docker_persistent_dir/mysql"
    echo 'clean_persistent'
}

function help()
{
cat <<EOF
    Usage: sh docker.sh [options]

        Valid options are:

        run
        stop
        restart

        clean
        clean_all

        to_ubuntu

        help  show this message
EOF
}

action=${1:-help}
ALL_COMMANDS="run stop clean restart clean_all to_ubuntu"
list_contains ALL_COMMANDS "$action" || action=help
$action "$@"

