#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# current script name
script=${BASH_SOURCE[0]}

# symlink
symlink $dir/icons ~/.local/share/fonts/icons
symlink $dir/monospace ~/.local/share/fonts/monospace
symlink $dir/regular ~/.local/share/fonts/regular

# compare md5sum to check if the fonts changed
touch ~/.local/share/fonts-md5sum
old=$(<~/.local/share/fonts-md5sum)
new=$(find ~/.local/share/fonts | sort | md5sum)

if [[ $old != $new ]] ; then 
    sudo fc-cache -f >> /dev/null
    printf "%s" "$new" > ~/.local/share/fonts-md5sum
    log_info "fonts successfully installed at: [$HOME/.local/share/fonts]" "$script"
else
    log_info "fonts already installed at: [$HOME/.local/share/fonts]" "$script"
fi

#  # verify if has changes in fonts
# if [[ $(diff -qr shared/appearance/fonts ~/.local/share/fonts/shared | grep -v uuid) ]] ; then

#     cp -r shared/appearance/fonts/* ~/.local/share/fonts/shared 
#     sudo fc-cache -f -v >> /dev/null
#     echo "fonts successfully installed at: [$HOME/.local/share/fonts]"
    
# else




# ########################################
# shared::symlink_fonts() {

#     echo -e "\n:: starting shared fonts"

#     mkdir -p ~/.local/share/fonts/shared
#     new=$(find ~/.local/share/fonts/shared | sort | md5sum)

#     touch ~/.local/share/fonts/md5sum
#     old=$(<~/.local/share/fonts/md5sum)

#     # compare md5sum to check if the fonts changed
#     if [[ $old != $new ]] ; then 

#         sudo rm -rf /usr/share/fonts/common
#         utils::symlink shared/fonts ~/.local/share/fonts/shared
#         sudo fc-cache -f -v >> /dev/null
#         printf "%s" "$new" > ~/.local/share/fonts/md5sum

#         echo "fonts successfully installed at: [$HOME/.local/share/fonts]"

#     else
#         echo "fonts already installed at: [$HOME/.local/share/fonts]"
#     fi

#     echo -e ":: finished common fonts\n"
# }



# #######################################
# # Function to install fonts at user home
# #
# # Arguments:
# #   None
# ########################################
# shared::appearance_fonts() {
  
#     echo -e "\n:: starting shared fonts"

#     mkdir -p ~/.local/share/fonts/shared

#     # verify if has changes in fonts
#     if [[ $(diff -qr shared/appearance/fonts ~/.local/share/fonts/shared | grep -v uuid) ]] ; then

#         cp -r shared/appearance/fonts/* ~/.local/share/fonts/shared 
#         sudo fc-cache -f -v >> /dev/null
#         echo "fonts successfully installed at: [$HOME/.local/share/fonts]"
        
#     else
#         echo "fonts already installed at: [$HOME/.local/share/fonts]"
#     fi

#     echo -e ":: finished shared fonts\n"
    
# }