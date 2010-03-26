#!/bin/bash
echo $$ > log/dj3.pid;
exec 2>&1 rake jobs:work >> log/dj3.out
