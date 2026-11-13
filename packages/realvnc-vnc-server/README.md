# RealVNC package recipe

This recipe keeps RealVNC installation reproducible while the AUR recipe still targets 7.18.0 with a checksum that no longer matches its download.

The 7.18.1 Linux x64 DEB is fetched directly from RealVNC and checked against [RealVNC's published SHA256](https://help.realvnc.com/hc/en-us/articles/5835892358941-SHA256-checksums-for-RealVNC-Connect-v7). The downloaded file was independently verified against that published value. Checksums are never skipped.

The packaging layout and install hooks are based on [the AUR recipe](https://aur.archlinux.org/realvnc-vnc-server.git) at commit `c7d96d8aff0fb0511e78f12e87b6640b308b8985` (upstream maintainers: ava1ar and Kewl; contributor: Star Brilliant). Vendor binaries are not stripped or used to generate debug packages. The vendor's license is installed with the package; use of RealVNC still requires its normal configuration and licensing.

The GTK2 UI dependency is installed from the official Arch archive at version 2.24.33-5 (also the current AUR GTK2 version). Both the pinned SHA256 and the Arch package signature are verified before installation; newer installed GTK2 versions are preserved. The systemd drop-in orders the server after the display manager and terminates its whole process group on restart so helper processes do not accumulate. GTK2 uses the built-in Raleigh theme because Materia's legacy theme engines are no longer in the current official repositories.

The installer does not enable the unconfigured, unlicensed VNC service: its status window can cover the LightDM login prompt. After setting up RealVNC licensing, enable remote access explicitly with `sudo systemctl enable --now vncserver-x11-serviced`. Existing configured services are not disabled by the installer.
