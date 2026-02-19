-- =====================================================================
-- Drop in dependency order (optional for a clean re-create)
-- =====================================================================
DROP TABLE IF EXISTS Registration    CASCADE;
DROP TABLE IF EXISTS Viewing         CASCADE;
DROP TABLE IF EXISTS PropertyForRent CASCADE;
DROP TABLE IF EXISTS Client          CASCADE;
DROP TABLE IF EXISTS Staff           CASCADE;
DROP TABLE IF EXISTS PrivateOwner    CASCADE;
DROP TABLE IF EXISTS Branch          CASCADE;

-- =====================================================================
-- 1) Branch
-- =====================================================================
CREATE TABLE Branch (
    branchNo  VARCHAR(10) PRIMARY KEY,              -- e.g., B005
    street    VARCHAR(100) NOT NULL,
    city      VARCHAR(50)  NOT NULL,
    postcode  VARCHAR(10)  NOT NULL
);

-- =====================================================================
-- 2) Staff (belongs to a Branch)
-- =====================================================================
CREATE TABLE Staff (
    staffNo   VARCHAR(10) PRIMARY KEY,              -- e.g., SG37
    fName     VARCHAR(50)  NOT NULL,
    IName     VARCHAR(50)  NOT NULL,
    position  VARCHAR(50)  NOT NULL,
    sex       CHAR(1)      NOT NULL CHECK (sex IN ('M','F')),
    DOB       DATE         NOT NULL CHECK (DOB <= CURRENT_DATE - INTERVAL '18 years'),
    salary    NUMERIC(10,2) NOT NULL CHECK (salary > 0),
    branchNo  VARCHAR(10)  NOT NULL,
    CONSTRAINT fk_staff_branch
        FOREIGN KEY (branchNo)
        REFERENCES Branch(branchNo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================================
-- 3) PrivateOwner
-- =====================================================================
CREATE TABLE PrivateOwner (
    ownerNo  VARCHAR(10) PRIMARY KEY,               -- e.g., CO46
    fName    VARCHAR(50)  NOT NULL,
    IName    VARCHAR(50)  NOT NULL,
    address  VARCHAR(150) NOT NULL,
    telNo    VARCHAR(20)  NOT NULL,
    eMail    VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- =====================================================================
-- 4) Client
-- =====================================================================
CREATE TABLE Client (
    clientNo VARCHAR(10) PRIMARY KEY,               -- e.g., CR76
    fName    VARCHAR(50)  NOT NULL,
    IName    VARCHAR(50)  NOT NULL,
    telNo    VARCHAR(20)  NOT NULL,
    prefType VARCHAR(20)  CHECK (prefType IN ('House','Flat','Bungalow','Apartment')),
    maxRent  NUMERIC(10,2) CHECK (maxRent > 0),
    eMail    VARCHAR(100) UNIQUE
);

-- =====================================================================
-- 5) PropertyForRent (owned by PrivateOwner, handled by Staff at a Branch)
-- =====================================================================
CREATE TABLE PropertyForRent (
    propertyNo VARCHAR(10) PRIMARY KEY,             -- e.g., PG36
    street     VARCHAR(100) NOT NULL,
    city       VARCHAR(50)  NOT NULL,
    postcode   VARCHAR(10)  NOT NULL,
    type       VARCHAR(20)  CHECK (type IN ('House','Flat','Bungalow','Apartment')),
    rooms      INT          CHECK (rooms > 0),
    rent       NUMERIC(10,2) CHECK (rent > 0),
    ownerNo    VARCHAR(10)  NOT NULL,
    staffNo    VARCHAR(10),                         -- can be temporarily unassigned
    branchNo   VARCHAR(10)  NOT NULL,
    CONSTRAINT fk_prop_owner
        FOREIGN KEY (ownerNo)
        REFERENCES PrivateOwner(ownerNo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_prop_staff
        FOREIGN KEY (staffNo)
        REFERENCES Staff(staffNo)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_prop_branch
        FOREIGN KEY (branchNo)
        REFERENCES Branch(branchNo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- =====================================================================
-- 6) Viewing (Client views a Property on a date) — prevents duplicates
-- =====================================================================
CREATE TABLE Viewing (
    clientNo   VARCHAR(10) NOT NULL,
    propertyNo VARCHAR(10) NOT NULL,
    viewDate   DATE        NOT NULL,
    comment    TEXT,
    CONSTRAINT pk_viewing PRIMARY KEY (clientNo, propertyNo, viewDate),
    CONSTRAINT fk_view_client
        FOREIGN KEY (clientNo)
        REFERENCES Client(clientNo)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_view_property
        FOREIGN KEY (propertyNo)
        REFERENCES PropertyForRent(propertyNo)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =====================================================================
-- 7) Registration (Client registers at a Branch via a Staff member)
-- =====================================================================
CREATE TABLE Registration (
    clientNo   VARCHAR(10) NOT NULL,
    branchNo   VARCHAR(10) NOT NULL,
    staffNo    VARCHAR(10) NOT NULL,
    dateJoined DATE        NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT pk_registration PRIMARY KEY (clientNo, branchNo),
    CONSTRAINT fk_reg_client
        FOREIGN KEY (clientNo)
        REFERENCES Client(clientNo)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_reg_branch
        FOREIGN KEY (branchNo)
        REFERENCES Branch(branchNo)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_reg_staff
        FOREIGN KEY (staffNo)
        REFERENCES Staff(staffNo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
