# Ubuntu Touch

First need to create a arm build environment, we use here lxc:

- Get lxc image
- Install libs in client
- Activate networking

TODO docs

We first need the QtQuick.Control libs

::

    $ python3 get_libs.py


Build::

    $ make

Click::

    $ cp ../tensor .
    $ click build .

Install it on you phone, reboot to get shown up::

    $ pkcon install-local --allow-untrusted Downloads/tensor.delijati_0.4.1_armhf.click

