# Welcome to MINUX!

> MINUX is a minimalist Arch Linux-based distribution.<br/>
> In fact, it is a customized ISO for my personal environment.<br/>
> Check [here](https://github.com/kuper0201/minux_ml_iso) if you want to download MINUX ISO.

# What is this?

Base scripts for build MINUX environment.

The installer stops on package, AUR, or configuration errors. NVIDIA open kernel modules and the Docker NVIDIA runtime are configured only when an NVIDIA PCI device is detected; the open driver requires a supported GPU. Systems without NVIDIA hardware keep the Docker and micromamba environment without installing that driver.
