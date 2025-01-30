#! /usr/bin/bash
echo "Enter Organisation name or your user name if it's a forked repo: "
read username
declare -A Repos

Repos[0,0]="https://github.com/${username}/novopay-platform-lib.git"
Repos[0,1]="novopay-platform-lib"

Repos[1,0]="https://github.com/${username}/novopay-platform-initial-setup.git"
Repos[1,1]="novopay-platform-initial-setup"

Repos[2,0]="https://github.com/${username}/novopay-platform-actor.git"
Repos[2,1]="novopay-platform-actor"

Repos[3,0]="https://github.com/${username}/novopay-platform-accounting-v2.git"
Repos[3,1]="novopay-platform-accounting-v2"

Repos[4,0]="https://github.com/${username}/novopay-platform-api-gateway.git"
Repos[4,1]="novopay-platform-api-gateway"

Repos[5,0]="https://github.com/${username}/novopay-platform-masterdata-management.git"
Repos[5,1]="novopay-platform-masterdata-management"

Repos[6,0]="https://github.com/${username}/novopay-platform-authorization.git"
Repos[6,1]="novopay-platform-authorization"

Repos[7,0]="https://github.com/${username}/novopay-platform-approval.git"
Repos[7,1]="novopay-platform-approval"

Repos[8,0]="https://github.com/${username}/novopay-platform-notifications.git"
Repos[8,1]="novopay-platform-notifications"

Repos[9,0]="https://github.com/${username}/novopay-platform-dms.git"
Repos[9,1]="novopay-platform-dms"

Repos[10,0]="https://github.com/${username}/novopay-platform-batch.git"
Repos[10,1]="novopay-platform-batch"

Repos[11,0]="https://github.com/${username}/novopay-mfi-los.git"
Repos[11,1]="novopay-mfi-los"

Repos[12,0]="https://github.com/${username}/novopay-platform-audit.git"
Repos[12,1]="novopay-platform-audit"

Repos[13,0]="https://github.com/${username}/novopay-platform-task.git"
Repos[13,1]="novopay-platform-task"

Repos[14,0]="https://github.com/${username}/novopay-platform-payments.git"
Repos[14,1]="novopay-platform-payments"

Repos[15,0]="https://github.com/${username}/novopay-platform-webapp.git"
Repos[15,1]="novopay-platform-webapp"

Repos[16,0]="https://github.com/${username}/trustt-platform-reporting.git"
Repos[16,1]="trustt-platform-reporting"

Repos[17,0]="https://github.com/${username}/novopay-platform-bpmn.git"
Repos[17,1]="novopay-platform-bpmn"

Repos[18,0]="https://github.com/${username}/trustt-platform-bre.git"
Repos[18,1]="trustt-platform-bre"

Repos[18,0]="https://github.com/${username}/novopay-platform-consents.git"
Repos[18,1]="novopay-platform-consents"

Repos[19,0]="https://github.com/${username}/novopay-platform-simulators.git"
Repos[19,1]="novopay-platform-simulators"

Repos[20,0]="https://github.com/${username}/novopay-sli-andriod.git"
Repos[20,1]="novopay-sli-andriod"


echo "Enter the path for the github repo in linux style. Eg: Windows style directory structure C:/Users/Admin/Desktop/git_repos needs to be replaced with linux /C/Users/Admin/Desktop/git_repos"
read git_repo_path
j=0
while [ $j -lt 21 ]
do
    cd $git_repo_path
    git clone ${Repos[$j,0]} && cd "$(basename "$_" .git)"
    git remote add upstream "https://github.com/khoslalabs/${Repos[$j,1]}"
    ((j++))
done
