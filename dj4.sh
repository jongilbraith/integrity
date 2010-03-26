#!/bin/bash
echo $$ > log/dj4.pid;
exec 2>&1 rake jobs:work >> log/dj4.out
