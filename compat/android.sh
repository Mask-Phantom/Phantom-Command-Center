#!/usr/bin/env bash
# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

# Android SDK/Tools helpers

check_apktool_version() {
    local expected_version="v2.6.0"
    local current_version
    
    if ! command_exists apktool; then
        return 1
    fi
    
    current_version=$(apktool | sed -n 1p | awk '{print $2}')
    
    if [ "$current_version" = "$expected_version" ]; then
        return 0
    else
        return 1
    fi
}

install_apktool() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    
    # Remove old version if exists
    unlink "/usr/local/sbin/apktool" > /dev/null 2>&1 || true
    
    # Symlink new version
    ln -s "$path/tools/apktool/apktool" "/usr/local/sbin/apktool" > /dev/null 2>&1
    
    # Verify installation
    if command_exists apktool; then
        success "Apktool v2.6.0 installed"
        which apktool >> "$log" 2>&1
        echo "apktool" | tee -a "$config" >> /dev/null 2>&1
        echo "Apktool -> OK" >> "$inst"
        return 0
    else
        error "Apktool v2.6.0 installation failed"
        echo "0" > "$stp"
        echo "apktool -> Not OK" >> "$inst"
        return 1
    fi
}

# Main handler for apktool setup
setup_apktool() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    local green="$6"
    local red="$7"
    
    if check_apktool_version; then
        # Version is correct
        echo -e "$green" "[ ✔ ] Apktool v2.6.0..................[ found ]"
        which apktool >> "$log" 2>&1
        echo "apktool" | tee -a "$config" >> /dev/null 2>&1
        echo "Apktool -> OK" >> "$inst"
    else
        # Version mismatch or not installed - remove old and install new
        xterm -T "☣ REMOVE OLD APKTOOL ☣" -geometry 100x30 -e "sudo apt-get remove --purge apktool -y"
        
        if install_apktool "$path" "$log" "$config" "$inst" "$stp"; then
            echo -e "$green" "[ ✔ ] Apktool v2.6.0...................[Installed]"
        else
            echo -e "$red" "[ x ] Apktool v2.6.0"
        fi
    fi
}

# Baksmali 2.3.3 helpers

check_baksmali_version() {
    local expected_version="2.3.3"
    local current_version
    
    if ! command_exists baksmali; then
        return 1
    fi
    
    current_version=$(baksmali --version | grep "baksmali" | awk '{print $2}')
    
    if [ "$current_version" = "$expected_version" ]; then
        return 0
    else
        return 1
    fi
}

install_baksmali() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    
    # Remove old version if exists
    unlink "/usr/local/sbin/baksmali" > /dev/null 2>&1 || true
    
    # Symlink new version
    ln -s "$path/tools/baksmali233/baksmali" "/usr/local/sbin/baksmali" > /dev/null 2>&1
    
    # Verify installation
    if command_exists baksmali; then
        success "Baksmali v2.3.3 installed"
        which baksmali >> "$log" 2>&1
        echo "baksmali" | tee -a "$config" >> /dev/null 2>&1
        echo "Baksmali -> OK" >> "$inst"
        return 0
    else
        error "Baksmali v2.3.3 installation failed"
        echo "0" > "$stp"
        echo "Baksmali -> Not OK" >> "$inst"
        return 1
    fi
}

# Main handler for baksmali setup
setup_baksmali() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    local green="$6"
    local red="$7"
    
    if check_baksmali_version; then
        # Version is correct
        echo -e "$green" "[ ✔ ] Baksmali v.2.3.3..................[ found ]"
        which baksmali >> "$log" 2>&1
        echo "baksmali" | tee -a "$config" >> /dev/null 2>&1
        echo "Baksmali -> OK" >> "$inst"
    else
        # Version mismatch or not installed - remove old and install new
        xterm -T "☣ REMOVE OLD BAKSMALI ☣" -geometry 100x30 -e "sudo apt-get remove --purge baksmali -y"
        
        if install_baksmali "$path" "$log" "$config" "$inst" "$stp"; then
            echo -e "$green" "[ ✔ ] Baksmali v.2.3.3..................[Installed]"
        else
            echo -e "$red" "[ x ] Baksmali v.2.3.3"
        fi
    fi
}

# DX 1.16 helpers

check_dx_version() {
    local expected_version="1.16"
    local current_version
    
    if ! command_exists dx; then
        return 1
    fi
    
    current_version=$(dx --version 2>&1 | grep "version" | awk '{print $3}')
    
    if [ "$current_version" = "$expected_version" ]; then
        return 0
    else
        return 1
    fi
}

install_dx() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    
    # Remove old version if exists
    unlink "/usr/local/sbin/dx" > /dev/null 2>&1 || true
    
    # Symlink new version
    ln -s "$path/tools/android-sdk/dx" "/usr/local/sbin/dx" > /dev/null 2>&1
    
    # Verify installation
    if command_exists dx; then
        success "DX 1.16 installed"
        which dx >> "$log" 2>&1
        echo "dx" | tee -a "$config" >> /dev/null 2>&1
        echo "DX -> OK" >> "$inst"
        return 0
    else
        error "DX 1.16 installation failed"
        echo "0" > "$stp"
        echo "DX -> Not OK" >> "$inst"
        return 1
    fi
}

