cd $JENKINS_HOME/workspace/$JOB_NAME
echo "$1"
echo "$2"
names="$*"
echo "$names"
mkdir static_code1
IFS=' ' read -r -a array <<< "$names"
for i in "${array[@]}"
do
  	IFS='/' read -r -a array1 <<< "$i"
	path=""
	p="/"
	temp=${#array1[@]}
	temp=$temp-1
	for index in "${!array1[@]}"
	do
   		if [ $index == $temp ]
    	then 
   			cp  $path${array1[index]} ./static_code1/$path${array1[index]}
            
   		else
        	mkdir $JENKINS_HOME/workspace/$JOB_NAME/static_code1/$path${array1[index]}
        	path=$path${array1[index]}$p
   		fi
   
	done 
done
cd /Users/srikar.nallapu/.jenkins/workspace/$JOB_NAME/
cp -R /Users/srikar.nallapu/.jenkins/workspace/$JOB_NAME/static_code1 /Users/srikar.nallapu/.jenkins/workspace/output123
cd /Users/srikar.nallapu/.jenkins/workspace/
rm -rf $JOB_NAME
mkdir $JOB_NAME
cd $JOB_NAME
cp -R /Users/srikar.nallapu/.jenkins/workspace/output123 ./static_code1
export PATH=/usr/local/bin
eslint  -f json -c ./static_config.json './**'  -o $JENKINS_HOME/workspace/$JOB_NAME/result.json || echo "lint failed but continiung the process"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
npm install request
