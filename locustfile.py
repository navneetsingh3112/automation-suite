from locust import HttpUser, task, between
import random
import string
import psycopg2
from contextlib import closing

x = 0
def getDbConnection():
    global x
    hostIp = ['10.212.147.46', '10.212.149.229', '10.212.148.100']
    connection = psycopg2.connect(
        host=hostIp[x % 3],
        port='6433',
        database='mfi_ppd',
        user='appuser',
        password='N0v0CtrL$25'
    )
    x += 1
    return connection


def generate_random_string(length):
    """Generate a random string of fixed length."""
    letters = string.ascii_letters + string.digits
    return ''.join(random.choice(letters) for _ in range(length))


def generate_id():
    return random.randint(1, 1000000)


def execute_query(query, is_select_query=False, params=None):
    connection = None
    try:
        print("Executing query: %s", query)
        connection = getDbConnection()
        with closing(connection.cursor()) as cursor:
            cursor.execute(query, params or ())
            if is_select_query:
                result = cursor.fetchall()
            else:
                result = None
            connection.commit()
            return result
    except Exception as e:
        print("An error occurred while executing the query: %s", e)
        raise
    finally:
        if connection:
            connection.close()

class DatabaseLoadTest(HttpUser):
    wait_time = between(1, 5)  # Simulate users waiting between 1 and 5 seconds

    def __init__(self, *args, **kwargs):
        super().__init__(args, kwargs)
        self.repayment_mandate_ids = None
        self.repayment_account_ids = None
        self.contact_detail_ids = None
        self.address_ids = None
        self.actor_ids = None
        self.loan_app_ids = None
        self.group_ids = None
        self.customer_ids = None

    def on_start(self):
        """Initialize any necessary data or connections."""
        self.customer_ids = []
        self.group_ids = []
        self.loan_app_ids = []
        self.actor_ids = []
        self.address_ids = []
        self.contact_detail_ids = []
        self.repayment_account_ids = []
        self.repayment_mandate_ids = []

    @task
    def insert_customers(self):
        """Insert data into customer-related tables."""
        for _ in range(30440):  # TOTAL_CUSTOMERS
            # Insert into actor table
            actor_id = self.insert_actor()
            self.actor_ids.append(actor_id)

            # Insert into customer table
            customer_id = self.insert_customer(actor_id)
            self.customer_ids.append(customer_id)

            # Insert into address table
            address_id = self.insert_address()
            self.address_ids.append(address_id)

            # Insert into contact_detail table
            contact_detail_id = self.insert_contact_detail()
            self.contact_detail_ids.append(contact_detail_id)

            # Insert into actor__address__mapping table
            self.insert_actor_address_mapping(actor_id, address_id)

            # Insert into actor__contact_detail__mapping table
            self.insert_actor_contact_detail_mapping(actor_id, contact_detail_id)

    @task
    def insert_groups(self):
        """Insert data into group-related tables."""
        for _ in range(3044):  # TOTAL_GROUPS
            group_id = self.insert_group_details()
            self.group_ids.append(group_id)

    @task
    def insert_applications(self):
        """Insert data into loan application-related tables."""
        for _ in range(30440):  # TOTAL_APPLICATIONS
            loan_app_id = self.insert_loan_app()
            self.loan_app_ids.append(loan_app_id)

            # Insert into borrower table
            self.insert_borrower(loan_app_id)

            # Insert into insurance_policy_details table
            self.insert_insurance_policy_details(loan_app_id)

            # Insert into insurance_tax_components table
            self.insert_insurance_tax_components(loan_app_id)

            # Insert into group__member_details table
            self.insert_group_member_details(loan_app_id)

            # Insert into account_details table (SI and eNach)
            self.insert_account_details(loan_app_id)

            # Insert into repayment_account_details table
            repayment_account_id = self.insert_repayment_account_details()
            self.repayment_account_ids.append(repayment_account_id)

            # Insert into repayment_mandate_details table
            self.insert_repayment_mandate_details(loan_app_id, repayment_account_id)

            # Insert into disburse_loan_process table
            self.insert_disburse_loan_process(loan_app_id)

    def insert_actor(self):
        """Insert a record into the actor table."""
        actor_id = generate_id()
        query = f"""
        INSERT INTO mfi_actor.actor (id, type, is_deleted)
        VALUES ({actor_id}, 'CUSTOMER', false);
        """
        self.client.post("/execute-query", json={"query": query})
        return actor_id

    def insert_customer(self, actor_id):
        """Insert a record into the customer table."""
        customer_id = generate_id()
        query = f"""
        INSERT INTO mfi_actor.customer (id, actor_id, formatted_id, external_id, customer_type, first_name, last_name, status, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({customer_id}, {actor_id}, '{generate_random_string(10)}', '{generate_random_string(10)}', 'INDIVIDUAL', 'John', 'Doe', 'ACTIVE', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})
        return customer_id

    def insert_address(self):
        """Insert a record into the address table."""
        address_id = generate_id()
        query = f"""
        INSERT INTO mfi_actor.address (id, type, address_line_1, pincode, status, status_changed_on, status_change_remarks, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({address_id}, 'HOME', '123 Main St', '123456', 'ACTIVE', NOW(), 'Initial status', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})
        return address_id

    def insert_contact_detail(self):
        """Insert a record into the contact_detail table."""
        contact_detail_id = generate_id()
        query = f"""
        INSERT INTO mfi_actor.contact_detail (id, name, mobile_number, primary_email, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({contact_detail_id}, 'John Doe', '1234567890', 'john.doe@example.com', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})
        return contact_detail_id

    def insert_actor_address_mapping(self, actor_id, address_id):
        """Insert a record into the actor__address__mapping table."""
        mapping_id = generate_id()
        query = f"""
        INSERT INTO mfi_actor.actor__address__mapping (id, actor_id, address_id, is_deleted)
        VALUES ({mapping_id}, {actor_id}, {address_id}, false);
        """
        self.client.post("/execute-query", json={"query": query})

    def insert_actor_contact_detail_mapping(self, actor_id, contact_detail_id):
        """Insert a record into the actor__contact_detail__mapping table."""
        mapping_id = generate_id()
        query = f"""
        INSERT INTO mfi_actor.actor__contact_detail__mapping (id, actor_id, contact_detail_id, is_deleted)
        VALUES ({mapping_id}, {actor_id}, {contact_detail_id}, false);
        """
        self.client.post("/execute-query", json={"query": query})

    def insert_group_details(self):
        """Insert a record into the group_details table."""
        group_id = generate_id()
        query = f"""
        INSERT INTO mfi_los.group_details (id, formatted_id, group_name, group_status, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({group_id}, '{generate_random_string(10)}', 'Group {group_id}', 'ACTIVE', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})
        return group_id

    def insert_loan_app(self):
        """Insert a record into the loan_app table."""
        loan_app_id = generate_id()
        query = f"""
        INSERT INTO mfi_los.loan_app (id, formatted_id, loan_product_id, loan_type, status, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({loan_app_id}, '{generate_random_string(10)}', 1, 'PERSONAL', 'PENDING', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})
        return loan_app_id

    def insert_borrower(self, loan_app_id):
        """Insert a record into the borrower table."""
        borrower_id = generate_id()
        query = f"""
        INSERT INTO mfi_los.borrower (id, loan_app_id, borrower_type, first_name, last_name, mobile_number, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({borrower_id}, {loan_app_id}, 'PRIMARY', 'John', 'Doe', '1234567890', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})

    def insert_insurance_policy_details(self, loan_app_id):
        """Insert a record into the insurance_policy_details table."""
        policy_id = generate_id()
        query = f"""
        INSERT INTO mfi_los.insurance_policy_details (id, loan_app_id, borrower_id, policy_number, status, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({policy_id}, {loan_app_id}, 1, '{generate_random_string(10)}', 'ACTIVE', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})

    def insert_insurance_tax_components(self, loan_app_id):
        """Insert a record into the insurance_tax_components table."""
        tax_id = generate_id()
        query = f"""
        INSERT INTO mfi_los.insurance_tax_components (id, insurance_policy_details_id, tax_amount, tax_code, tax_name, tax_rate)
        VALUES ({tax_id}, 1, '100.00', 'TAX001', 'GST', '18%');
        """
        self.client.post("/execute-query", json={"query": query})

    def insert_group_member_details(self, loan_app_id):
        """Insert a record into the group__member_details table."""
        member_id = generate_id()
        query = f"""
        INSERT INTO mfi_los.group__member_details (id, loan_app_id, group_id, is_signatory, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({member_id}, {loan_app_id}, 1, true, NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})

    def insert_account_details(self, loan_app_id):
        """Insert records into the account_details table for SI and eNach."""
        for _ in range(10):  # 10 records per loan_app_id for SI
            account_id = generate_id()
            query = f"""
            INSERT INTO mfi_los.account_details (id, loan_app_id, account_purpose, account_holder_type, created_on, created_by, updated_on, updated_by, is_deleted)
            VALUES ({account_id}, {loan_app_id}, 'SI', 'INDIVIDUAL', NOW(), 'admin', NOW(), 'admin', false);
            """
            self.client.post("/execute-query", json={"query": query})

        for _ in range(1):  # 1 record per loan_app_id for eNach
            account_id = generate_id()
            query = f"""
            INSERT INTO mfi_los.account_details (id, loan_app_id, account_purpose, account_holder_type, created_on, created_by, updated_on, updated_by, is_deleted)
            VALUES ({account_id}, {loan_app_id}, 'ENACH', 'INDIVIDUAL', NOW(), 'admin', NOW(), 'admin', false);
            """
            self.client.post("/execute-query", json={"query": query})

    def insert_repayment_account_details(self):
        """Insert a record into the repayment_account_details table."""
        account_id = generate_id()
        query = f"""
        INSERT INTO mfi_accounting.repayment_account_details (id, account_number, account_type, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({account_id}, '{generate_random_string(10)}', 'SAVINGS', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})
        return account_id

    def insert_repayment_mandate_details(self, loan_app_id, repayment_account_id):
        """Insert a record into the repayment_mandate_details table."""
        mandate_id = generate_id()
        query = f"""
        INSERT INTO mfi_accounting.repayment_mandate_details (id, loan_account_id, repayment_account_details_id, start_date, end_date, repayment_frequency, purpose_code, max_amount, mandate_type, mandate_status, mandate_category, created_on, created_by, updated_on, updated_by, is_deleted)
        VALUES ({mandate_id}, {loan_app_id}, {repayment_account_id}, NOW(), NOW() + INTERVAL '1 year', 'MONTHLY', 'LOAN_REPAYMENT', 1000.00, 'AUTO', 'ACTIVE', 'LOAN', NOW(), 'admin', NOW(), 'admin', false);
        """
        self.client.post("/execute-query", json={"query": query})

    def insert_disburse_loan_process(self, loan_app_id):
        """Insert a record into the disburse_loan_process table."""
        process_id = generate_id()
        query = f"""
        INSERT INTO mfi_los.disburse_loan_process (id, entity_id, status, created_on, started_on, completed_on, is_stp, flow, flow_status, entity_type)
        VALUES ({process_id}, {loan_app_id}, 1, NOW(), NOW(), NOW(), true, 'DEFAULT', 'DEFAULT', 'LOAN_APP');
        """
        self.client.post("/execute-query", json={"query": query})

