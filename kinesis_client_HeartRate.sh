while true
do
  deviceID=$(( ( RANDOM % 10 )  + 1 ))
  heartRate=$(jot -r 1 60 140)
  echo "$deviceID,$heartRate"
  aws kinesis put-record --stream-name <your_stream_name> --data "$deviceID,$heartRate"$'\n' --partition-key $deviceID --region us-east-1
done