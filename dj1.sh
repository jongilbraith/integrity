#!/bin/bash
echo $$ > log/dj1.pid;
exec 2>&1 rake jobs:work >> log/dj1.out
