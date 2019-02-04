cmake_minimum_required(VERSION 3.1)

# HUNTER dependencency manager
option(HUNTER_ENABLED "Enable Hunter package manager" ON)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.23.95.zip"
    SHA1 "58b72c45e08beaca186e9c32ec6f1fabf010e655"
    LOCAL
)

project(HunterIssues)

hunter_add_package(Boost COMPONENTS chrono)
