#!/bin/bash
geth --config config.toml --unlock 0x058693c4b4c77defc69c37982d291a63ba5c5fa9 --password ./passwd --targetgaslimit '9000000' --mine
