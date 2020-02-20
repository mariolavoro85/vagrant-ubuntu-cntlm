# [Ubuntu 18.04 with Cntlm](#ubuntu-18.04-with-cntlm)

  - [Requirements](#requirements)
  - [Usage](#usage)
  - [License](#license)

## [Requirements](#requirements)
- [Git: '>=2.24'](https://git-scm.com/downloads)
- [Virtualbox: '>=6.0'](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant: '>=2.2.6'](https://www.vagrantup.com/downloads.html)
    ```bash
    # Check tools version
    git --version && vagrant -v && VBoxManage -v
    ```
- [Vagrant box: 'ubuntu-18.04-cntlm'](https://app.vagrantup.com/mariolavoro85/boxes/ubuntu-18.04-cntlm)
    ```bash
    # download the box
    vagrant box add mariolavoro85/ubuntu-18.04-docker
    ```
- Environment vars:
    ```bash
    # Virtualbox Adapter
    export VAGRANT_ETHERNET_ADAPTER='VirtualBox Host-Only Ethernet Adapter'

    # Cntlm config, replace with your final values
    export VAGRANT_CNTLM_USERNAME='proxy username'
    export VAGRANT_CNTLM_PASSWORD='proxy text plain password'
    export VAGRANT_CNTLM_PROXY='proxy-example.io:8080'
    export VAGRANT_CNTLM_NO_PROXY='localhost,127.0.0.*,10.*,192.168.*'
    ```

## [Usage](#usage)

```bash
# download from the ufficial repository
git clone https://github.com/mariolavoro85/ubuntu-cntlm.git cntlm

# enter in the new folder
cd cntlm && ls -al

# run vagrant to create and start the proxy service
vagrant up --provision

# Test the proxy
curl --proxy 'http://192.168.56.101:3128' ifconfig.co/ip

# Destroy the machine
vagrant destroy -f

```

## [License](#license)

"The MIT License (MIT)

Copyright (c) 2020, mariolavoro85.  All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE."