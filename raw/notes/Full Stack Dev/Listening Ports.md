# Overview
When a program opens a listening port, it binds to a **specific network interface** --- a network "identity" of my machine. My laptop has several:

* **Loopback (127.0.0.1 / *localhost)*** --- a virtual interface that only processes *on the same machine* can reach. Nothing on my Wi-Fi network, and nothing inside a Docker container, can connect to it.
* **My LAN adapter**