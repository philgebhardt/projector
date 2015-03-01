#!/bin/bash
#sudo ./getstuff.sh
sudo rm -rf /var/lib/projector
sudo mkdir -p /var/lib/projector/bin
sudo cp bin/pj.rb /var/lib/projector/bin/pj
sudo rm -f /usr/bin/pj
pushd . > /dev/null
cd /usr/bin
sudo ln -s /var/lib/projector/bin/pj .
popd  > /dev/null
sudo cp -rf lib/ /var/lib/projector

