# Nickel Liang (zuodong2@illinois.edu), March 2020.

proc print_help {} {
    puts "Usage:"
    puts "Specify the following parameters:"
    puts "\[--project_name <name>\] Project name will be used to identify the .xsa file."
    puts "\[--vivado_dir <path>\]   Specify the path of the Vivado project folder that contain .xsa file."
    puts "\[--source_dir <path>\]   Specify the path to the firmware source."
    exit 0
}

if { $::argc == 3*2 } {
    for {set i 0} {$i < $::argc} {incr i} {
        set option [string trim [lindex $::argv $i]]
        switch -regexp -- $option {
            "--project_name" { incr i; set project_name [lindex $::argv $i] }
            "--vivado_dir"   { incr i; set vivado_dir [lindex $::argv $i] }
            "--source_dir"   { incr i; set source_dir [lindex $::argv $i] }
            default {
                if { [regexp {^-} $option] } {
                    puts "ERROR: Unknown option '$option' specified.\n"
                    print_help
                    return 1
                }
            }
        }
    }
} else {
    print_help
    return 1
}

# This script can definitely be improved to incorporate more error check, support more processor, etc.
# Set workspace folder and enter. This will create the folder if the folder does not exist.
setws "./${project_name}"
cd "./${project_name}"

# Create application
app create -name ${project_name} -hw ../${vivado_dir}/${project_name}.xsa -os standalone -proc microblaze_0 -template {Empty Application}

importsources -name ${project_name} -path ../${source_dir}/

app build -name ${project_name}