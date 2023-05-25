#! /usr/bin/bash
echo "Enter Organisation name or your user name if its forked repo: " USER
read username
declare -A Repos
Repos[0,0]="https://github.com/${username}/novopay-platform-lib.git"
Repos[0,1]="nav/mfi/qa"
Repos[0,2]="novopay-platform-lib"

Repos[1,0]="https://github.com/${username}/novopay-platform-initial-setup.git"
Repos[1,1]="mfi_develop"
Repos[1,2]="novopay-platform-initial-setup"

Repos[2,0]="https://github.com/${username}/novopay-platform-actor.git"
Repos[2,1]="mfi_develop"
Repos[2,2]="novopay-platform-actor"

Repos[3,0]="https://github.com/${username}/novopay-platform-accounting-v2.git"
Repos[3,1]="develop"
Repos[3,2]="novopay-platform-accounting-v2"

Repos[4,0]="https://github.com/${username}/novopay-platform-api-gateway.git"
Repos[4,1]="mfi_develop"
Repos[4,2]="novopay-platform-api-gateway"

Repos[5,0]="https://github.com/${username}/novopay-platform-masterdata-management.git"
Repos[5,1]="mfi_develop"
Repos[5,2]="novopay-platform-masterdata-management"

Repos[6,0]="https://github.com/${username}/novopay-platform-authorization.git"
Repos[6,1]="mfi_develop"
Repos[6,2]="novopay-platform-authorization"

Repos[7,0]="https://github.com/${username}/novopay-platform-approval.git"
Repos[7,1]="mfi_develop"
Repos[7,2]="novopay-platform-approval"

Repos[8,0]="https://github.com/${username}/novopay-platform-notifications.git"
Repos[8,1]="mfi_develop"
Repos[8,2]="novopay-platform-notifications"

Repos[9,0]="https://github.com/${username}/novopay-platform-dms.git"
Repos[9,1]="mfi_develop"
Repos[9,2]="novopay-platform-dms"

Repos[10,0]="https://github.com/${username}/novopay-platform-batch.git"
Repos[10,1]="mfi_develop"
Repos[10,2]="novopay-platform-batch"

Repos[11,0]="https://github.com/${username}/novopay-platform-batch-framework.git"
Repos[11,1]="mfi_develop"
Repos[11,2]="novopay-platform-batch-framework"

Repos[12,0]="https://github.com/${username}/novopay-platform-audit.git"
Repos[12,1]="mfi_develop"
Repos[12,2]="novopay-platform-audit"

rm -rf git_repos/
mkdir -p git_repos 
cd git_repos

read -p "Enter preferred IDE: Eclipse/Intellij: " IDE
echo "Enter path where your repo is getting created-(if the path is C:/Users/Shagufta/Desktop/backend/scripts/git_repos, make it /C/Users/Shagufta/Desktop/backend/scripts/git_repos):"
read path
echo "Enter path of your workspace-(if the path is C:/Users/Shagufta/Desktop/workspace, make it /C/Users/Shagufta/Desktop/workspace):"
read workspace
j=0
while [ $j -lt 13 ]
do
    git clone ${Repos[$j,0]} && cd "$(basename "$_" .git)"
    git checkout ${Repos[$j,1]}
	
    if [ "$IDE" == "Eclipse" ]
    then
		sh gradlew cleanEclipse eclipse
        cd $path
		if [ "${Repos[$j,2]}" != "novopay-platform-initial-setup" ]
		then
            eclipsec -nosplash -data $workspace -application org.eclipse.cdt.managedbuilder.core.headlessbuild -import ./${Repos[$j,2]}
		fi
    elif [ "$IDE" == "Intellij" ]
    then 
        sh gradlew cleanIdea idea
        cd $path
        if [ "${Repos[$j,2]}" != "novopay-platform-initial-setup" ]
		then
            eclipsec -nosplash -data $workspace -application org.eclipse.cdt.managedbuilder.core.headlessbuild -import ./${Repos[$j,2]}
		fi
    else
        echo "Enter Valid IDE."
    fi
    ((j++))
    cd $path
done
