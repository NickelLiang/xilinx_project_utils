# Xilinx Project Creation Helpers
These scripts can help you easily create a git-compatible, well-definied
Xilinx Vivado and Vitis project.

## Project Generation
To create project, use `project_generator.sh`.

To use the script interactively, simply do `$ sh project_generator.sh` and
follow the instructions.

To use the commandline mode, you can use following arguments:

| short arg |   long arg   |                                         description                                         |
|:---------:|:------------:|:-------------------------------------------------------------------------------------------:|
|    `-a`   |    `--all`   |                  Generate complete project structure.Equivalent to `-gstv`.                 |
|    `-g`   |    `--git`   |              Copy `.gitignore` file to project directory specified by `--path`.             |
|    `-h`   |   `--help`   |                                 Display this helper message.                                |
|    `-n`   |   `--name`   |                               Specify the name of the project.                              |
|           | `--noreadme` |                         Do not create README.md file in each folder.                        |
|    `-p`   |   `--path`   |                            Specify the path to project directory.                           |
|           |   `--part`   |                                Sepcify the FPGA part number.                                |
|    `-s`   | `--software` | Create software directories in both `source` and project directory specified with `--path`. |
|    `-t`   |   `--vitis`  |                Generate Xilinx Vitis project folder and copy helper scripts.                |
|    `-v`   |  `--vivado`  |                Generate Xilinx Vivado project folder and copy helper scripts.               |

`README.md` file will be created in each directory so that all directories can
be uploaded to git. If you do not wnat this, use `--noreadme` option.

For more information, do `$ sh project_generator.sh -h`.

### Usage
The following command will create a project with predefined `.gitignore` file
and create Vitis and Vivado project structure with project name `lab01` for 
`xc7a75tfgg484-1` FPGA in `../lab01_folder`.

`$ bash project_generator.sh -gtv -n lab01 -p ../lab01_folder --part xc7a75tfgg484-1`

You can also use interactive mode by running the following command and follow
the instruction.

`$ bash project_generator.sh`

### Dependencies
Currently this script is only verified on Ubuntu 18.04 and note yet tested with
any bash shell in Windows. Let me know if it work if you tried in Windows.

The command parsing require the `gnu-getopt`. It should be available on most
linux machines.

And ofcourse, you need a valid Vivado installation and set Vivado path in your
system `$PATH` variable, if you want to create Vivado project with this script.

## Create Vitis Project
The Vitis project creation script will be automatically copied into the Vitis 
project script by executing the project generator. You need to have a valid 
`.xsa` file in a folder called `../vivado/` by default. If you create project 
with the project creation script, `create_vitis_project.tcl` script will work.

The script will search for the `.xsa` file and automatically create a Vitis 
**baremetal** project for **Microblaze** processor. 

What's more, the script will create linked resource for all firmware sources in
`../source/fw/` by modfying the `.project` Vitis project description file, 
so you can safely store all your source files together in the `source` folder.

The `.gitignore` file will ignore all Vitis project file.

### Usage
Just run the script.

### Dependencies
You need a valid Vitis installation and set Vitis path in your system `$PATH`
variable.

## Recreate Vivado Project
You should always re-export your Vivado project by using the "Write project tcl" 
function in Vivado. You can reference from XAPP1165 for more detail.

Make sure you overwrite the initial project tcl script, so that you can use the
shell script in `vivado` folder to recreate project in the future, or easily
share your project with you colleague. 

### A Note on Block Design and IP
To make sure the `.gitignore` can work properly, you should put you block 
designs in the `../source/hdl/block_designs/` folder, and your IPs in 
`../source/hdl/xilinx_ips/` folder.

## Contribute
These scripts are still simple and naive. Feel free to modify these scripts.
Feel free to create PR.