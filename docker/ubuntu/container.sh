#!/bin/bash
set -e

function run_ubuntu()
{
    local args="$args --cap-add SYS_PTRACE"

    args="$args -v $project_path:$project_path"
    args="$args -w $project_path"

    run_cmd "docker run -d -it $args --name $ubuntu_container $ubuntu_image"
}

function rm_ubuntu()
{
    rm_container $ubuntu_container
}

function to_ubuntu()
{
    run_cmd "docker restart $ubuntu_container && docker attach $ubuntu_container"
}

function restart_ubuntu()
{
    rm_ubuntu
    run_ubuntu
}
