#!/bin/bash

# Configuration
HF_OWNER="neashton"
HF_PREFIX="ahmedml"
LOCAL_DIR="./ahmed_data"
NUM_RUNS=2
BASE_URL="https://huggingface.co/datasets/${HF_OWNER}/${HF_PREFIX}/resolve/main"

# Create the local directory if it doesn't exist
mkdir -p "$LOCAL_DIR"

# Function to download file with error checking
download_file() {
    local url="$1"
    local output="$2"
    local description="$3"
    
    echo "Downloading $description..."
    if wget -q --show-progress "$url" -O "$output"; then
        echo "✓ Successfully downloaded: $description"
    else
        echo "✗ Failed to download: $description"
        echo "  URL: $url"
    fi
}

# Function to download folder contents
download_folder() {
    local run_dir="$1"
    local folder_name="$2"
    local run_local_dir="$3"
    
    echo "Attempting to download $folder_name folder for $run_dir..."
    # Note: This requires knowing the specific files in each folder
    # You may need to adapt this based on the actual folder structure
    
    folder_local_dir="$run_local_dir/$folder_name"
    mkdir -p "$folder_local_dir"
    
    # Example for slices folder - you'll need to know the actual file names
    # This is a placeholder - actual implementation depends on folder contents
    echo "Note: Folder download for $folder_name requires knowing specific file names"
}

# Loop through the run folders from 1 to 500
echo "Starting download of Ahmed dataset..."
echo "Target directory: $LOCAL_DIR"
echo "Total runs to process: $NUM_RUNS"
echo

for i in $(seq 1 $NUM_RUNS); do
    RUN_DIR="run_$i"
    RUN_LOCAL_DIR="$LOCAL_DIR/$RUN_DIR"
    
    echo "Processing $RUN_DIR..."
    
    # Create the run directory if it doesn't exist
    mkdir -p "$RUN_LOCAL_DIR"
    
    # Download ahmed_i.stl file (~5MB)
    download_file \
        "$BASE_URL/$RUN_DIR/ahmed_$i.stl" \
        "$RUN_LOCAL_DIR/ahmed_$i.stl" \
        "Geometry STL (ahmed_$i.stl)"
    
    # Download geo_parameters_1.csv (missing for run 500)
    if [ "$i" -ne $NUM_RUNS ]; then
        download_file \
            "$BASE_URL/$RUN_DIR/geo_parameters_$i.csv" \
            "$RUN_LOCAL_DIR/geo_parameters_$i.csv" \
            "Geometry parameters (geo_parameters_$i.csv)"
    else
        echo "⚠ Skipping geo_parameters_$NUM_RUNS.csv (known to be missing)"
    fi
    
    # Download boundary_i.vtp file (~500MB)
    download_file \
        "$BASE_URL/$RUN_DIR/boundary_$i.vtp" \
        "$RUN_LOCAL_DIR/boundary_$i.vtp" \
        "Boundary VTP (boundary_$i.vtp)"
    
    # Download volume_i.vtu file (~5GB)
    download_file \
        "$BASE_URL/$RUN_DIR/volume_$i.vtu" \
        "$RUN_LOCAL_DIR/volume_$i.vtu" \
        "Volume field VTU (volume_$i.vtu)"
    
    # Download force_mom_i.csv file (constant reference area)
    download_file \
        "$BASE_URL/$RUN_DIR/force_mom_$i.csv" \
        "$RUN_LOCAL_DIR/force_mom_$i.csv" \
        "Forces constant ref (force_mom_$i.csv)"
    
    # Download force_mom_varref_i.csv file (varying reference area)
    download_file \
        "$BASE_URL/$RUN_DIR/force_mom_varref_$i.csv" \
        "$RUN_LOCAL_DIR/force_mom_varref_$i.csv" \
        "Forces varying ref (force_mom_varref_$i.csv)"
    
    # Download slices folder
    # Note: This section needs to be customized based on actual folder contents
    SLICES_DIR="$RUN_LOCAL_DIR/slices"
    mkdir -p "$SLICES_DIR"
    echo "Note: Slices folder download requires knowing specific .vtp file names"
    echo "      You may need to manually specify slice files or use recursive download"
    
    # Download images folder  
    # Note: This section needs to be customized based on actual folder contents
    IMAGES_DIR="$RUN_LOCAL_DIR/images"
    mkdir -p "$IMAGES_DIR"
    echo "Note: Images folder download requires knowing specific image file names"
    echo "      You may need to manually specify image files or use recursive download"
    
    echo "Completed processing $RUN_DIR"
    echo "----------------------------------------"
done

echo
echo "Download script completed!"
echo "Total data downloaded to: $LOCAL_DIR"
echo
echo "File size estimates per run:"
echo "  - ahmed_i.stl: ~5MB"
echo "  - boundary_i.vtp: ~500MB" 
echo "  - volume_i.vtu: ~5GB"
echo "  - Other files: <1MB each"
echo "  - Total per run: ~5.5GB+ (excluding slices/images folders)"
echo "  - Total for $NUM_RUNS runs: ~$((NUM_RUNS * 55 / 10))GB+"
