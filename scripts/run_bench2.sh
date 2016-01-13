
OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_`date +%R`_thread$1.txt

touch $OUTPUT_FILE
for ((i = 10000; i <= 1000000; i += 10000)) do
    for rep in `seq 1 5`; do
        echo "Size: $i" >> $OUTPUT_FILE;
        ./src/parallelQuicksort $i $1 >> $OUTPUT_FILE;
    done ;
done


