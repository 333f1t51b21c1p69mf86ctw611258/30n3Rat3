DROP PROCEDURE VNP_DATA.PREPARE_RERATE_DATA;

CREATE OR REPLACE PROCEDURE VNP_DATA.PREPARE_RERATE_DATA 
as
        d_current_time Date;
        cursor c_subs_rerate is
        SELECT T3.SUBSCRIBER_NO
          FROM VNP_COMMON.SUBS_OFFER_MAP t1,
               VNP_COMMON.PRODUCT_OFFER t2,
               VNP_COMMON.subscriber t3
         WHERE     t1.from_date >= TRUNC (SYSDATE, 'MM')
               AND t2.RESELLER_VERSION_ID =
                      (SELECT MAX (RESELLER_VERSION_ID)
                         FROM VNP_COMMON.RESELLER_VERSION)
               AND t2.unbill = '1'
               AND t1.PRODUCT_OFFER_ID = T2.OFFER_ID
               AND t1.SUBSCRIBER_ID = t3.SUBSCRIBER_ID;
              
         rec_subs_rerate c_subs_rerate%rowtype;
         
         cursor c_subs_rate_time (p_sub_no varchar2) is
         select max(last_rate_date) max_time 
          from subs_rerate_history where SUBSCRIBER_NO=p_sub_no;
          
         rec_subs_rate_time c_subs_rate_time%rowtype;
         v_subscriber_no varchar2(31);
         last_rate_time     date;
         n_rerate_seq number;
         d_first_day date;
BEGIN
        
        SELECT SYSDATE INTO d_current_time FROM DUAL;
        
        SELECT trunc(sysdate, 'MM') INTO d_first_day from dual;
        
        
        /* Formatted on 12/30/2014 8:21:32 AM (QP5 v5.252.13127.32867) */
        
        open  c_subs_rerate;
        loop
            fetch c_subs_rerate into rec_subs_rerate;
            exit when c_subs_rerate%NOTFOUND;
            
            v_subscriber_no:=rec_subs_rerate.SUBSCRIBER_NO;
                        
            open c_subs_rate_time(v_subscriber_no);
            fetch c_subs_rate_time into rec_subs_rate_time;
            
            last_rate_time := d_first_day;
            
            if c_subs_rate_time%FOUND then
                
                last_rate_time :=rec_subs_rate_time.max_time;
                if last_rate_time  is null then
                    last_rate_time:=d_first_day;
                end if;
                
            else
               last_rate_time := d_first_day;
            end if;
            
            select subs_rerate_his_seq.nextval into n_rerate_seq from dual;  
            
            insert into subs_rerate_history values(n_rerate_seq,v_subscriber_no, 'N', d_current_time, sysdate );
            commit;   
            
            close  c_subs_rate_time;         
                        
            INSERT INTO VNP_DATA.HOT_RATED_CDR_DEV
                SELECT *
                  FROM VNP_DATA.HOT_RATED_CDR
                 WHERE     A_NUMBER =v_subscriber_no
                    AND cdr_start_time >=
                      last_rate_time
               AND cdr_start_time < d_current_time;
            
            update subs_rerate_history set STATUS ='S' where Rate_his_id=n_rerate_seq;
            
            commit;
            
        end loop;
        commit;
        close c_subs_rerate;

END PREPARE_RERATE_DATA;
/
