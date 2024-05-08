#!/bin/bash

sudo docker stop $(sudo docker container ls | awk -F ' ' '{print$1}')
