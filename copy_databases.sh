# Read source server copy_databases_credentials from the file
source_host=$(sed -n '1p' copy_databases_credentials.txt)
source_username=$(sed -n '2p' copy_databases_credentials.txt)
source_password=$(sed -n '3p' copy_databases_credentials.txt)
source_tenant=$(sed -n '4p' copy_databases_credentials.txt)

# Read destination server copy_databases_credentials from the file
destination_host=$(sed -n '5p' copy_databases_credentials.txt)
destination_username=$(sed -n '6p' copy_databases_credentials.txt)
destination_password=$(sed -n '7p' copy_databases_credentials.txt)
destination_tenant=$(sed -n '8p' copy_databases_credentials.txt)

# Read the microservice names from the text file
while IFS= read -r microservice_name || [[ -n "$microservice_name" ]]; do
  microservice_name=$(echo "$microservice_name" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

  if [[ -n $microservice_name ]]; then
    source_database="${source_tenant}_${microservice_name}"
    destination_database="${destination_tenant}_${microservice_name}"

    # Echo the current line
    echo "Current Source Database: $source_database"
    echo "Current Destination Database: $destination_database"

    # Check if the destination database already exists
    RESULT=$(mysql -h "$destination_host" -u "$destination_username" --password="$destination_password" -e "SHOW DATABASES LIKE '$destination_database'")
    if [[ "$RESULT" != "" ]]; then
      read -r -p "Destination database '$destination_database' already exists. Do you want to overwrite it? (y/n): " overwrite_response < /dev/tty
      
      while [[ ! "$overwrite_response" =~ ^[YyNn]$ ]]; do
        read -r -p "Innvalid input. Please enter 'y' to overwrite or 'n' to skip: " overwrite_response </dev/tty
        echo
      done

      if [[ "$overwrite_response" =~ ^[Yy]$ ]]; then
        # Drop the existing destination database
        mysql -h "$destination_host" -u "$destination_username" --password="$destination_password" -e "DROP DATABASE $destination_database;"
      else
        # Skip the current iteration
        continue
      fi

    fi
    # Export the database from the source server
    export_file="${destination_database}.sql"
    mysqldump -h "$source_host" -u "$source_username" --password="$source_password" --single-transaction --no-tablespaces "$source_database" > "$export_file"

    # Create the destination database
    mysql -h "$destination_host" -u "$destination_username" --password="$destination_password" -e "CREATE DATABASE IF NOT EXISTS $destination_database;"

    # Import the database into the destination server
    mysql -h "$destination_host" -u "$destination_username" --password="$destination_password" "$destination_database" < "$export_file"

  fi

  # Add a delay between iterations
  sleep 2
done < <(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' copy_databases_microservice_list.txt)

# Cleanup - remove the export files
while IFS= read -r microservice_name || [[ -n "$microservice_name" ]]; do
  microservice_name=$(echo "$microservice_name" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

  if [[ -n $microservice_name ]]; then
    destination_database="${destination_tenant}_${microservice_name}"
    export_file="${destination_database}.sql"

    # Remove the export file
    rm "$export_file"

  fi
done < <(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' copy_databases_microservice_list.txt)

# Cleanup - remove the source and destination variables
unset source_host source_username source_password source_tenant
unset destination_host destination_username destination_password destination_tenant

# End of script