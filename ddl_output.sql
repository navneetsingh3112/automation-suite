
--
-- Name: repayment_account_details; Type: TABLE; Schema: mfi_accounting; Owner: appuser
--

CREATE TABLE mfi_accounting.repayment_account_details (
    id bigint NOT NULL,
    account_number character varying(50) NOT NULL,
    account_type character varying(50) NOT NULL,
    ifsc_code character varying(50),
    bank_name character varying(50),
    hold_status smallint DEFAULT 0 NOT NULL,
    hold_amount numeric(20,6),
    lien_status smallint,
    created_on timestamp without time zone NOT NULL,
    created_by character varying(64) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    updated_by character varying(64) NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    casa_balance numeric(20,6),
    account_holder_name character varying(256) DEFAULT NULL::character varying,
    CONSTRAINT repayment_account_details_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_accounting.repayment_account_details OWNER TO appuser;

--
-- Name: repayment_account_details_id_seq; Type: SEQUENCE; Schema: mfi_accounting; Owner: appuser
--

CREATE SEQUENCE mfi_accounting.repayment_account_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_accounting.repayment_account_details_id_seq OWNER TO appuser;

--
-- Name: repayment_account_details_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_accounting; Owner: appuser
--

ALTER SEQUENCE mfi_accounting.repayment_account_details_id_seq OWNED BY mfi_accounting.repayment_account_details.id;


--
-- Name: repayment_mandate_details; Type: TABLE; Schema: mfi_accounting; Owner: appuser
--

CREATE TABLE mfi_accounting.repayment_mandate_details (
    id bigint NOT NULL,
    loan_account_id bigint,
    loan_application_id character varying(50),
    repayment_account_details_id bigint,
    customer_id bigint,
    customer_name character varying(64),
    group_id bigint,
    group_name character varying(50),
    start_date date NOT NULL,
    end_date date,
    repayment_frequency character varying(50) NOT NULL,
    purpose_code character varying(50) NOT NULL,
    debit_type character varying(20),
    max_amount numeric(20,6) NOT NULL,
    mandate_type character varying(50) NOT NULL,
    mandate_status character varying(50) NOT NULL,
    mandate_category character varying(50) NOT NULL,
    umrn character varying(64),
    created_on timestamp without time zone NOT NULL,
    created_by character varying(64) NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    task_id bigint,
    task_status character varying(50),
    reason character varying(64) DEFAULT NULL::character varying,
    notes character varying(250) DEFAULT NULL::character varying,
    filler_field1 character varying(256) DEFAULT NULL::character varying,
    filler_field2 character varying(256) DEFAULT NULL::character varying,
    filler_field3 character varying(256) DEFAULT NULL::character varying,
    filler_field4 numeric(20,6) DEFAULT NULL::numeric,
    filler_field5 numeric(20,6) DEFAULT NULL::numeric,
    rejected_or_cancelled_date timestamp without time zone,
    is_parent_account boolean DEFAULT false NOT NULL,
    loan_category character varying(50) DEFAULT NULL::character varying,
    CONSTRAINT repayment_mandate_details_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_accounting.repayment_mandate_details OWNER TO appuser;

--
-- Name: repayment_mandate_details_id_seq; Type: SEQUENCE; Schema: mfi_accounting; Owner: appuser
--

CREATE SEQUENCE mfi_accounting.repayment_mandate_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_accounting.repayment_mandate_details_id_seq OWNER TO appuser;

--
-- Name: repayment_mandate_details_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_accounting; Owner: appuser
--

ALTER SEQUENCE mfi_accounting.repayment_mandate_details_id_seq OWNED BY mfi_accounting.repayment_mandate_details.id;


--
-- Name: actor; Type: TABLE; Schema: mfi_actor; Owner: appuser
--

CREATE TABLE mfi_actor.actor (
    id bigint NOT NULL,
    type character varying(32) NOT NULL,
    is_deleted boolean NOT NULL,
    CONSTRAINT actor_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_actor.actor OWNER TO appuser;

--
-- Name: actor__address__mapping; Type: TABLE; Schema: mfi_actor; Owner: appuser
--

CREATE TABLE mfi_actor.actor__address__mapping (
    id bigint NOT NULL,
    actor_id bigint NOT NULL,
    address_id bigint NOT NULL,
    is_deleted boolean NOT NULL,
    CONSTRAINT actor__address__mapping_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_actor.actor__address__mapping OWNER TO appuser;

--
-- Name: actor__address__mapping_id_seq; Type: SEQUENCE; Schema: mfi_actor; Owner: appuser
--

CREATE SEQUENCE mfi_actor.actor__address__mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_actor.actor__address__mapping_id_seq OWNER TO appuser;

--
-- Name: actor__address__mapping_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_actor; Owner: appuser
--

ALTER SEQUENCE mfi_actor.actor__address__mapping_id_seq OWNED BY mfi_actor.actor__address__mapping.id;


--
-- Name: actor__contact_detail__mapping; Type: TABLE; Schema: mfi_actor; Owner: appuser
--

CREATE TABLE mfi_actor.actor__contact_detail__mapping (
    id bigint NOT NULL,
    actor_id bigint NOT NULL,
    contact_detail_id bigint NOT NULL,
    is_deleted boolean NOT NULL,
    CONSTRAINT actor__contact_detail__mapping_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_actor.actor__contact_detail__mapping OWNER TO appuser;

--
-- Name: actor__contact_detail__mapping_id_seq; Type: SEQUENCE; Schema: mfi_actor; Owner: appuser
--

CREATE SEQUENCE mfi_actor.actor__contact_detail__mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_actor.actor__contact_detail__mapping_id_seq OWNER TO appuser;

--
-- Name: actor__contact_detail__mapping_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_actor; Owner: appuser
--

ALTER SEQUENCE mfi_actor.actor__contact_detail__mapping_id_seq OWNED BY mfi_actor.actor__contact_detail__mapping.id;


--
-- Name: actor_id_seq; Type: SEQUENCE; Schema: mfi_actor; Owner: appuser
--

CREATE SEQUENCE mfi_actor.actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_actor.actor_id_seq OWNER TO appuser;

--
-- Name: actor_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_actor; Owner: appuser
--

ALTER SEQUENCE mfi_actor.actor_id_seq OWNED BY mfi_actor.actor.id;


--
-- Name: address; Type: TABLE; Schema: mfi_actor; Owner: appuser
--

CREATE TABLE mfi_actor.address (
    id bigint NOT NULL,
    type character varying(32) NOT NULL,
    address_line_1 character varying(128),
    address_line_2 character varying(128),
    pincode character varying(10) NOT NULL,
    geo_element_id bigint,
    locality character varying(128),
    landmark character varying(128),
    address_geocoded_lat_long character varying(64),
    status character varying(32) NOT NULL,
    status_changed_on timestamp without time zone NOT NULL,
    status_change_remarks character varying(128) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    created_by character varying(64) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    updated_by character varying(45) NOT NULL,
    is_deleted boolean NOT NULL,
    CONSTRAINT address_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_actor.address OWNER TO appuser;

--
-- Name: address_id_seq; Type: SEQUENCE; Schema: mfi_actor; Owner: appuser
--

CREATE SEQUENCE mfi_actor.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_actor.address_id_seq OWNER TO appuser;

--
-- Name: address_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_actor; Owner: appuser
--

ALTER SEQUENCE mfi_actor.address_id_seq OWNED BY mfi_actor.address.id;


--
-- Name: contact_detail; Type: TABLE; Schema: mfi_actor; Owner: appuser
--

CREATE TABLE mfi_actor.contact_detail (
    id bigint NOT NULL,
    name character varying(128),
    mobile_number character varying(16),
    mobile_country_code character varying(8),
    alternate_contact_number character varying(16),
    alternate_contact_country_code character varying(5),
    primary_email character varying(254),
    alternate_email character varying(254),
    landline character varying(16),
    landline_country_code character varying(5),
    fax character varying(16),
    fax_country_code character varying(5),
    created_on timestamp without time zone NOT NULL,
    created_by character varying(64) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    updated_by character varying(64) NOT NULL,
    is_deleted boolean NOT NULL,
    CONSTRAINT contact_detail_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_actor.contact_detail OWNER TO appuser;

--
-- Name: contact_detail_id_seq; Type: SEQUENCE; Schema: mfi_actor; Owner: appuser
--

CREATE SEQUENCE mfi_actor.contact_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_actor.contact_detail_id_seq OWNER TO appuser;

--
-- Name: contact_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_actor; Owner: appuser
--

ALTER SEQUENCE mfi_actor.contact_detail_id_seq OWNED BY mfi_actor.contact_detail.id;


--
-- Name: customer; Type: TABLE; Schema: mfi_actor; Owner: appuser
--

CREATE TABLE mfi_actor.customer (
    id bigint NOT NULL,
    actor_id bigint NOT NULL,
    corporate_id bigint,
    base_office_id bigint,
    formatted_id character varying(128),
    external_id character varying(256),
    customer_type character varying(32),
    salutation character varying(32),
    first_name character varying(128) NOT NULL,
    middle_name character varying(128),
    last_name character varying(128),
    mother_name character varying(128),
    father_name character varying(128),
    physically_challenged character varying(8),
    marital_status character varying(16),
    residential_status character varying(16),
    education character varying(16),
    photo character varying(64),
    gender character varying(32),
    preferred_language character varying(32),
    date_of_birth timestamp without time zone,
    nationality character varying(32),
    occupation character varying(32),
    annual_income character varying(32),
    source_of_funds character varying(32),
    kyc_stage character varying(32) NOT NULL,
    status character varying(32) NOT NULL,
    status_changed_on timestamp without time zone NOT NULL,
    status_change_remarks character varying(128),
    created_on timestamp without time zone NOT NULL,
    created_by character varying(64) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    updated_by character varying(64) NOT NULL,
    is_deleted boolean NOT NULL,
    CONSTRAINT customer_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_actor.customer OWNER TO appuser;

--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: mfi_actor; Owner: appuser
--

CREATE SEQUENCE mfi_actor.customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_actor.customer_id_seq OWNER TO appuser;

--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_actor; Owner: appuser
--

ALTER SEQUENCE mfi_actor.customer_id_seq OWNED BY mfi_actor.customer.id;


--
-- Name: account_details; Type: TABLE; Schema: mfi_los; Owner: appuser
--

CREATE TABLE mfi_los.account_details (
    id bigint NOT NULL,
    loan_app_id bigint,
    group_id bigint,
    account_purpose character varying(20),
    account_holder_type character varying(20),
    bank_id bigint,
    borrower_has_bank_account boolean,
    beneficiary_account_number character varying(32),
    beneficiary_bank character varying(32),
    beneficiary_name_in_account character varying(256),
    beneficiary_bank_ifsc_code character varying(32),
    beneficiary_account_status character varying(32),
    match_percentage character varying(12),
    extensible_data text,
    created_on timestamp without time zone NOT NULL,
    created_by character varying(64),
    updated_on timestamp without time zone NOT NULL,
    updated_by character varying(64),
    is_deleted boolean DEFAULT false,
    bank_customer_id bigint,
    utr_number character varying(100),
    CONSTRAINT account_details_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_los.account_details OWNER TO appuser;

--
-- Name: group__member_details; Type: TABLE; Schema: mfi_los; Owner: appuser
--

CREATE TABLE mfi_los.group__member_details (
    id bigint NOT NULL,
    loan_app_id bigint NOT NULL,
    group_id bigint NOT NULL,
    is_signatory_one boolean,
    is_signatory_two boolean,
    reason character varying(50),
    notes character varying(100),
    is_leader boolean DEFAULT false,
    is_signatory boolean DEFAULT false,
    created_on timestamp without time zone NOT NULL,
    created_by character varying(25) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    updated_by character varying(25) NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    signatory_order integer,
    CONSTRAINT group__member_details_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_los.group__member_details OWNER TO appuser;

--
-- Name: group_details; Type: TABLE; Schema: mfi_los; Owner: appuser
--

CREATE TABLE mfi_los.group_details (
    id bigint NOT NULL,
    formatted_id character varying(50) NOT NULL,
    origination_employee_id bigint,
    employee_user_id character varying(25),
    group_name character varying(50),
    group_image_document_id bigint,
    sales_promocode_id character varying(25),
    rate_of_interest numeric(19,6),
    loan_term bigint,
    term_unit character varying(50),
    cycle_count integer DEFAULT 0,
    group_loan_amount numeric(19,6),
    loan_product_type character varying(50),
    loan_product_name character varying(50),
    group_type character varying(50),
    previous_group_id character varying(50),
    previous_group_name character varying(75),
    is_pure_renewal_group boolean DEFAULT false,
    group_status character varying(50),
    group_status_type character varying(20) DEFAULT 'Not Started'::character varying,
    credit_promocode_id character varying(50),
    fts_barcode character varying(12),
    lead_generator character varying(25),
    dsa_code character varying(56),
    sub_dsa_code character varying(25),
    lead_number character varying(25),
    vtc_id bigint,
    rejected_stage character varying(50),
    rejected_reason character varying(150),
    office_id bigint,
    meeting_center_id bigint,
    meeting_start_time character varying(20),
    meeting_end_time character varying(20),
    meeting_date character varying(10),
    repayment_date character varying(25),
    expected_disbursement_date timestamp without time zone,
    first_repayment_date timestamp without time zone,
    bet_start_time timestamp without time zone,
    bet_end_time timestamp without time zone,
    is_group_sign_done character varying(20) DEFAULT '0'::character varying NOT NULL,
    is_signatory_updated boolean DEFAULT false,
    rented_house_percentage character varying(10),
    created_on timestamp without time zone NOT NULL,
    created_by character varying(25) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    updated_by character varying(25) NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    extensible_json_data text,
    min_member_count integer,
    max_member_count integer,
    remarks character varying(150),
    loan_product_code character varying(50),
    scheme_type character varying(255),
    group_cycle_type character varying(255),
    group_code character varying(255),
    age_of_group character varying(255),
    group_inception_date date,
    blended_interest_rate numeric(19,6),
    is_shg_verified boolean,
    group_inception_document_id bigint,
    customer_id bigint,
    customer_formatted_id character varying(50),
    ucic character varying(50),
    group_account_number character varying(30),
    group_disbursed_amount bigint,
    so_rate_of_interest numeric(19,6),
    slab1_roi numeric(19,6),
    slab2_roi numeric(19,6),
    promocode_version integer,
    slab3_roi numeric(19,6),
    posidex_fields_updated_flag boolean,
    loan_account_id character varying(100),
    sanction_date timestamp without time zone,
    lan_status character varying(60),
    ucic_creation_date timestamp without time zone,
    ucic_updation_date timestamp without time zone,
    CONSTRAINT group_details_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_los.group_details OWNER TO appuser;

--
-- Name: loan_app; Type: TABLE; Schema: mfi_los; Owner: appuser
--

CREATE TABLE mfi_los.loan_app (
    id bigint NOT NULL,
    formatted_id character varying(50) NOT NULL,
    loan_product_id bigint,
    loan_product_code character varying(50),
    loan_product_category character varying(50),
    loan_type character varying(250),
    is_associated_to_group boolean DEFAULT false,
    loan_account_id bigint,
    loan_account_number character varying(30),
    loan_purpose character varying(50),
    loan_purpose_type character varying(20),
    requested_amount numeric(19,6),
    recommended_amount bigint,
    bet_recommended_amount numeric(19,6),
    eligible_loan_amount numeric(19,6),
    approved_amount numeric(19,6),
    insurance_amount numeric(19,6),
    disbursed_amount bigint,
    rate_of_interest numeric(19,6),
    member_level_roi numeric(19,6),
    loan_term integer,
    term_unit character varying(10),
    number_of_installments integer,
    expected_disbursement_date timestamp without time zone,
    loan_disbursed_date timestamp without time zone,
    first_repayment_date timestamp without time zone,
    origination_channel character varying(20),
    cycle_count integer DEFAULT 0,
    sales_promocode_id character varying(50),
    lead_generator character varying(25),
    sub_dsa_code character varying(25),
    lead_number character varying(25),
    office_id bigint,
    vtc_id bigint,
    psl_flag boolean,
    psl_type character varying(256),
    psl_category character varying(50),
    psl_sub_category character varying(50),
    psl_tagging_status bigint DEFAULT 0,
    mfi_flag boolean,
    rtr_flag boolean,
    village_proceed_reason character varying(50),
    status character varying(50),
    rejected_stage character varying(256),
    status_code bigint,
    reject_reason character varying(1024),
    reject_stage character varying(50),
    income_reason character varying(150),
    employee_id bigint,
    employee_user_id character varying(25),
    employee_type character varying(60),
    fts_barcode character varying(12),
    extensible_json_data text,
    created_by character varying(25) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    updated_by character varying(25) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    is_stp boolean DEFAULT true,
    customer_type character varying(32),
    constitution character varying(64),
    dsa_code character varying(125),
    member_availing_flag boolean,
    member_eligibility_flag boolean,
    sanction_date timestamp without time zone,
    lan_status character varying(60),
    CONSTRAINT loan_app_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_los.loan_app OWNER TO appuser;

--
-- Name: account_details_id_seq; Type: SEQUENCE; Schema: mfi_los; Owner: appuser
--

CREATE SEQUENCE mfi_los.account_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_los.account_details_id_seq OWNER TO appuser;

--
-- Name: account_details_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_los; Owner: appuser
--

ALTER SEQUENCE mfi_los.account_details_id_seq OWNED BY mfi_los.account_details.id;


--
-- Name: borrower; Type: TABLE; Schema: mfi_los; Owner: appuser
--

CREATE TABLE mfi_los.borrower (
    id bigint NOT NULL,
    loan_app_id bigint NOT NULL,
    borrower_type character varying(50) NOT NULL,
    relationship_with_borrower character varying(64),
    first_name character varying(150),
    middle_name character varying(150),
    last_name character varying(150),
    date_of_birth character varying(11),
    gender character varying(15),
    parent_name character varying(150),
    marital_status character varying(50),
    spouse_name character varying(150),
    mobile_number character varying(16),
    mobile_owner character varying(50),
    mobile_verified boolean DEFAULT false NOT NULL,
    mobile_verification_failure_reason character varying(100),
    is_earning boolean,
    borrower_live_image_id bigint,
    signature bytea,
    ovd_not_bio_reason character varying(100),
    kyc_type character varying(30),
    kyc_consent_captured boolean DEFAULT false NOT NULL,
    kyc_consent_document_id bigint,
    customer_id_borrower bigint,
    formatted_customer_id character varying(128),
    base_office_id bigint,
    ucic character varying(50),
    alternate_mobile_number character varying(16),
    email_id character varying(254),
    alternate_email_id character varying(10),
    highest_qualification character varying(50),
    physically_disabled character varying(50),
    mother_maiden_name character varying(150),
    fatca_city_of_birth_code character varying(20),
    fatca_state_code character varying(20),
    fatca_country_code character varying(20),
    fatca_consent boolean,
    residence_stability bigint,
    business_stability bigint,
    borrower_community_code character varying(20),
    borrower_religion_code character varying(20),
    insurance_flag boolean,
    active_loan_added boolean,
    current_address_type character varying(50),
    current_address_proof_type character varying(50),
    current_address_document_id character varying(50),
    current_address_valid_till character varying(20),
    extensible_json_data text,
    created_on timestamp without time zone NOT NULL,
    created_by character varying(64) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    updated_by character varying(64) NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    posidex_fields_updated_flag boolean,
    ucic_creation_date timestamp without time zone,
    ucic_updation_date timestamp without time zone,
    ckyc_status character varying(10),
    ckyc_number character varying(15),
    ckyc_reject_reason text,
    CONSTRAINT borrower_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_los.borrower OWNER TO appuser;

--
-- Name: borrower_id_seq; Type: SEQUENCE; Schema: mfi_los; Owner: appuser
--

CREATE SEQUENCE mfi_los.borrower_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_los.borrower_id_seq OWNER TO appuser;

--
-- Name: borrower_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_los; Owner: appuser
--

ALTER SEQUENCE mfi_los.borrower_id_seq OWNED BY mfi_los.borrower.id;


--
-- Name: disburse_loan_process; Type: TABLE; Schema: mfi_los; Owner: appuser
--

CREATE TABLE mfi_los.disburse_loan_process (
    id bigint NOT NULL,
    entity_id bigint NOT NULL,
    loan_account_number character varying(30),
    retry_count bigint,
    status bigint,
    reinitiate_value character varying(30),
    failure_reason character varying(1024),
    created_on timestamp without time zone,
    started_on timestamp without time zone,
    completed_on timestamp without time zone,
    is_stp boolean DEFAULT true,
    flow character varying(64) DEFAULT 'DEFAULT'::character varying,
    flow_status character varying(64) DEFAULT 'DEFAULT'::character varying,
    entity_type character varying(36),
    CONSTRAINT disburse_loan_process_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_los.disburse_loan_process OWNER TO appuser;

--
-- Name: disburse_loan_process_id_seq; Type: SEQUENCE; Schema: mfi_los; Owner: appuser
--

CREATE SEQUENCE mfi_los.disburse_loan_process_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_los.disburse_loan_process_id_seq OWNER TO appuser;

--
-- Name: disburse_loan_process_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_los; Owner: appuser
--

ALTER SEQUENCE mfi_los.disburse_loan_process_id_seq OWNED BY mfi_los.disburse_loan_process.id;


--
-- Name: group__member_details_id_seq; Type: SEQUENCE; Schema: mfi_los; Owner: appuser
--

CREATE SEQUENCE mfi_los.group__member_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_los.group__member_details_id_seq OWNER TO appuser;

--
-- Name: group__member_details_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_los; Owner: appuser
--

ALTER SEQUENCE mfi_los.group__member_details_id_seq OWNED BY mfi_los.group__member_details.id;


--
-- Name: group_details_id_seq; Type: SEQUENCE; Schema: mfi_los; Owner: appuser
--

CREATE SEQUENCE mfi_los.group_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_los.group_details_id_seq OWNER TO appuser;

--
-- Name: group_details_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_los; Owner: appuser
--

ALTER SEQUENCE mfi_los.group_details_id_seq OWNED BY mfi_los.group_details.id;


--
-- Name: insurance_policy_details; Type: TABLE; Schema: mfi_los; Owner: appuser
--

CREATE TABLE mfi_los.insurance_policy_details (
    id bigint NOT NULL,
    loan_app_id bigint NOT NULL,
    borrower_id bigint NOT NULL,
    loan_account_id character varying(50),
    insured_person_type character varying(50),
    insurance_product_code character varying(50),
    insurance_provider_code character varying(50),
    policy_type_code character varying(50),
    mph_number character varying(50),
    policy_number character varying(50),
    cover_amount_at_inception numeric(20,2),
    prem_amount_ex_serv_tax numeric(20,2),
    prem_amount_incl_serv_tax numeric(20,2),
    total_tax_amount numeric(20,2),
    charge_inclusive_of_tax character varying(50),
    policy_start_date timestamp without time zone,
    policy_end_date timestamp without time zone,
    age_on_member_on_policy_start_date bigint,
    prem_calc_code character varying(50),
    nominee_bank_account_id character varying(50),
    status character varying(50),
    claim_amount numeric(20,2),
    created_by character varying(25) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    updated_by character varying(25) NOT NULL,
    updated_on timestamp without time zone NOT NULL,
    is_deleted boolean NOT NULL,
    is_posted boolean,
    CONSTRAINT insurance_policy_details_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_los.insurance_policy_details OWNER TO appuser;

--
-- Name: insurance_policy_details_id_seq; Type: SEQUENCE; Schema: mfi_los; Owner: appuser
--

CREATE SEQUENCE mfi_los.insurance_policy_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_los.insurance_policy_details_id_seq OWNER TO appuser;

--
-- Name: insurance_policy_details_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_los; Owner: appuser
--

ALTER SEQUENCE mfi_los.insurance_policy_details_id_seq OWNED BY mfi_los.insurance_policy_details.id;


--
-- Name: insurance_tax_components; Type: TABLE; Schema: mfi_los; Owner: appuser
--

CREATE TABLE mfi_los.insurance_tax_components (
    id bigint NOT NULL,
    insurance_policy_details_id bigint NOT NULL,
    tax_amount character varying(50),
    tax_code character varying(50),
    tax_name character varying(50),
    tax_rate character varying(50),
    CONSTRAINT insurance_tax_components_pkey PRIMARY KEY((id) HASH)
);


ALTER TABLE mfi_los.insurance_tax_components OWNER TO appuser;

--
-- Name: insurance_tax_components_id_seq; Type: SEQUENCE; Schema: mfi_los; Owner: appuser
--

CREATE SEQUENCE mfi_los.insurance_tax_components_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_los.insurance_tax_components_id_seq OWNER TO appuser;

--
-- Name: insurance_tax_components_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_los; Owner: appuser
--

ALTER SEQUENCE mfi_los.insurance_tax_components_id_seq OWNED BY mfi_los.insurance_tax_components.id;


--
-- Name: loan_app_id_seq; Type: SEQUENCE; Schema: mfi_los; Owner: appuser
--

CREATE SEQUENCE mfi_los.loan_app_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE mfi_los.loan_app_id_seq OWNER TO appuser;

--
-- Name: loan_app_id_seq; Type: SEQUENCE OWNED BY; Schema: mfi_los; Owner: appuser
--

ALTER SEQUENCE mfi_los.loan_app_id_seq OWNED BY mfi_los.loan_app.id;


--
-- Name: repayment_account_details id; Type: DEFAULT; Schema: mfi_accounting; Owner: appuser
--

ALTER TABLE ONLY mfi_accounting.repayment_account_details ALTER COLUMN id SET DEFAULT nextval('mfi_accounting.repayment_account_details_id_seq'::regclass);


--
-- Name: repayment_mandate_details id; Type: DEFAULT; Schema: mfi_accounting; Owner: appuser
--

ALTER TABLE ONLY mfi_accounting.repayment_mandate_details ALTER COLUMN id SET DEFAULT nextval('mfi_accounting.repayment_mandate_details_id_seq'::regclass);


--
-- Name: actor id; Type: DEFAULT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.actor ALTER COLUMN id SET DEFAULT nextval('mfi_actor.actor_id_seq'::regclass);


--
-- Name: actor__address__mapping id; Type: DEFAULT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.actor__address__mapping ALTER COLUMN id SET DEFAULT nextval('mfi_actor.actor__address__mapping_id_seq'::regclass);


--
-- Name: actor__contact_detail__mapping id; Type: DEFAULT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.actor__contact_detail__mapping ALTER COLUMN id SET DEFAULT nextval('mfi_actor.actor__contact_detail__mapping_id_seq'::regclass);


--
-- Name: address id; Type: DEFAULT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.address ALTER COLUMN id SET DEFAULT nextval('mfi_actor.address_id_seq'::regclass);


--
-- Name: contact_detail id; Type: DEFAULT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.contact_detail ALTER COLUMN id SET DEFAULT nextval('mfi_actor.contact_detail_id_seq'::regclass);


--
-- Name: customer id; Type: DEFAULT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.customer ALTER COLUMN id SET DEFAULT nextval('mfi_actor.customer_id_seq'::regclass);


--
-- Name: account_details id; Type: DEFAULT; Schema: mfi_los; Owner: appuser
--

ALTER TABLE ONLY mfi_los.account_details ALTER COLUMN id SET DEFAULT nextval('mfi_los.account_details_id_seq'::regclass);


--
-- Name: borrower id; Type: DEFAULT; Schema: mfi_los; Owner: appuser
--

ALTER TABLE ONLY mfi_los.borrower ALTER COLUMN id SET DEFAULT nextval('mfi_los.borrower_id_seq'::regclass);


--
-- Name: disburse_loan_process id; Type: DEFAULT; Schema: mfi_los; Owner: appuser
--

ALTER TABLE ONLY mfi_los.disburse_loan_process ALTER COLUMN id SET DEFAULT nextval('mfi_los.disburse_loan_process_id_seq'::regclass);


--
-- Name: group__member_details id; Type: DEFAULT; Schema: mfi_los; Owner: appuser
--

ALTER TABLE ONLY mfi_los.group__member_details ALTER COLUMN id SET DEFAULT nextval('mfi_los.group__member_details_id_seq'::regclass);


--
-- Name: group_details id; Type: DEFAULT; Schema: mfi_los; Owner: appuser
--

ALTER TABLE ONLY mfi_los.group_details ALTER COLUMN id SET DEFAULT nextval('mfi_los.group_details_id_seq'::regclass);


--
-- Name: insurance_policy_details id; Type: DEFAULT; Schema: mfi_los; Owner: appuser
--

ALTER TABLE ONLY mfi_los.insurance_policy_details ALTER COLUMN id SET DEFAULT nextval('mfi_los.insurance_policy_details_id_seq'::regclass);


--
-- Name: insurance_tax_components id; Type: DEFAULT; Schema: mfi_los; Owner: appuser
--

ALTER TABLE ONLY mfi_los.insurance_tax_components ALTER COLUMN id SET DEFAULT nextval('mfi_los.insurance_tax_components_id_seq'::regclass);


--
-- Name: loan_app id; Type: DEFAULT; Schema: mfi_los; Owner: appuser
--

ALTER TABLE ONLY mfi_los.loan_app ALTER COLUMN id SET DEFAULT nextval('mfi_los.loan_app_id_seq'::regclass);


--
-- Name: repayment_account_details repayment_account_details_account_number_key; Type: CONSTRAINT; Schema: mfi_accounting; Owner: appuser
--

CREATE UNIQUE INDEX NONCONCURRENTLY repayment_account_details_account_number_key ON mfi_accounting.repayment_account_details USING lsm (account_number HASH);

ALTER TABLE ONLY mfi_accounting.repayment_account_details
    ADD CONSTRAINT repayment_account_details_account_number_key UNIQUE USING INDEX repayment_account_details_account_number_key;


--
-- Name: group_details group_details_fts_barcode_key; Type: CONSTRAINT; Schema: mfi_los; Owner: appuser
--

CREATE UNIQUE INDEX NONCONCURRENTLY group_details_fts_barcode_key ON mfi_los.group_details USING lsm (fts_barcode HASH);

ALTER TABLE ONLY mfi_los.group_details
    ADD CONSTRAINT group_details_fts_barcode_key UNIQUE USING INDEX group_details_fts_barcode_key;


--
-- Name: loan_app loan_app_fts_barcode_key; Type: CONSTRAINT; Schema: mfi_los; Owner: appuser
--

CREATE UNIQUE INDEX NONCONCURRENTLY loan_app_fts_barcode_key ON mfi_los.loan_app USING lsm (fts_barcode HASH);

ALTER TABLE ONLY mfi_los.loan_app
    ADD CONSTRAINT loan_app_fts_barcode_key UNIQUE USING INDEX loan_app_fts_barcode_key;


--
-- Name: repayment_mandate_details_loan_account_id_start_date_end_da_idx; Type: INDEX; Schema: mfi_accounting; Owner: appuser
--

CREATE INDEX repayment_mandate_details_loan_account_id_start_date_end_da_idx ON mfi_accounting.repayment_mandate_details USING lsm (loan_account_id HASH, start_date ASC, end_date ASC) INCLUDE (mandate_category) WHERE (is_deleted = false);


--
-- Name: actor__address__mapping_actor_id; Type: INDEX; Schema: mfi_actor; Owner: appuser
--

CREATE INDEX actor__address__mapping_actor_id ON mfi_actor.actor__address__mapping USING lsm (actor_id HASH);


--
-- Name: actor__contact_detail__mapping_actor_id; Type: INDEX; Schema: mfi_actor; Owner: appuser
--

CREATE INDEX actor__contact_detail__mapping_actor_id ON mfi_actor.actor__contact_detail__mapping USING lsm (actor_id HASH);


--
-- Name: actor__contact_detail__mapping_contact_detail_id; Type: INDEX; Schema: mfi_actor; Owner: appuser
--

CREATE INDEX actor__contact_detail__mapping_contact_detail_id ON mfi_actor.actor__contact_detail__mapping USING lsm (contact_detail_id HASH);


--
-- Name: customer_actor_id; Type: INDEX; Schema: mfi_actor; Owner: appuser
--

CREATE INDEX customer_actor_id ON mfi_actor.customer USING lsm (actor_id HASH);


--
-- Name: customer_base_office_id; Type: INDEX; Schema: mfi_actor; Owner: appuser
--

CREATE INDEX customer_base_office_id ON mfi_actor.customer USING lsm (base_office_id HASH);


--
-- Name: customer_corporate_id; Type: INDEX; Schema: mfi_actor; Owner: appuser
--

CREATE INDEX customer_corporate_id ON mfi_actor.customer USING lsm (corporate_id HASH);


--
-- Name: customer_external_id_idx; Type: INDEX; Schema: mfi_actor; Owner: appuser
--

CREATE INDEX customer_external_id_idx ON mfi_actor.customer USING lsm (external_id HASH);


--
-- Name: idx_address_type; Type: INDEX; Schema: mfi_actor; Owner: appuser
--

CREATE INDEX idx_address_type ON mfi_actor.address USING lsm (type HASH);


--
-- Name: account_details_group_id_purpose_holder_type_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX account_details_group_id_purpose_holder_type_idx ON mfi_los.account_details USING lsm (group_id HASH, account_purpose ASC, account_holder_type ASC);


--
-- Name: account_details_loan_app_id_purpose_holder_type_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX account_details_loan_app_id_purpose_holder_type_idx ON mfi_los.account_details USING lsm (loan_app_id HASH, account_purpose ASC, account_holder_type ASC);


--
-- Name: borrower_customer_id_borrower_id_is_deleted_loan_app_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_customer_id_borrower_id_is_deleted_loan_app_id_idx ON mfi_los.borrower USING lsm (customer_id_borrower HASH, id DESC, is_deleted ASC) INCLUDE (loan_app_id);


--
-- Name: borrower_customer_id_borrower_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_customer_id_borrower_idx ON mfi_los.borrower USING lsm (customer_id_borrower HASH);


--
-- Name: borrower_fatca_city_of_birth_code_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_fatca_city_of_birth_code_idx ON mfi_los.borrower USING lsm (fatca_city_of_birth_code HASH);


--
-- Name: borrower_kyc_consent_document_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_kyc_consent_document_id_idx ON mfi_los.borrower USING lsm (kyc_consent_document_id HASH);


--
-- Name: borrower_kyc_consent_document_id_is_deleted_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_kyc_consent_document_id_is_deleted_idx ON mfi_los.borrower USING lsm (kyc_consent_document_id HASH, is_deleted ASC);


--
-- Name: borrower_loan_app_id_borrower_type_is_deleted_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_loan_app_id_borrower_type_is_deleted_idx ON mfi_los.borrower USING lsm (loan_app_id HASH, borrower_type ASC, is_deleted ASC);


--
-- Name: borrower_loan_app_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_loan_app_id_idx ON mfi_los.borrower USING lsm (loan_app_id HASH);


--
-- Name: borrower_mobile_number_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_mobile_number_idx ON mfi_los.borrower USING lsm (mobile_number HASH);


--
-- Name: borrower_type_loan_app_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_type_loan_app_idx ON mfi_los.borrower USING lsm (borrower_type HASH, loan_app_id ASC);


--
-- Name: borrower_ucic_id_is_deleted_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_ucic_id_is_deleted_idx ON mfi_los.borrower USING lsm (ucic HASH, id DESC, is_deleted ASC);


--
-- Name: borrower_ucic_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX borrower_ucic_idx ON mfi_los.borrower USING lsm (ucic HASH);


--
-- Name: disburse_loan_process_loan_account_number_completed_on_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX disburse_loan_process_loan_account_number_completed_on_idx ON mfi_los.disburse_loan_process USING lsm (loan_account_number HASH, completed_on ASC);


--
-- Name: disburse_loan_process_loan_app_id_flow_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX disburse_loan_process_loan_app_id_flow_idx ON mfi_los.disburse_loan_process USING lsm (entity_id HASH, flow ASC);


--
-- Name: disburse_loan_process_status_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX disburse_loan_process_status_id_idx ON mfi_los.disburse_loan_process USING lsm (status HASH, id ASC);


--
-- Name: disburse_loan_process_status_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX disburse_loan_process_status_idx ON mfi_los.disburse_loan_process USING lsm (status HASH);


--
-- Name: group__member_details_group_loan_app_sign_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX group__member_details_group_loan_app_sign_idx ON mfi_los.group__member_details USING lsm (group_id HASH, loan_app_id ASC, is_signatory_one ASC, is_signatory_two ASC);


--
-- Name: group__member_details_loan_app_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX group__member_details_loan_app_id_idx ON mfi_los.group__member_details USING lsm (loan_app_id HASH);


--
-- Name: group_details_meeting_center_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX group_details_meeting_center_id_idx ON mfi_los.group_details USING lsm (meeting_center_id HASH);


--
-- Name: group_details_vtc_id_is_deleted_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX group_details_vtc_id_is_deleted_idx ON mfi_los.group_details USING lsm (vtc_id HASH, is_deleted ASC);


--
-- Name: idx_formatted_customer_id; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX idx_formatted_customer_id ON mfi_los.borrower USING lsm (formatted_customer_id DESC);


--
-- Name: idx_group_id; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX idx_group_id ON mfi_los.group__member_details USING lsm (group_id HASH);


--
-- Name: idx_loan_app_id; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX idx_loan_app_id ON mfi_los.disburse_loan_process USING lsm (entity_id HASH);


--
-- Name: idx_origination_employee_id; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX idx_origination_employee_id ON mfi_los.group_details USING lsm (origination_employee_id HASH);


--
-- Name: insurance_policy_details_loan_borrower_insured_policy_type_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX insurance_policy_details_loan_borrower_insured_policy_type_idx ON mfi_los.insurance_policy_details USING lsm (loan_app_id HASH, borrower_id ASC, insured_person_type ASC, policy_type_code ASC);


--
-- Name: insurance_tax_components_insurance_policy_details_id; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX insurance_tax_components_insurance_policy_details_id ON mfi_los.insurance_tax_components USING lsm (insurance_policy_details_id HASH);


--
-- Name: loan_app_employee_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_employee_id_idx ON mfi_los.loan_app USING lsm (employee_id HASH);


--
-- Name: loan_app_employee_id_loan_product_code_is_deleted_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_employee_id_loan_product_code_is_deleted_idx ON mfi_los.loan_app USING lsm (employee_id HASH, loan_product_code ASC, is_deleted ASC) WHERE (employee_id IS NOT NULL);


--
-- Name: loan_app_formatted_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_formatted_id_idx ON mfi_los.loan_app USING lsm (formatted_id HASH);


--
-- Name: loan_app_loan_account_number_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_loan_account_number_idx ON mfi_los.loan_app USING lsm (loan_account_number HASH);


--
-- Name: loan_app_loan_account_number_is_deleted_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_loan_account_number_is_deleted_idx ON mfi_los.loan_app USING lsm (loan_account_number HASH, is_deleted ASC);


--
-- Name: loan_app_loan_type_loan_product_code_employee_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_loan_type_loan_product_code_employee_id_idx ON mfi_los.loan_app USING lsm (loan_type HASH, loan_product_code ASC, employee_id ASC);


--
-- Name: loan_app_psl_type_tagging_status_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_psl_type_tagging_status_idx ON mfi_los.loan_app USING lsm (psl_type HASH, psl_tagging_status ASC);


--
-- Name: loan_app_status_code_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_status_code_idx ON mfi_los.loan_app USING lsm (status_code HASH);


--
-- Name: loan_app_status_employee_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_status_employee_id_idx ON mfi_los.loan_app USING lsm (status HASH, employee_id ASC);


--
-- Name: loan_app_vtc_id_employee_id_idx; Type: INDEX; Schema: mfi_los; Owner: appuser
--

CREATE INDEX loan_app_vtc_id_employee_id_idx ON mfi_los.loan_app USING lsm (vtc_id HASH, employee_id ASC);


--
-- Name: actor__address__mapping fk_actor__address__mapping_address1; Type: FK CONSTRAINT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.actor__address__mapping
    ADD CONSTRAINT fk_actor__address__mapping_address1 FOREIGN KEY (address_id) REFERENCES mfi_actor.address(id);


--
-- Name: actor__contact_detail__mapping fk_actor_contact_detail_actor1; Type: FK CONSTRAINT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.actor__contact_detail__mapping
    ADD CONSTRAINT fk_actor_contact_detail_actor1 FOREIGN KEY (actor_id) REFERENCES mfi_actor.actor(id);


--
-- Name: customer fk_customer_actor1; Type: FK CONSTRAINT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.customer
    ADD CONSTRAINT fk_customer_actor1 FOREIGN KEY (actor_id) REFERENCES mfi_actor.actor(id);


--
-- Name: customer fk_customer_corporate1; Type: FK CONSTRAINT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.customer
    ADD CONSTRAINT fk_customer_corporate1 FOREIGN KEY (corporate_id) REFERENCES mfi_actor.corporate(id);


--
-- Name: customer fk_customer_office1; Type: FK CONSTRAINT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.customer
    ADD CONSTRAINT fk_customer_office1 FOREIGN KEY (base_office_id) REFERENCES mfi_actor.office(id);


--
-- Name: actor__address__mapping fk_office_address_copy1_actor1; Type: FK CONSTRAINT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.actor__address__mapping
    ADD CONSTRAINT fk_office_address_copy1_actor1 FOREIGN KEY (actor_id) REFERENCES mfi_actor.actor(id);


--
-- Name: actor__contact_detail__mapping fk_office_contact_detail_contact_detail10; Type: FK CONSTRAINT; Schema: mfi_actor; Owner: appuser
--

ALTER TABLE ONLY mfi_actor.actor__contact_detail__mapping
    ADD CONSTRAINT fk_office_contact_detail_contact_detail10 FOREIGN KEY (contact_detail_id) REFERENCES mfi_actor.contact_detail(id);


Schema Name	Table	Per group rows	classification
mfi_los	loan_app	10	TOTAL_APPLICATIONS
mfi_los	borrower	10	TOTAL_CUSTOMERS
mfi_actor	customer	10	TOTAL_CUSTOMERS
mfi_actor	actor	10	TOTAL_CUSTOMERS
mfi_actor	actor__address__mapping	10	TOTAL_CUSTOMERS
mfi_actor	actor__contact_detail__mapping	10	TOTAL_CUSTOMERS
mfi_actor	contact_detail	10	TOTAL_CUSTOMERS
mfi_actor	address	10	TOTAL_CUSTOMERS
mfi_los	insurance_policy_details	30	TOTAL_APPLICATIONS
mfi_los	insurance_tax_components	90	TOTAL_APPLICATIONS
mfi_los	group_details	1	TOTAL_GROUPS
mfi_los	group__member_details	10	TOTAL_APPLICATIONS
mfi_los	account_details	"20 - for eNach
10 - for SI"	"TOTAL_SI
TOTAL_ENACH"
mfi_los	disburse_loan_process	10	TOTAL_APPLICATIONS
mfi_accounting	repayment_account_details	10	TOTAL_APPLICATIONS
mfi_accounting	repayment_mandate_details	10	TOTAL_APPLICATIONS
