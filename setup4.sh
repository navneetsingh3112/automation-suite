#! /usr/bin/bash
echo "Enter User: " USER
read user_account
declare -A Repos
Repos=( 
        ["https://github.com/${user_account}/novopay-platform-initial-setup.git"]="develop" 
        ["https://github.com/${user_account}/novopay-platform-lib.git"]="develop_hdfc"
        ["https://github.com/${user_account}/novopay-platform-accounting-v2.git"]="develop" 
        ["https://github.com/${user_account}/novopay-platform-actor.git"]="develop"
        ["https://github.com/${user_account}/novopay-platform-api-gateway.git"]="develop" 
        ["https://github.com/${user_account}/novopay-platform-masterdata-management.git"]="develop"
        ["https://github.com/${user_account}/novopay-platform-authorizatuser_accountn.git"]="develop" 
        ["https://github.com/${user_account}/novopay-platform-approval.git"]="develop"
        ["https://github.com/${user_account}/novopay-platform-notifications.git"]="develop"
    )
mkdir git_repos
cd git_repos
j=0
read -p "Enter preferred IDE: Eclipse/Intellij: " IDE
for repo in "${!Repos[@]}"; 
    do 
        git clone $repo && cd "$(basename "$_" .git)"
        git checkout ${Repos[$repo]}
        if [ "$IDE" == "Eclipse" ]
        then
            sh gradlew cleanEclipse eclipse
            #gradle buildship for intellij or eclipse
            eclipse -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild 
            -import {[uri:/]{$(pwd)}} 
            -build {project_name | all} 
            -cleanBuild {projec_name | all}
            
        elif [ "$IDE" == "Intellij" ]
        then 
            sh gradlew cleanIdea idea
        else
            echo "Enter Valid IDE."
        fi
        ((j++))
        cd ..
        echo "$repo - ${Repos[$repo]}"; 
done

if [ "$IDE" == "Eclipse" ]
then
    echo "eclipse"  
    # b=$(pwd)
    # C:/Users/Shagufta/Desktop/sts/sts-4.17.1.RELEASE/SpringToolSuite4.exe #remove
elif [ "$IDE" == "Intellij" ]
then 
    # C:/"Program Files"/JetBrains/"IntelliJ IDEA Community Edition 2022.3.2"/bin/idea64.exe
    b=$(pwd)
    idea64.exe $b
else
    echo "Enter Valid IDE."
fi