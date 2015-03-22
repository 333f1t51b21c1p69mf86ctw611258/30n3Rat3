/* Formatted on 17/3/15 10:35:10 (QP5 v5.240.12305.39476) */
CREATE TABLE config
(
   cfg_group         VARCHAR2 (255),
   cfg_name          VARCHAR2 (255),
   cfg_value         VARCHAR2 (255),
   cfg_description   VARCHAR2 (1023)
);

SELECT * FROM config;

TRUNCATE TABLE config;

INSERT INTO CONFIG
     VALUES ('COOL_AGGREGATED_CDR',
             'AGGR_MONTH',
             '1503',
             '');

COMMIT;