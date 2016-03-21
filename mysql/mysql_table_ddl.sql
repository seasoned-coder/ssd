DROP TABLE IF EXISTS SSD_COMPANY_SHARE_MAP;
DROP TABLE IF EXISTS SSD_AUDIT_LOG;
DROP TABLE IF EXISTS SSD_BANK_AUDIT;
DROP TABLE IF EXISTS SSD_MACHINE_NETWORK_DETAILS;
DROP TABLE IF EXISTS SSD_USER;
DROP TABLE IF EXISTS SSD_NEWS;
DROP TABLE IF EXISTS SSD_NEWS_TYPE;
DROP TABLE IF EXISTS SSD_COMPANY;
DROP TABLE IF EXISTS SSD_BANK_AUDIT_CHANGE_REASON;
DROP TABLE IF EXISTS SSD_ROLE_ACCESS;
DROP TABLE IF EXISTS SSD_URL_ACCESS;
DROP TABLE IF EXISTS SSD_ROLE;
DROP TABLE IF EXISTS SSD_AUDIT_LOG_ACTION;
DROP TABLE IF EXISTS SSD_SIM_STATUS;

CREATE TABLE SSD_SIM_STATUS
(
  SIM_STATUS_ID INT(2) NOT NULL AUTO_INCREMENT,
  STATUS_NAME VARCHAR(32) NOT NULL,
  STATUS_VALUE INT(6),
  PRIMARY KEY (SIM_STATUS_ID)
);


CREATE TABLE SSD_ROLE
(
    ROLE_ID INT(4) NOT NULL,
    ROLE_DESC VARCHAR(25) NOT NULL,
    PRIMARY KEY (ROLE_ID)
);


CREATE TABLE SSD_COMPANY
(
  COMPANY_ID        INT(3) NOT NULL,
  NAME      VARCHAR(30) NOT NULL,
  CURRENT_BASE_PRICE INT(6),
  PREVIOUS_FLUCTUATED_PRICE INT(6),
  FLUCTUATED_PRICE INT(6),
  NUM_STAFF INT(2),
  LOAN_REQUESTED INT(6),
  LOAN_REMAINING INT(6),
  DISPUTE_VAL INT(6),
  BALANCE INT(6),
  CARS_MADE INT(2),
  PRESENTATION_TIME TIMESTAMP NULL,
  PRESENTATION_VALUE INT(2),
  PRESENTATION_NOTES VARCHAR(2000),
  SUSPENDED INT(1),
  PR_CARDS INT(3),
  PARTICIPATING INT(1),
  IDOT_COMPLETE INT(1) DEFAULT 0,
  PIN INT(4),
  PRIMARY KEY (COMPANY_ID)
);

CREATE TABLE SSD_MACHINE_NETWORK_DETAILS
(
    MAC_ADDRESS VARCHAR(50) NOT NULL,
    DESCRIPTION VARCHAR(50) NOT NULL,
    PRIMARY KEY (MAC_ADDRESS)
);

CREATE TABLE SSD_USER
(
    USER_ID INT(4) NOT NULL AUTO_INCREMENT,
    USERNAME VARCHAR(25) NOT NULL,
    FRIENDLY_NAME VARCHAR(25) NOT NULL,
    PASSWORD VARCHAR(50) NOT NULL,
    ROLE_ID INT(4) NOT NULL,
    COMPANY_ID INT(3),
    LAST_LOGIN TIMESTAMP,
    MAC_ADDRESS VARCHAR(50),
    PRIMARY KEY (USER_ID),
    UNIQUE (USERNAME),
    FOREIGN KEY (ROLE_ID)
        REFERENCES SSD_ROLE(ROLE_ID),
    FOREIGN KEY (COMPANY_ID)
        REFERENCES SSD_COMPANY(COMPANY_ID)
);


CREATE TABLE SSD_BANK_AUDIT_CHANGE_REASON
(
    BANK_AUDIT_CHANGE_REASON_ID INT(2) NOT NULL,
    REASON VARCHAR(128) NOT NULL,
    IS_POSITIVE INT(1) NOT NULL,
    IS_VISIBLE_TO_BANK INT(1) NOT NULL,
    PRIMARY KEY (BANK_AUDIT_CHANGE_REASON_ID)
);

