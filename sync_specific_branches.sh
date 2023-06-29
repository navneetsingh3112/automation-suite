#!/bin/bash

echo "Enter the path for the github repo in linux style. Eg: Windows style directory structure C:/Users/Admin/Desktop/git_repos needs to be replaced with linux /C/Users/Admin/Desktop/git_repos"
read git_repo_path
cd $git_repo_path

declare -A Repos
Repos[0,0]="https://github.com/khoslalabs/novopay-platform-lib.git"
Repos[0,1]="novopay-platform-lib"

Repos[1,0]="https://github.com/khoslalabs/novopay-platform-initial-setup.git"
Repos[1,1]="novopay-platform-initial-setup"

Repos[2,0]="https://github.com/khoslalabs/novopay-platform-actor.git"
Repos[2,1]="novopay-platform-actor"

Repos[3,0]="https://github.com/khoslalabs/novopay-platform-accounting-v2.git"
Repos[3,1]="novopay-platform-accounting-v2"

Repos[4,0]="https://github.com/khoslalabs/novopay-platform-api-gateway.git"
Repos[4,1]="novopay-platform-api-gateway"

Repos[5,0]="https://github.com/khoslalabs/novopay-platform-masterdata-management.git"
Repos[5,1]="novopay-platform-masterdata-management"

Repos[6,0]="https://github.com/khoslalabs/novopay-platform-authorization.git"
Repos[6,1]="novopay-platform-authorization"

Repos[7,0]="https://github.com/khoslalabs/novopay-platform-approval.git"
Repos[7,1]="novopay-platform-approval"

Repos[8,0]="https://github.com/khoslalabs/novopay-platform-notifications.git"
Repos[8,1]="novopay-platform-notifications"

Repos[9,0]="https://github.com/khoslalabs/novopay-platform-dms.git"
Repos[9,1]="novopay-platform-dms"

Repos[10,0]="https://github.com/khoslalabs/novopay-platform-batch.git"
Repos[10,1]="novopay-platform-batch"

Repos[11,0]="https://github.com/khoslalabs/novopay-mfi-los.git"
Repos[11,1]="novopay-mfi-los"

Repos[12,0]="https://github.com/khoslalabs/novopay-platform-audit.git"
Repos[12,1]="novopay-platform-audit"

Repos[13,0]="https://github.com/khoslalabs/novopay-platform-task.git"
Repos[13,1]="novopay-platform-task"

Repos[14,0]="https://github.com/khoslalabs/novopay-platform-payments.git"
Repos[14,1]="novopay-platform-payments"

j=0
while [ $j -lt 15 ]
do
	cd "${git_repo_path}/${Repos[$j,1]}"
	git fetch upstream
	for branch in $(git branch -r | grep -e mfi_integration -e mfi_release ); do
	  branch_name=${branch#origin/}
	  branch_name=${branch_name#upstream/}
	  echo $branch_name
	  if git rev-parse --quiet --verify "$branch_name" > /dev/null; then
		echo "if for loop "
		# Checkout branch and sync with upstream
		git checkout "$branch_name"
		git rebase "upstream/$branch_name"
		git push origin "$branch_name"  
	  else
		echo "else for loop "
		# Create new branch and set it up to track upstream
		git checkout --track "upstream/$branch_name"
		git push --set-upstream origin "$branch_name"
	  fi
	done	
    ((j++))
done
