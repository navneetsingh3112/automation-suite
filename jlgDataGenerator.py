import math
import psycopg2
from locust import HttpUser, task, between

class JLGSimulation(HttpUser):
    wait_time = between(1, 2)  # Simulate user wait time

    # Constants
    TOTAL_CUSTOMERS = 30440
    TOTAL_GROUPS = 3044
    TOTAL_APPLICATIONS = 30440
    TOTAL_SI = 28916
    TOTAL_ENACH = 1524

    # Shard the data generation across users
    def get_range(self, total_count, num_users, user_id):
        """
        Calculate the range of data this user is responsible for.
        :param total_count: Total items to divide among users.
        :param num_users: Total concurrent users.
        :param user_id: Unique ID of the current user.
        :return: (start_index, end_index) for this user.
        """
        items_per_user = math.ceil(total_count / num_users)
        start_index = user_id * items_per_user
        end_index = min(start_index + items_per_user, total_count)
        return start_index, end_index

    def on_start(self):
        """
        Initialize data ranges for this user based on sharding.
        """
        num_users = self.environment.runner.target_user_count
        user_id = self.environment.runner.user_count - 1  # User index starts from 0

        # Get data ranges for this user
        self.customer_range = self.get_range(self.TOTAL_CUSTOMERS, num_users, user_id)
        self.group_range = self.get_range(self.TOTAL_GROUPS, num_users, user_id)
        self.application_range = self.get_range(self.TOTAL_APPLICATIONS, num_users, user_id)

        # Initialize counters
        self.customers = [f"Customer_{i+1}" for i in range(*self.customer_range)]
        self.groups = []
        self.applications = []
        self.si_count = 0
        self.enach_count = 0

    @task
    def generate_groups(self):
        """
        Generate and post JLG groups.
        """
        if not self.groups:  # Only generate once per user
            for i in range(*self.group_range):
                group = {
                    "group_id": f"Group_{i+1}",
                    "customers": self.customers[i * 10 : (i + 1) * 10],
                }
                self.groups.append(group)
                self.client.post("/api/jlg/groups", json=group)

    @task
    def generate_applications(self):
        """
        Generate and post JLG applications.
        """
        if not self.applications:  # Only generate once per user
            for i, customer in enumerate(self.customers):
                application_type = "SI" if self.si_count < self.TOTAL_SI else "eNach"
                application = {
                    "application_id": f"Application_{i+1}",
                    "customer": customer,
                    "type": application_type,
                }
                self.applications.append(application)
                self.client.post("/api/jlg/applications", json=application)

                # Increment SI or eNach count
                if application_type == "SI":
                    self.si_count += 1
                else:
                    self.enach_count += 1

    @task
    def generate_si_or_enach(self):
        """
        Generate and post SI or eNach records.
        """
        for application in self.applications:
            if application["type"] == "SI":
                self.client.post("/api/jlg/si", json={"application_id": application["application_id"]})
            elif application["type"] == "eNach":
                self.client.post("/api/jlg/enach", json={"application_id": application["application_id"]})
