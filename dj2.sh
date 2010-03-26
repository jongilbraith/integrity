#!/bin/bash
echo $$ > log/dj2.pid;
exec 2>&1 rake jobs:work >> log/dj2.out
