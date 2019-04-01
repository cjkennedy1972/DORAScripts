#!/bin/bash
#to run this script `bash jenkins-job-analysis.sh <JENKINS-JOB-NAME> <GET_RESULT_OF_LAST_X_JOBS>`
#e.g: `bash jenkins-job-analysis.sh WordPress-CI-Job 50`

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

. "$SCRIPTPATH"/../environment.sh

JENKINS_JOB_NAME="WordPress-CI-Job"
FETCH_LAST_X_JOBS=0

if [ "$1" != '' ]
then
    JENKINS_JOB_NAME=$1;
fi
if [ "$2" != '' ]
then
    FETCH_LAST_X_JOBS=$2;
fi

BASE_URL='http://admin:'${JENKINS_TOKEN}'@'${JENKINS_IP}':'${JENKINS_PORT}'/blue/rest/organizations/jenkins/pipelines/'${JENKINS_JOB_NAME}'/runs/'
FILE_NAME=$JENKINS_JOB_NAME'@'$JENKINS_IP':'$JENKINS_PORT'.csv'


function get_formatted_time(){
    TOTAL_TIME=$1
    MINS=$(($TOTAL_TIME/60000))
    SECONDS=$((($TOTAL_TIME/1000)-($MINS*60)))
    MILI_SECONDS=$((($TOTAL_TIME)-($SECONDS*1000)-($MINS*60000)))
    SUMMERY=""
    if (( $MINS > 0 ))
    then
        SUMMERY=$MINS"Min "
    fi
    if (( $SECONDS > 0 ))
    then
        SUMMERY=$SUMMERY$SECONDS"Sec "
    fi
    if (( $MILI_SECONDS > 0 ))
    then
        SUMMERY=$SUMMERY$MILI_SECONDS"Milis "
    fi
    echo $SUMMERY
}


#get the last run Job ID
LAST_JOB_RUN_ID=$(curl -sS $BASE_URL'?limit=1'| jq '.[0].id'|bc)

# echo "Script started at $(date)"

echo "JOB COUNT = $LAST_JOB_RUN_ID"
CREATE_HEADER_ROW=true;
for ((i=$LAST_JOB_RUN_ID;i>$LAST_JOB_RUN_ID-$FETCH_LAST_X_JOBS;i--)); 
do 
    # echo "JOB ID = $i"
    STATUS_RESPONSE=$(curl -sS $BASE_URL$i'/')
    STATUS=$(echo $STATUS_RESPONSE| jq '.result'|bc)
    EXECUTION_TIME=$(echo $STATUS_RESPONSE| jq '.durationInMillis'|bc)
    EXECUTION_TIME=$(get_formatted_time ${EXECUTION_TIME}) 
    # echo "STATUS = $STATUS"
    STAGES_RESPONSE=$(curl -sS $BASE_URL$i'/nodes/')
    # echo "STAGES = $STAGES_RESPONSE"
    
    if $CREATE_HEADER_ROW
    then
        NO_OF_STAGES=$(echo $STAGES_RESPONSE| jq 'length')
        # echo "No Of Stage = $NO_OF_STAGES"
        HEADER_STRING="#Job ID,Status,Time Taken"
        for ((j=0;j<$NO_OF_STAGES;j++)); 
        do
            STAGE_NAME=$(echo $STAGES_RESPONSE| jq ".[$j].displayName"|bc)
            HEADER_STRING="$HEADER_STRING,$STAGE_NAME"
        done
        echo $HEADER_STRING> $FILE_NAME
        CREATE_HEADER_ROW=false;
    fi
    DATA_ROW="$i,$STATUS,$EXECUTION_TIME"
    for ((j=0;j<$NO_OF_STAGES;j++)); 
    do
        STAGE_STATUS=$(echo $STAGES_RESPONSE| jq ".[$j].result"|bc)
        STAGE_TIME=$(echo $STAGES_RESPONSE| jq ".[$j].durationInMillis"|bc)
        STAGE_TIME=$(get_formatted_time ${STAGE_TIME}) 
        if [ "$STAGE_TIME" != '' ]
        then
            DATA_ROW="$DATA_ROW,$STAGE_STATUS ($STAGE_TIME)"
        else
            DATA_ROW="$DATA_ROW,"
        fi
        
    done
    echo $DATA_ROW >> $FILE_NAME  
done
# echo "Completed at $(date)"

