#!/usr/bin/fish
#
# Aim:
#    This code will add the directory of this toolkit into the PATH system variable. 
# 
# 
# BIN_SETUP_SCRIPT
if contains "Linux" (uname)
    set -x BIN_SETUP_SCRIPT (dirname (status --current-filename))/bin/bin_setup.bash
    set -x CRAB_TOOLKIT_DIR (dirname (status --current-filename))
end
if contains "Darwin" (uname)
    set -x BIN_SETUP_SCRIPT (dirname (perl -MCwd -e 'print Cwd::abs_path shift' (status --current-filename)))/bin/bin_setup.bash
    set -x CRAB_TOOLKIT_DIR (dirname (perl -MCwd -e 'print Cwd::abs_path shift' (status --current-filename)))
end
# 
# CHECK BIN_SETUP_SCRIPT
if [ x"$BIN_SETUP_SCRIPT" = x"" ]
    exit 255
else
    #echo "$BIN_SETUP_SCRIPT"
end
#
# SET PATH USING BIN_SETUP_SCRIPT
if not contains "$CRAB_TOOLKIT_DIR" $PATH
    set -gx PATH (string split ":" (bash -c "source $BIN_SETUP_SCRIPT -prepend -print" | tail -n 1))
end
#
# LIST COMMANDS TO CHECK
#set -x CRAB_TOOLKIT_CMD "find-and-delete" "pdf2png" "print_disk_available_space.py"
# 
# CHECK COMMANDS
# -- 20160427 only for interactive shell
# -- http://stackoverflow.com/questions/12440287/scp-doesnt-work-when-echo-in-bashrc
#if status --is-interactive
#  for TEMP_TOOLKIT_CMD in {$CRAB_TOOLKIT_CMD}
#    type $TEMP_TOOLKIT_CMD
#  end
#end


