#!/bin/sh
#please make this make file executable using : chmod u+x .....
	
echo "Call to 'Agri Simulation' App : waiting for 10 sec change the screen to Sample soil or Agriculture land image"

screencapture -T 10 -x image.jpg
# resize the image to low KB
sips -Z 512 image.jpg 
echo "Image Captured"

imagedata="data:image/jpeg;base64,$(cat image.jpg | base64 | tr -d \\n)"
date="$(date)"
echo $date

arr1[0]="Location A"
arr1[1]="Location B"
arr1[2]="Location C"
arr1[3]="Location D"
arr1[4]="Location E"

rand1=$[ $RANDOM % 5 ]
whoami=${arr1[$rand1]}
#whoami="$(whoami)"

arr[0]="Good Soil, Good Weather <br> good crop production"
arr[1]="Good Soil, Moderate Weather <br> Avg. crop production"
arr[2]="Moderate Soil, Moderate Weather <br> Avg. crop production"
arr[3]="Bad Soil, Good Weather <br> Low. crop production"
arr[4]="Bad Soil, Bad Weather <br> Low. crop production"

rand=$[ $RANDOM % 5 ]


tag=${arr[$rand]}
echo $tag

#Call to MasterDataNode API framework
appname="######appName######"
dataset="agri"
token="######access_token######"
HOST="http://api.masterdatanode.com/$appname/$dataset/save/"
curl -H "access_token:$token" -H "Content-Type: application/json" -d @- "$HOST" <<CURL_DATA
{ "data" : [{ "date" : "$date", "whoami" : "$whoami" , "tag" : "Agri Status : $tag", "imageData" : "$imagedata"}]}
CURL_DATA

