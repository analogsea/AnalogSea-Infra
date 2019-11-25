cd "${0%/*}"
./tools.sh ceph osd pool set rbd compression_algorithm lz4
sleep 2
./tools.sh ceph osd pool set rbd compression_mode force
