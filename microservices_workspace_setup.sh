#! /usr/bin/bash
echo "Enter Organisation name or your user name if it's a forked repo: "
read username
declare -A Repos
Repos[0,0]="https://github.com/${username}/novopay-platform-lib.git"
Repos[0,1]="mfi_integration_v3.13.0"
Repos[0,2]="novopay-platform-lib"

Repos[1,0]="https://github.com/${username}/novopay-platform-initial-setup.git"
Repos[1,1]="mfi_integration_v3.13.0"
Repos[1,2]="novopay-platform-initial-setup"

Repos[2,0]="https://github.com/${username}/novopay-platform-actor.git"
Repos[2,1]="mfi_integration_v3.13.0"
Repos[2,2]="novopay-platform-actor"

Repos[3,0]="https://github.com/${username}/novopay-platform-accounting-v2.git"
Repos[3,1]="mfi_integration_v3.13.0"
Repos[3,2]="novopay-platform-accounting-v2"

Repos[4,0]="https://github.com/${username}/novopay-platform-api-gateway.git"
Repos[4,1]="mfi_integration_v3.13.0"
Repos[4,2]="novopay-platform-api-gateway"

Repos[5,0]="https://github.com/${username}/novopay-platform-masterdata-management.git"
Repos[5,1]="mfi_integration_v3.13.0"
Repos[5,2]="novopay-platform-masterdata-management"

Repos[6,0]="https://github.com/${username}/novopay-platform-authorization.git"
Repos[6,1]="mfi_integration_v3.13.0"
Repos[6,2]="novopay-platform-authorization"

Repos[7,0]="https://github.com/${username}/novopay-platform-approval.git"
Repos[7,1]="mfi_integration_v3.13.0"
Repos[7,2]="novopay-platform-approval"

Repos[8,0]="https://github.com/${username}/novopay-platform-notifications.git"
Repos[8,1]="mfi_integration_v3.13.0"
Repos[8,2]="novopay-platform-notifications"

Repos[9,0]="https://github.com/${username}/novopay-platform-dms.git"
Repos[9,1]="mfi_integration_v3.13.0"
Repos[9,2]="novopay-platform-dms"

Repos[10,0]="https://github.com/${username}/novopay-platform-batch.git"
Repos[10,1]="mfi_integration_v3.13.0"
Repos[10,2]="novopay-platform-batch"

Repos[11,0]="https://github.com/${username}/novopay-mfi-los.git"
Repos[11,1]="mfi_integration_v3.13.0"
Repos[11,2]="novopay-mfi-los"

Repos[12,0]="https://github.com/${username}/novopay-platform-audit.git"
Repos[12,1]="mfi_integration_v3.13.0"
Repos[12,2]="novopay-platform-audit"

Repos[13,0]="https://github.com/${username}/novopay-platform-task.git"
Repos[13,1]="mfi_integration_v3.12.0"
Repos[13,2]="novopay-platform-task"

Repos[14,0]="https://github.com/${username}/novopay-platform-payments.git"
Repos[14,1]="mfi_integration_v3.13.0"
Repos[14,2]="novopay-platform-payments"


read -p "Enter preferred IDE: Eclipse/Intellij: " IDE
echo "Enter the path for the github repo in linux style. Eg: Windows style directory structure C:/Users/Admin/Desktop/git_repos needs to be replaced with linux /C/Users/Admin/Desktop/git_repos"
read git_repo_path
echo "Enter path of for the ide workspace. To avoid workspace corruption please use different directories compare to github repos. The directory path needs to follow linux style. Eg: Windows style directory structure C:/Users/Admin/Desktop/eclipse_workspace needs to be replaced with linux /C/Users/Admin/Desktop/eclipse_workspace"
read workspace
j=0
while [ $j -lt 15 ]
do
	cd $git_repo_path
    git clone ${Repos[$j,0]} && cd "$(basename "$_" .git)"
    git checkout ${Repos[$j,1]}
	git remote add upstream "https://github.com/khoslalabs/${Repos[$j,2]}
	
    if [ "$IDE" == "Eclipse" ]
    then
		if [ "${Repos[$j,2]}" != "novopay-platform-initial-setup" ]
		then
			sh gradlew cleanEclipse eclipse
			sh gradlew build -x test			
		fi
    elif [ "$IDE" == "Intellij" ]
    then 
        if [ "${Repos[$j,2]}" != "novopay-platform-initial-setup" ]
		then
			sh gradlew cleanIdea idea
			sh gradlew build -x test
		fi
    else
        echo "Enter Valid IDE."
    fi
    ((j++))
done