CREATE TABLE SSD_BANK_AUDIT
(
    BANK_AUDIT_ID INT NOT NULL AUTO_INCREMENT,
    COMPANY_ID INT(3) NOT NULL,
    CHANGE_AMOUNT INT(6) NOT NULL,
    CHANGE_REASON_ID INT(2) NOT NULL,
    CURRENT_BALANCE INT(6) NOT NULL,
    TRANSACTION_TIME TIMESTAMP NOT NULL,
    CHANGED_BY INT(4) NOT NULL,
    PRIMARY KEY (BANK_AUDIT_ID),
    FOREIGN KEY (CHANGE_REASON_ID)
        REFERENCES SSD_BANK_AUDIT_CHANGE_REASON(BANK_AUDIT_CHANGE_REASON_ID),
    FOREIGN KEY (CHANGED_BY)
        REFERENCES SSD_USER(USER_ID)
);


CREATE TABLE SSD_COMPANY_SHARE_MAP
(
    COMPANY_ID INT(3) NOT NULL,
    SHARE_COMPANY_ID INT(3) NOT NULL,
    NUMBER_OF_SHARES INT(3) DEFAULT 0,
    PRIMARY KEY (COMPANY_ID, SHARE_COMPANY_ID),
    FOREIGN KEY (COMPANY_ID)
        REFERENCES SSD_company(company_id),
    FOREIGN KEY (SHARE_COMPANY_ID)
        REFERENCES SSD_company(company_id)
);

CREATE TABLE SSD_URL_ACCESS
(
    ACCESS_ID INT(4) NOT NULL,
    URL VARCHAR(50) NOT NULL,
    PRIMARY KEY (ACCESS_ID)
);


CREATE TABLE SSD_ROLE_ACCESS
(
    ROLE_ID INT(4) NOT NULL,
    ACCESS_ID INT(4) NOT NULL,
    PRIMARY KEY (ACCESS_ID, ROLE_ID),
    FOREIGN KEY (ROLE_ID)
        REFERENCES SSD_ROLE(ROLE_ID),
    FOREIGN KEY (ACCESS_ID)
        REFERENCES SSD_URL_ACCESS(ACCESS_ID)
);

CREATE TABLE SSD_AUDIT_LOG_ACTION
(
    AUDIT_LOG_ACTION_ID INT(2) NOT NULL AUTO_INCREMENT,
    ACTION_NAME VARCHAR(128) NOT NULL,
    PRIMARY KEY (AUDIT_LOG_ACTION_ID)
);

CREATE TABLE SSD_AUDIT_LOG
(
    AUDIT_LOG_ID INT(6) NOT NULL AUTO_INCREMENT,
    AUDIT_LOG_ACTION_ID INT(2) NOT NULL,
    USER_ID INT(4) NOT NULL,
    COMPANY_ID INT(4),
    AUDIT_TIME TIMESTAMP NOT NULL,
    AUDIT_DESCRIPTION TEXT NOT NULL,
    PRIMARY KEY (AUDIT_LOG_ID),
    FOREIGN KEY (USER_ID)
        REFERENCES SSD_USER(USER_ID),
    FOREIGN KEY (COMPANY_ID)
        REFERENCES SSD_COMPANY(COMPANY_ID),
    FOREIGN KEY (AUDIT_LOG_ACTION_ID)
        REFERENCES SSD_AUDIT_LOG_ACTION(AUDIT_LOG_ACTION_ID)
);

CREATE TABLE SSD_NEWS_TYPE
(
    NEWS_TYPE_ID INT(2),
    NEWS_TYPE_NAME VARCHAR(128),
    PRIMARY KEY (NEWS_TYPE_ID)
);

CREATE TABLE SSD_NEWS
(
    NEWS_ID INT(4) NOT NULL AUTO_INCREMENT,
    NEWS_TYPE_ID INT(2) NOT NULL,
    TEXT VARCHAR(512),
    COMPANY_ID INT(2),
    DATE_MODIFIED TIMESTAMP NOT NULL,
    EXPIRY_TIME TIMESTAMP NOT NULL,
    PRIMARY KEY (NEWS_ID),
    FOREIGN KEY (COMPANY_ID)
        REFERENCES SSD_COMPANY(COMPANY_ID),
    FOREIGN KEY (NEWS_TYPE_ID)
        REFERENCES SSD_NEWS_TYPE(NEWS_TYPE_ID)
);

INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('simStarted', 0);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('shareBustAmount', 0);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('shareBoomAmount', 0);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('presentationsLevelled', 0);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('firstIDotCompleted', 7);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('secondIDotCompleted', 5);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('thirdIDotCompleted', 3);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('iDotComplete', 3);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('firstBuildCar', 7);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('secondBuildCar', 5);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('thirdBuildCar', 3);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('carBuilt', 3);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('dividendPercentage', 10);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('shareOwnershipWarning', 20);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('shareBuyCommissionPercentage', 5);
INSERT INTO SSD_SIM_STATUS (STATUS_NAME, STATUS_VALUE) VALUES ('shareSellCommissionPercentage', 5);

INSERT INTO SSD_COMPANY VALUES (1, 'Asterix', 10, 10, 10, 14, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:00'), 0, '', 0, 0, 1, 0, 9784);
INSERT INTO SSD_COMPANY VALUES (2, 'Bends', 10, 10, 10, 13, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:14'), 0, '', 1, 0, 1, 0, 1314);
INSERT INTO SSD_COMPANY VALUES (3, 'Bulbesco', 10, 10, 10, 14, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:28'), 0, '', 0, 0, 1, 0, 4399);
INSERT INTO SSD_COMPANY VALUES (4, 'ChinWag', 10, 10, 10, 14, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:42'), 0, '', 0, 0, 1, 0, 7244);
INSERT INTO SSD_COMPANY VALUES (5, 'Fair Exchange', 10, 10, 10, 13, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:56'), 0, '', 0, 0, 1, 0, 3164);
INSERT INTO SSD_COMPANY VALUES (6, 'BASA', 10, 10, 10, 12, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:07'), 0, '', 0, 0, 1, 0, 9741);
INSERT INTO SSD_COMPANY VALUES (7, 'Bibi', 10, 10, 10, 13, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:21'), 0, '', 0, 0, 1, 0, 4484);
INSERT INTO SSD_COMPANY VALUES (8, 'Canardly', 10, 10, 10, 14, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:35'), 0, '', 0, 0, 1, 0, 1134);
INSERT INTO SSD_COMPANY VALUES (9, 'CNX', 10, 10, 10, 15, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 10:49'), 0, '', 0, 0, 1, 0, 1876);
INSERT INTO SSD_COMPANY VALUES (10, 'Fjord', 10, 10, 10, 12, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:03'), 0, '', 0, 0, 1, 0, 8831);
INSERT INTO SSD_COMPANY VALUES (11, 'Symphony', 10, 10, 10, 13, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 12:20'), 0, '', 0, 0, 0, 0, 3164);
INSERT INTO SSD_COMPANY VALUES (12, 'Go Karts', 10, 10, 10, 13, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:24'), 0, '', 0, 0, 1, 0, 3144);
INSERT INTO SSD_COMPANY VALUES (13, 'Lemon', 10, 10, 10, 13, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:38'), 0, '', 0, 0, 1, 0, 4903);
INSERT INTO SSD_COMPANY VALUES (14, 'Mogycar', 10, 10, 10, 14, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:52'), 0, '', 0, 0, 1, 0, 0798);
INSERT INTO SSD_COMPANY VALUES (15, 'Porish', 10, 10, 10, 14, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 12:06'), 0, '', 0, 0, 0, 0, 3190);
INSERT INTO SSD_COMPANY VALUES (16, 'Ganucar', 10, 10, 10, 12, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:17'), 0, '', 0, 0, 1, 0, 7048);
INSERT INTO SSD_COMPANY VALUES (17, 'Goundai', 10, 10, 10, 12, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:31'), 0, '', 0, 0, 1, 0, 5501);
INSERT INTO SSD_COMPANY VALUES (18, 'Lovol', 10, 10, 10, 13, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:45'), 0, '', 0, 0, 1, 0, 7491);
INSERT INTO SSD_COMPANY VALUES (19, 'Moon Buggy', 10, 10, 10, 13, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:59'), 0, '', 0, 0, 1, 0, 9761);
INSERT INTO SSD_COMPANY VALUES (20, 'Reno', 10, 10, 10, 14, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 12:13'), 0, '', 0, 0, 0, 0, 0395);
INSERT INTO SSD_COMPANY VALUES (21, 'Uraboat', 10, 10, 10, 12, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 12:27'), 0, '', 0, 0, 0, 0, 6431);
INSERT INTO SSD_COMPANY VALUES (22, 'Foxball', 10, 10, 10, 14, 0, 0, 0, 0, 0, TIMESTAMP('2015-06-18 11:10'), 0, '', 0, 0, 1, 0, 8274);

INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (1, 'Cash Deposit', '1', '1');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (2, 'Cash Withdrawal', '0', '1');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (3, 'Other Company Shares Value', '1', '0');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (4, 'Own Company Shares Value', '1', '0');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (5, 'Wages', '0', '0');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (6, 'Loan', '1', '1');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (7, 'Quiz payment', '1', '1');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (8, 'Loan repayment', '0', '1');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (9, 'Share dividend', '1', '0');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (10, 'Dragon''s Den Payment', '1', '0');
INSERT INTO SSD_BANK_AUDIT_CHANGE_REASON VALUES (11, 'Bank Adjustment', '1', '1');

INSERT INTO SSD_ROLE VALUES (1, 'Administrator');
INSERT INTO SSD_ROLE VALUES (2, 'Stockmarket Display');
INSERT INTO SSD_ROLE VALUES (3, 'Banker');
INSERT INTO SSD_ROLE VALUES (4, 'Share trader');
INSERT INTO SSD_ROLE VALUES (5, 'Share admin');
INSERT INTO SSD_ROLE VALUES (6, 'Back end');
INSERT INTO SSD_ROLE VALUES (7, 'Student');
INSERT INTO SSD_ROLE VALUES (8, 'Presentation Display');

--  Stockmarket URLS
INSERT INTO SSD_URL_ACCESS VALUES (1, 'stockmarket.action');
-- Sharetrading URLs
INSERT INTO SSD_URL_ACCESS VALUES (2, 'sharetrading.action');
-- Presentation times URLs
INSERT INTO SSD_URL_ACCESS VALUES (3, 'presentationtimes.action');
-- Companies URLs
INSERT INTO SSD_URL_ACCESS VALUES (4, 'companies.action');
-- Bank URLs
INSERT INTO SSD_URL_ACCESS VALUES (5, 'bank.action');
-- End of day audit URLs
INSERT INTO SSD_URL_ACCESS VALUES (6, 'endofdayshareentry.action');
-- Users URLs
INSERT INTO SSD_URL_ACCESS VALUES (7, 'users.action');
-- Presentation Admin URLs
INSERT INTO SSD_URL_ACCESS VALUES (8, 'companyadmin.action');
-- Start trading URL
INSERT INTO SSD_URL_ACCESS VALUES (9, 'starttrading.action');
-- Share admin URLs
INSERT INTO SSD_URL_ACCESS VALUES (10, 'shareadmin.action');
-- Share admin URLs
INSERT INTO SSD_URL_ACCESS VALUES (11, 'auditlog.action');
-- Company assets URLs
INSERT INTO SSD_URL_ACCESS VALUES (12, 'companyassets.action');
-- User admin URL
INSERT INTO SSD_URL_ACCESS VALUES (13, 'useradmin.action');
INSERT INTO SSD_URL_ACCESS VALUES (14, 'useradd.action');
INSERT INTO SSD_URL_ACCESS VALUES (15, 'changepassword.action');
-- Homepage URL
INSERT INTO SSD_URL_ACCESS VALUES (16, 'home.action');
-- News admin URL
INSERT INTO SSD_URL_ACCESS VALUES (17, 'newsadmin.action');
INSERT INTO SSD_URL_ACCESS VALUES (18, 'newsadd.action');

-- admin gets everything
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,1);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,2);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,3);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,4);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,5);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,6);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,7);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,8);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,9);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,10);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,11);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,13);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,14);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,15);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,16);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,17);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(1,18);

-- other users get specific action
-- Stockmarket Display
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(2,1);
-- Banker
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(3,5);
-- Share Trader
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(4,2);
-- Share Admin
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(5,2);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(5,10);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(5,17);
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(5,18);
-- Student
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(7,12);   
-- Presentation Display
INSERT INTO SSD_ROLE_ACCESS (ROLE_ID, ACCESS_ID) VALUES(8,3);

INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('dividendbackendjob', 'Dividend Payment', 'OHwqPLoZj0UN1+oJYDwLFQ==', 6, TIMESTAMP('2015-06-18 00:00:00'));
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('stockmarketbackendjob', 'Stockmarket Job', 'OHwqPLoZj0UN1+oJYDwLFQ==', 6, TIMESTAMP('2015-06-18 00:00:00'));
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('wagesbackendjob', 'Wages Deduction', 'OHwqPLoZj0UN1+oJYDwLFQ==', 6, TIMESTAMP('2015-06-18 00:00:00'));

INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('bankuser', 'Bank User 1', 'OHwqPLoZj0UN1+oJYDwLFQ==', 3, TIMESTAMP('2015-06-18 00:00:00'));
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('stockmarketuser', 'Stockmarket User 1', 'OHwqPLoZj0UN1+oJYDwLFQ==', 4, TIMESTAMP('2015-06-18 00:00:00'));
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('stockmarketadmin', 'Stockmarket Admin 1', 'OHwqPLoZj0UN1+oJYDwLFQ==', 5, TIMESTAMP('2015-06-18 00:00:00'));
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('shareadmin', 'Share Admin 1', 'OHwqPLoZj0UN1+oJYDwLFQ==', 5, TIMESTAMP('2015-06-18 00:00:00'));
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('presentationdisplay', 'Presentation Display', 'OHwqPLoZj0UN1+oJYDwLFQ==', 8, TIMESTAMP('2015-06-18 00:00:00'));
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('stockmarketdisplay', 'Stockmarket Display', 'OHwqPLoZj0UN1+oJYDwLFQ==', 2, TIMESTAMP('2015-06-18 00:00:00'));

-- BT
-- andrewt - abundant - eigo2O1idSpS9T9kHn+W0A==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('andrewt', 'Andrew', 'eigo2O1idSpS9T9kHn+W0A==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- stuartr - synaptic - 21hm3XfPQa6O3NtISvlwYw==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('stuartr', 'Stuart', '21hm3XfPQa6O3NtISvlwYw==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- neile - notional - ILtQEyJ2Zso3vse2f/APDA==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('neile', 'Neil', 'ILtQEyJ2Zso3vse2f/APDA==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- kevinp - kerosene - YqjKoVsLD/3KwasFii2D1Q==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('kevinp', 'Kevin', 'YqjKoVsLD/3KwasFii2D1Q==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- stevew - sediment - 98okum/qT2ejwIfbnVKvCw==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('stevew', 'Steve', '98okum/qT2ejwIfbnVKvCw==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- adrianh - anaconda - ZtBef8bzaeSzVZgjse4DYA==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('adrianh', 'Adrian', 'ZtBef8bzaeSzVZgjse4DYA==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- philh - panpipes - xzOOm9mc4ZI30MXOGxj9gQ==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('philh', 'Phil', 'xzOOm9mc4ZI30MXOGxj9gQ==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- laurah - longboat - JlAvgR21+vhabOtR6uHK2w==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('laurah', 'Laura', 'JlAvgR21+vhabOtR6uHK2w==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- mikeg - monorail - FEPWiqXD6qhtpgJiU8l+zg==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('mikeg', 'Mike', 'FEPWiqXD6qhtpgJiU8l+zg==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- adamp - airborne - 5qIDxpCOkGK7he2dYEvj6w==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('adamp', 'Adam', '5qIDxpCOkGK7he2dYEvj6w==', 1, TIMESTAMP('2015-06-18 00:00:00'));
-- wilfa - walruses - UOxqhqD2yxxkLnC1L6NmCQ==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, LAST_LOGIN) VALUES ('wilfa', 'Wilf', 'UOxqhqD2yxxkLnC1L6NmCQ==', 1, TIMESTAMP('2015-06-18 00:00:00'));

-- Asterix - adequacy - /epeVXccSsHp0id9s5h5Ww==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('asterix', 'Asterix Team', '/epeVXccSsHp0id9s5h5Ww==', 7, 1, TIMESTAMP('2015-06-18 00:00:00'));
-- Bends - besieges - T6Uo3wEhc7JDnConqWC7sQ==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('bends', 'Bends Team', 'T6Uo3wEhc7JDnConqWC7sQ==', 7, 2, TIMESTAMP('2015-06-18 00:00:00'));
-- Bulbesco - bimester - JJVliXen6vOmYaPUVzgGQg==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('bulbesco', 'Bulbesco Team', 'JJVliXen6vOmYaPUVzgGQg==', 7, 3, TIMESTAMP('2015-06-18 00:00:00'));
-- ChinWag - canoeist - Eve0QTDP1ES9ZXDz9r6prA==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('chinwag', 'Chinwag Team', 'Eve0QTDP1ES9ZXDz9r6prA==', 7, 4, TIMESTAMP('2015-06-18 00:00:00'));
-- Fair Exchange - flagrant - VsB8sfJe6afTJNpcL2Wfig==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('fairexchange', 'Fair Exchange Team', 'VsB8sfJe6afTJNpcL2Wfig==', 7, 5, TIMESTAMP('2015-06-18 00:00:00'));
-- BASA - beanbags - snSRxgVPIKvsNSHyG7yfGg==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('basa', 'Basa Team', 'snSRxgVPIKvsNSHyG7yfGg==', 7, 6, TIMESTAMP('2015-06-18 00:00:00'));
-- Bibi - backspin - EC6cqpYabi5OLc1M14KLfA==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('bibi', 'Bibi Team', 'EC6cqpYabi5OLc1M14KLfA==', 7, 7, TIMESTAMP('2015-06-18 00:00:00'));
-- Canardly - clinical - 3BnY0KP8GPznTl5Edtce+g==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('canardly', 'Canardly Team', '3BnY0KP8GPznTl5Edtce+g==', 7, 8, TIMESTAMP('2015-06-18 00:00:00'));
-- CNX - cropland - wWgzqD75BuJFsQ8agi3Sqw==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('cnx', 'CNX Team', 'wWgzqD75BuJFsQ8agi3Sqw==', 7, 9, TIMESTAMP('2015-06-18 00:00:00'));
-- Fjord - fourfold - mK+T8rclmu9/TzwpgZvdKw==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('fjord', 'Fjord Team', 'mK+T8rclmu9/TzwpgZvdKw==', 7, 10, TIMESTAMP('2015-06-18 00:00:00'));
-- Symphony - spectrum - +Jx8G5BiC5XWBER9o+QyqA==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('symphony', 'Symphony Team', '+Jx8G5BiC5XWBER9o+QyqA==', 7, 11, TIMESTAMP('2015-06-18 00:00:00'));
-- Go Karts - gurgling - nVN1CwztrB4YPxuGz5nx5g==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('gokarts', 'Gokarts Team', 'nVN1CwztrB4YPxuGz5nx5g==', 7, 12, TIMESTAMP('2015-06-18 00:00:00'));
-- Lemon - laserjet - 54TwZo+MN8wDecrTUtG+yA==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('lemon', 'Lemon Team', '54TwZo+MN8wDecrTUtG+yA==', 7, 13, TIMESTAMP('2015-06-18 00:00:00'));
-- Mogycar - methanol - Kh1TStsS6TyR/7yIMfprDg==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('mogycar', 'Mogycar Team', 'Kh1TStsS6TyR/7yIMfprDg==', 7, 14, TIMESTAMP('2015-06-18 00:00:00'));
-- Porish - pilgrims - oeHP17HRJwDFjecESLA6LQ==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('porish', 'Porish Team', 'oeHP17HRJwDFjecESLA6LQ==', 7, 15, TIMESTAMP('2015-06-18 00:00:00'));
-- Ganucar - gigavolt - V6Exe0b9bTIyRCwhMHMk8w==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('ganucar', 'Ganucar Team', 'V6Exe0b9bTIyRCwhMHMk8w==', 7, 16, TIMESTAMP('2015-06-18 00:00:00'));
-- Goundai - guidable - Bjo3GovGylZPOJsyT8jVrg==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('goundai', 'Goundai Team', 'Bjo3GovGylZPOJsyT8jVrg==', 7, 17, TIMESTAMP('2015-06-18 00:00:00'));
-- Lovol - lightbox - P9KlEXHoEntfqk+4hvETNQ==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('lovol', 'Lovol Team', 'P9KlEXHoEntfqk+4hvETNQ==', 7, 18, TIMESTAMP('2015-06-18 00:00:00'));
-- Moon Buggy - mailroom - HFbst6FvZubVPhjkC6S5tQ==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('moonbuggy', 'Moonbuggy Team', 'HFbst6FvZubVPhjkC6S5tQ==', 7, 19, TIMESTAMP('2015-06-18 00:00:00'));
-- Reno - rocketed - N3GZsdS2sO/UrVs1HoIbDg==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('reno', 'Reno Team', 'N3GZsdS2sO/UrVs1HoIbDg==', 7, 20, TIMESTAMP('2015-06-18 00:00:00'));
-- Uraboat - upwardly - rlWKZHtXi4EXlA2vRDqAmA==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('uraboat', 'Uraboat Team', 'rlWKZHtXi4EXlA2vRDqAmA==', 7, 21, TIMESTAMP('2015-06-18 00:00:00'));
-- Foxball - foretold - iI9NgvJHvEwUKdXRp0H3jw==
INSERT INTO SSD_USER (USERNAME, FRIENDLY_NAME, PASSWORD, ROLE_ID, COMPANY_ID, LAST_LOGIN) VALUES ('foxball', 'Foxball Team', 'iI9NgvJHvEwUKdXRp0H3jw==', 7, 22, TIMESTAMP('2015-06-18 00:00:00'));

INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (1, 'Cash deposit');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (2, 'Cash withdrawal');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (3, 'Shares bought');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (4, 'Shares sold');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (5, 'Base price changed');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (6, 'Share price fluctuated');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (7, 'PR Added');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (8, 'PR Removed');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (9, 'Company details updated');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (10, 'Company shares updated');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (11, 'Presentation and dispute values changed');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (12, 'Company suspended');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (13, 'Company unsuspended');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (14, 'iDot completed');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (15, 'Trading suspended');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (16, 'Trading started');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (17, 'Start of day');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (18, 'End of day');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (19, 'Car built');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (20, 'Share boom');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (21, 'Share bust');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (22, 'Presentation bonus');
INSERT INTO SSD_AUDIT_LOG_ACTION VALUES (23, 'PIN error');

INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (1, 1, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (2, 2, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (3, 3, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (4, 4, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (5, 5, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (6, 6, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (7, 7, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (8, 8, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (9, 9, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (10, 10, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (11, 11, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (12, 12, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (13, 13, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (14, 14, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (15, 15, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (16, 16, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (17, 17, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (18, 18, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (19, 19, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (20, 20, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (21, 21, 50);
INSERT INTO SSD_COMPANY_SHARE_MAP VALUES (22, 22, 50);

INSERT INTO SSD_NEWS_TYPE VALUES (1, "Today");
INSERT INTO SSD_NEWS_TYPE VALUES (2, "Stockmarket");
INSERT INTO SSD_NEWS_TYPE VALUES (3, "Next Event");

INSERT INTO SSD_MACHINE_NETWORK_DETAILS VALUES ('68-F7-28-0A-BD-B4', 'Stuart''s Laptop - Wired');
INSERT INTO SSD_MACHINE_NETWORK_DETAILS VALUES ('00-50-56-C0-00-08', 'Stuart''s Laptop - Wired');
INSERT INTO SSD_MACHINE_NETWORK_DETAILS VALUES ('E8-B1-FC-16-F9-6D', 'Stuart''s Laptop - Wireless');