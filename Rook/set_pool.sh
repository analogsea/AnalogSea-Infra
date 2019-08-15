cd "${0%/*}"
bash tools.sh ceph osd pool set kubernetes compression_algorithm lz4
sleep 2
bash tools.sh ceph osd pool set kubernetes compression_mode aggressive
