# IPL Dumper

Dumps the system IPL over serial by means of the Pocket Challenge V2 bootstrap to evade the IPL lockout.

## Table of Contents

- [Requirements](#requirements)
- [Wiki](#requirements)
- [License](#license)

## Requirements

### Cross-platform

- Git `https://git-scm.com`
    - For use with the cloning of this repository
- NASM `https://www.nasm.us`
    - For use in the assembly of an un-encoded WonderWitch soft-app
- Perl `https://www.perl.org`
    - For use in the encoding of the WonderWitch soft-app for XMODEM transmission
- GNU Make `https://www.gnu.org/software/make/`
    - For use in the execution of the assembly and encoding processes of the WonderWitch soft-app

### Windows

> Optional but highly recommended.

- WSL1/2 *or* MSYS2 `https://www.msys2.org`
    - Packages exist for all of the above requirements.
- TeraTerm `https://ttssh2.osdn.jp`
    - For the use of transmitting the soft-app over XMODEM, as well as the retrieval of the IPL via its binary logging functionality.

## Wiki

Check out the [wiki](https://github.com/up-n-atom/wwsoft/wiki/IPL-Dumper) for hardware and software setup

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
