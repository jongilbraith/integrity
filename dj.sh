#!/bin/bash
echo $$ > log/dj.pid;
exec 2>&1 rake jobs:work >> log/dj.out
