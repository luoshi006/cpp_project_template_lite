#include <iostream>
#include <string>

#include "git_version.h"
#include "log.h"

using namespace cpt::base;

int main(int argc, const char **argv)
{
    log_inf("Hello world!");
    log_inf("git version: {}", git_version::get_git_commit());
    log_inf("git tag    : {}", git_version::get_git_version());
    log_inf("git branch : {}", git_version::get_git_branch());
    log_inf("git date   : {}", git_version::get_git_date());
    log_inf("build time : {}", git_version::get_build_time());
    log_inf("build host : {}", git_version::get_build_hostname());
    return 0;
}