CREATE TABLE customers(
id_customer CHAR(5) CONSTRAINT cust_idcust_pk PRIMARY KEY,
name VARCHAR2(50),
dob DATE,
gender VARCHAR2(20) CONSTRAINT gender_CK CHECK (gender IN('L', 'P')),
identity_num VARCHAR2(50) CONSTRAINT identitynum_NN NOT NULL,
CONSTRAINT identitynum_unique UNIQUE (identity_num),
address VARCHAR2 (200),
phone_number VARCHAR2(15),
CONSTRAINT custphonenumber_CK CHECK(REGEXP_LIKE(phone_number, '08*')),
driving_number VARCHAR2(20),
password VARCHAR2(20)
)


CREATE TABLE rent_transactions (
    id_rent_transaction CHAR(5) CONSTRAINT rent_idrent_PK PRIMARY KEY,
    id_customer CHAR(5) CONSTRAINT renttransaction_idcustomer_FK REFERENCES customers,
    rent_start_date DATE,
    rent_end_date DATE,
    CONSTRAINT check_rentdate CHECK (rent_end_date >= rent_start_date)
);


CREATE TABLE suppliers (
    supplier_id CHAR(5) CONSTRAINT supplier_id_pk PRIMARY KEY,
    supplier_name VARCHAR2(50) CONSTRAINT supname_NN NOT NULL,
    supplier_address VARCHAR2(150) CONSTRAINT supadd_NN NOT NULL,
    supplier_telephone_number VARCHAR2 (16) CONSTRAINT supnum_NN NOT NULL
)

CREATE TABLE jobs(
    job_id CHAR(5) CONSTRAINT jobs_jobid_pk PRIMARY KEY,
    job_title VARCHAR2(50) CONSTRAINT jobtitle_NN NOT NULL,
    hourlyRate NUMBER CONSTRAINT hourlyRate_NN NOT NULL
);

CREATE TABLE employees (
    employee_id CHAR(5) CONSTRAINT emp_idemp_pk PRIMARY KEY,
    employee_name VARCHAR2(100),
    employee_email VARCHAR2(100) CONSTRAINT employee_email_NN NOT NULL,
    CONSTRAINT employee_email_ck CHECK (REGEXP_LIKE(employee_email, '.*@gmail\.com$')),
    employee_phone_number VARCHAR2(16),
    employee_gender VARCHAR2(15) CONSTRAINT employee_gender_ck CHECK (employee_gender IN ('Male', 'Female')),
    employee_salary NUMBER,
    employee_dob DATE,
    job_id CHAR(5),
    CONSTRAINT jobs_idjob_FK FOREIGN KEY (job_id) REFERENCES jobs (job_id)
);

 CREATE TABLE Purchase_Transactions (
    purchase_id CHAR(5) CONSTRAINT purchase_id_pk PRIMARY KEY,
    purchase_date DATE CONSTRAINT pdate_NN NOT NULL, 
    purchase_total_price NUMBER CONSTRAINT totalprice_NN NOT NULL,
    employee_id CHAR(5),
    CONSTRAINT empid_fk FOREIGN KEY (employee_id) REFERENCES employees,
    supplier_id CHAR(5),
    CONSTRAINT supid_fk FOREIGN KEY (supplier_id) REFERENCES suppliers
);

CREATE TABLE payment_types(
id_payment_type CHAR(5) CONSTRAINT id_payment_type_PK PRIMARY KEY,
payment_type_name VARCHAR2(50) CONSTRAINT payment_type_name_NN NOT NULL,
CONSTRAINT payment_type_name_ck CHECK(payment_type_name IN('Cash', 'Debit')))

CREATE TABLE payments (
    payment_id CHAR(5) PRIMARY KEY,
    payment_date DATE NOT NULL,
    payment_status VARCHAR2(50) NOT NULL,
    payment_amount NUMBER NOT NULL,
    id_payment_type,
    FOREIGN KEY (id_payment_type) REFERENCES Payment_Types(id_payment_type)
);

CREATE TABLE car_types(
    car_type_id CHAR(5) CONSTRAINT car_type_id_pk PRIMARY KEY,
    car_type_name VARCHAR2 (50) CONSTRAINT car_type_name_NN NOT NULL,
    car_type_description VARCHAR2 (250) CONSTRAINT car_type_description_NN NOT NULL
)

CREATE TABLE cars (
    car_id CHAR(5) CONSTRAINT car_id_pk PRIMARY KEY,
    car_name VARCHAR2 (50) CONSTRAINT car_name_NN NOT NULL,
    car_status VARCHAR2 (50) CONSTRAINT car_status_NN NOT NULL,
    car_price NUMBER CONSTRAINT car_price_NN NOT NULL,
    car_colour VARCHAR2(25) CONSTRAINT car_colour_NN NOT NULL,
    car_type_id CHAR(5),
    CONSTRAINT  car_type_id_fk FOREIGN KEY (car_type_id) REFERENCES Car_Types,
    purchase_id CHAR(5),
    CONSTRAINT purchase_id_fk FOREIGN KEY (purchase_id) REFERENCES Purchase_Transactions
)

CREATE TABLE Detail_Rent_Transactions (
    id_rent_transaction CHAR(5),
    car_id CHAR(5) ,
    car_type_id CHAR(5),
    quantity_rent NUMBER CONSTRAINT qty_rent_NN NOT NULL,
    PRIMARY KEY (id_rent_transaction, car_id, car_type_id),
    FOREIGN KEY (id_rent_transaction) REFERENCES Rent_Transactions(id_rent_transaction),
    FOREIGN KEY (car_id) REFERENCES Cars(car_id),
    FOREIGN KEY (car_type_id) REFERENCES Car_Types(car_type_id)
);

CREATE TABLE With_Drivers (
    id_rent_transaction CHAR(5) CONSTRAINT rent_idrent_PK_with PRIMARY KEY,
    CONSTRAINT id_rent_transaction_fk2 FOREIGN KEY (id_rent_transaction) REFERENCES rent_transactions,
    driver_license_number VARCHAR(50),
    driver_extra_hour_fee NUMBER
);

CREATE TABLE without_driver(
    id_rent_transaction CHAR(5) CONSTRAINT rent_idrent_pk_without PRIMARY KEY, 
    CONSTRAINT id_rent_transaction_fk FOREIGN KEY (id_rent_transaction) REFERENCES rent_transactions,
    deposit_fee NUMBER CONSTRAINT deposit_fee_NN NOT NULL,
    damage_fee NUMBER
)

