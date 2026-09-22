OpenDSS-C is an electric power distribution system simulator (DSS) designed to support distributed energy resource (DER) grid integration and grid modernization. It enables engineers to perform complex analyses using a flexible, customization, and easy to use platform intended specifically to meet current and future distribution system challenges and provides a foundation for understanding and integrating new technologies and resources. This power system analysis software tool was translated from the Delphi computer language (Electric Power Research Institute, 2022) into C++ to make it accessible to a larger community of software developers and used as a core library upon which to build new capabilities. OpenDSS (the Delphi version) that runs on a Windows operating system is available at the [software repository](https://sourceforge.net/p/electricdss/code/HEAD/tree/) along with the C++ version. The C++ mimics the Delphi version, which is the reference.

This guide documents the process for building the OpenDSS – C++ version (henceforth referred to as OpenDSS-C) for the Microsoft Windows 10 and Red Hat Enterprise Linux 8 (RHEL 8) Operating System (OS). Build instructions are provided using Clang/CMake in a command line environment. Software developers are welcome to contribute instructions to this guide for building OpenDSS-X for other IDEs and OS.

**Compile using CMD**

For compiling OpenDSS-C in Linux, macOS or Windows make sure you have the following add-ons installed:

CMake, UUI-Dev, Build\_essential

For installing the add-ons required execute the following commands:

* 1. *sudo apt-get install cmake*
  2. *sudo apt-get install uuid-dev*
  3. *sudo apt-get install build-essential*

After installed in your local environment, you are ready to compile the project. This is probably the simplest way to compile the project, however, a couple of requisites must be fulfilled.

* 1. Step out the projects folder to compile from the outside.
  2. Create a Build folder. This is where the DLL/so/EXE will be stored.
  3. Set the target, for that enter the following commands (assume that the folder where the source code of OpenDSS is located at the folder OpenDSSC:

*cmake -DCMAKE\_BUILD\_TYPE=Release -DMyOutputType:STRING=EXE ../OpenDSSC*

* 1. Compile using the following command

*cmake --build . -j 12*

As can be seen in step 3, the type of output (EXE/DLL) is specified in the argument -DMyOutputType. If the user wants to generate a command line executable use the value EXE, otherwise, use DLL (no matter the operating system). The build type or compilation purpose must be specified at the argument *-DCMAKE\_BUILD\_TYPE*. At the example presented on step 3 the compilation is for a release version. Otherwise, the user can use Debug if required.

The C++ version in Linux uses a default in-console editor for displaying reports (like when using the command "Show"). If you are interested in using a text editor, OpenDSS offers compatibility with gedit. For that, users will have to install gedit in their Linux distribution.

*sudo apt-get install gedit*