# Main handler for dx setup
setup_dx() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    local green="$6"
    local red="$7"
    
    if check_dx_version; then
        # Version is correct
        echo -e "$green" "[ ✔ ] DX 1.16...........................[ found ]"
        which dx >> "$log" 2>&1
        echo "dx" | tee -a "$config" >> /dev/null 2>&1
        echo "DX -> OK" >> "$inst"
    else
        # Version mismatch or not installed - remove old and install new
        xterm -T "☣ Removing Your Current DX ☣" -geometry 100x30 -e "sudo apt-get remove --purge dx -y"
        
        if install_dx "$path" "$log" "$config" "$inst" "$stp"; then
            echo -e "$green" "[ ✔ ] DX 1.16...........................[Installed]"
        else
            echo -e "$red" "[ x ] DX 1.16"
        fi
    fi
}

# AAPT v0.2-6625208 helpers

check_aapt_version() {
    local expected_version="v0.2-6625208"
    local current_version
    
    if ! command_exists aapt; then
        return 1
    fi
    
    current_version=$(aapt v | awk '{print $5}')
    
    if [ "$current_version" = "$expected_version" ]; then
        return 0
    else
        return 1
    fi
}

install_aapt() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    
    # Remove old versions if exist
    unlink "/usr/local/sbin/aapt" > /dev/null 2>&1 || true
    unlink "/usr/local/sbin/aapt2" > /dev/null 2>&1 || true
    rm /usr/local/sbin/aapt >/dev/null 2>&1 || true
    rm /usr/local/sbin/aapt2 >/dev/null 2>&1 || true
    
    # Symlink new versions
    ln -s "$path/tools/android-sdk/aapt" "/usr/local/sbin/aapt" > /dev/null 2>&1
    ln -s "$path/tools/android-sdk/aapt2" "/usr/local/sbin/aapt2" > /dev/null 2>&1
    
    # Verify installation
    if command_exists aapt; then
        success "AAPT v0.2-6625208 installed"
        which aapt >> "$log" 2>&1
        echo "aapt" | tee -a "$config" >> /dev/null 2>&1
        echo "AAPT -> OK" >> "$inst"
        return 0
    else
        error "AAPT v0.2-6625208 installation failed"
        echo "0" > "$stp"
        echo "AAPT -> Not OK" >> "$inst"
        return 1
    fi
}

# Main handler for aapt setup
setup_aapt() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    local green="$6"
    local red="$7"
    
    if check_aapt_version; then
        # Version is correct
        echo -e "$green" "[ ✔ ] Aapt v0.2-6625208.................[ found ]"
        which aapt >> "$log" 2>&1
        echo "aapt" | tee -a "$config" >> /dev/null 2>&1
        echo "Aapt -> OK" >> "$inst"
        rm /usr/local/sbin/aapt2 >/dev/null 2>&1
        ln -s "$path/tools/android-sdk/aapt2" "/usr/local/sbin/aapt2" > /dev/null 2>&1
    else
        # Version mismatch or not installed - remove old and install new
        xterm -T "☣ Removing Your Current Aapt ☣" -geometry 100x30 -e "sudo apt-get remove --purge aapt -y"
        
        if install_aapt "$path" "$log" "$config" "$inst" "$stp"; then
            echo -e "$green" "[ ✔ ] Aapt v0.2-6625208..................[Installed]"
        else
            echo -e "$red" "[ x ] Aapt v0.2-6625208"
        fi
    fi
}

# Baksmali v2.3.3 helpers

check_baksmali_version() {
    local expected_version="2.3.3"
    local current_version
    
    if ! command_exists baksmali; then
        return 1
    fi
    
    current_version=$(baksmali --version | grep "baksmali" | awk '{print $2}')
    
    if [ "$current_version" = "$expected_version" ]; then
        return 0
    else
        return 1
    fi
}

install_baksmali() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    
    # Remove old version if exists
    unlink "/usr/local/sbin/baksmali" > /dev/null 2>&1 || true
    
    # Symlink new version
    ln -s "$path/tools/baksmali233/baksmali" "/usr/local/sbin/baksmali" > /dev/null 2>&1
    
    # Verify installation
    if command_exists baksmali; then
        success "Baksmali v2.3.3 installed"
        which baksmali >> "$log" 2>&1
        echo "baksmali" | tee -a "$config" >> /dev/null 2>&1
        echo "Baksmali -> OK" >> "$inst"
        return 0
    else
        error "Baksmali v2.3.3 installation failed"
        echo "0" > "$stp"
        echo "Baksmali -> Not OK" >> "$inst"
        return 1
    fi
}

# Main handler for baksmali setup
setup_baksmali() {
    local path="$1"
    local log="$2"
    local config="$3"
    local inst="$4"
    local stp="$5"
    local green="$6"
    local red="$7"
    
    if check_baksmali_version; then
        # Version is correct
        echo -e "$green" "[ ✔ ] Baksmali v.2.3.3..................[ found ]"
        which baksmali >> "$log" 2>&1
        echo "baksmali" | tee -a "$config" >> /dev/null 2>&1
        echo "Baksmali -> OK" >> "$inst"
    else
        # Version mismatch or not installed - remove old and install new
        xterm -T "☣ REMOVE OLD BAKSMALI ☣" -geometry 100x30 -e "sudo apt-get remove --purge baksmali -y"
        
        if install_baksmali "$path" "$log" "$config" "$inst" "$stp"; then
            echo -e "$green" "[ ✔ ] Baksmali v.2.3.3..................[Installed]"
        else
            echo -e "$red" "[ x ] Baksmali v.2.3.3"
        fi
    fi
}
