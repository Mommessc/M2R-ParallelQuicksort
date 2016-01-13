
OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
OUTPUT_FILE=$OUTPUT_DIRECTORY/measurements_`date +%R`_Multiple$1.txt

touch $OUTPUT_FILE
for i in 100 1000 10000 100000 1000000; do
	echo "Size $i";
    for rep in `seq 1 10`; do
        echo "Size: $i" >> $OUTPUT_FILE;
        ./src/parallelMultiLevel $i $1 >> $OUTPUT_FILE;
    done ;
done
