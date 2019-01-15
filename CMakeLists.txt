cmake_minimum_required(VERSION 3.1)

# HUNTER dependencency manager
option(HUNTER_ENABLED "Enable Hunter package manager" ON)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.23.89.zip"
    SHA1 "c989bf8c435d930f653c326e953949b7c19168ee"
    LOCAL
)

project(HunterIssues)

hunter_add_package(Boost COMPONENTS chrono)
