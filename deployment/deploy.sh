#!/bin/bash

#send script to ubuntu box
#ssh into ubuntu box
#run script in box to assure directory and clean files
#exit box
#send files to directory
#execute node stuff

AUTH=~/.ssh/id_random-colors-box

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR && cd ..

scp -i $AUTH $DIR/setup.sh ubuntu@ec2-54-200-138-217.us-west-2.compute.amazonaws.com:~/

ssh -i $AUTH ubuntu@ec2-54-200-138-217.us-west-2.compute.amazonaws.com "chmod +x setup.sh && sh setup.sh"

tar -czvf project.tar.gz --exclude=node_modules/  --exclude=.git/ --exclude=.DS_Store --exclude=.idea/ .

scp -i $AUTH project.tar.gz ubuntu@ec2-54-200-138-217.us-west-2.compute.amazonaws.com:~/deployment

ssh -i $AUTH ubuntu@ec2-54-200-138-217.us-west-2.compute.amazonaws.com 'bash -s' < $DIR/runNode.sh

echo "Press any key to exit..."
read -n 1 -s