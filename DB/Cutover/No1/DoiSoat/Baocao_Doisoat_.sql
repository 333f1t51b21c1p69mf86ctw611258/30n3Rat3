--I. BAO CAO DATA
--Số thuê bao, Tổng số phiên truy nhập, Tổng dung lương truy nhập.
      select * from vnp_data.hot_rated_cdr where cdr_type=5;
      select A_number,count(*), sum(TOTAL_USAGE) from vnp_data.HOT_RATED_CDR where cdr_type=5 group by a_number;
  -- So thue bao cu the
      --select * from vnp_data.HOT_RATED_CDR where cdr_type=5 and a_number=841247494428;
      select a_number,count(*),sum(Total_usage) from vnp_data.hot_rated_cdr where cdr_type=5 and a_number=841247494428;
  -- Tinh tong cho 200 thue bao
   --select count* from vnp_data.HOT_RATED_CDR;
   select a_number, count(*), sum(Total_usage) from HOT_RATED_CDR where cdr_type=5 and a_number in 
(841233422566,841234000357,84912008988,84912009696,84912012168,
84912028838,84912079999,84912111303,84912111999,84912161679,
84912200000,84912203399,84912216066,84912222707,84912225491,
84912268989,84912342899,84912353869,84912364299,84912371975,
84912402888,84912421577,84912442621,84912560592,84912594444,
84912600026,84912608899,84912674646,84912688699,84912718181,
84912741961,84912760721,84912774722,84912813818,84912827782,
84912905882,84912985588,84912989777,84912999524,84913000699,
84913033777,84913055678,84913072288,84913083355,84913083888,
84913121399,84913203250,84913266778,84913325999,84913392088,
84913393776,84913403132,84913405999,84913407999,84913413234,
84913421642,84913422727,84913443888,84913473374,84913477119,
84913484584,84913492924,84913512678,84913529009,84913534199,
84913534292,84913666624,84913680088,84913719009,84913742474,
84913745789,84913759549,84913866698,84913867786,84913898494,
84913922293,84913926626,84913946666,84913999699,84914000060,
84914000123,84914000200,84914000264,84914000499,84914039039,
84914040114,84914046046,84914046688,84914049043,84914049669,
84914080646,84914082266,84914111757,84914112622,84914112939,
84914132232,84914171969,84914177288,84914196872,84914212888,
84914242345,84914411155,84914518338,84914645254,84914699515,
84914781345,84914866996,84914899898,84914900373,84915001579,
84915095008,84915129999,84915489499,84915555396,84915635633,
84915678951,84915736666,84915822986,84915968899,84916260986,
84916265123,84916308088,84916441125,84916499888,84916563605,
84916680080,84916729898,84916788668,84916996888,84917052262,
84917062222,84917286789,84917565656,84917656333,84917753999,
84917888844,84917925999,84917979898,84917987899,84918009595,
84918017979,84918033055,84918042029,84918068989,84918073307,
84918079999,84918088008,84918106768,84918151064,84918283382,
84918293131,84918305131,84918306397,84918333305,84918339788,
84918341341,84918346869,84918355888,84918401234,84918589990,
84918603844,84918731864,84918739888,84918766687,84918777379,
84918844834,84918874743,84918900088,84918994545,84919000089,
84919037037,84919100102,84919338898,84919388288,84919558668,
84919696569,84919696967,84919778164,84919795448,84919898789,
84919978255,84942279388,84942999924,84943606818,84943975788,
84944067607,84944319888,84944321598,84945099998,84945158939,
84945570112,84946000358,84946000888,84946565289,84947758758,
84948002772,84948776789,84949268899,84949302829,84949555567)
 group by A_number;

--II. BAO CAO CUOC: Tổng hợp /Chi tiết (theo thuê bao)
--Thời gian bắt đầu, thời gian kết thúc, hướng cuộc gọi, tổng số cuộc, tổng lưu lượng.
  
  -- 1. Tong hop theo huong cuoc goi (SMS, CALL, DATA)
      Select * from vnp_data.HOT_RATED_CDR;
      Select min(cdr_start_time), max(cdr_start_time),count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE B_zone='VINAPHONE' and cdr_type=1;
      
      --Noi mang Vinaphone
       --List theo A_number
      Select A_number, min(cdr_start_time), max(cdr_start_time),count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE B_zone='VINAPHONE' group by A_number;
       --All
      Select min(cdr_start_time), max(cdr_start_time),count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE B_zone='VINAPHONE';

     --Ngoai mang Vinaphone (trong nuoc)
      --List theo A_number
      Select A_number, min(cdr_start_time), max(cdr_start_time), count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE B_zone !='VINAPHONE' and NW_Group !='QTE' group by A_number;
      --All
      Select min(cdr_start_time), max(cdr_start_time),count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE B_zone !='VINAPHONE' and NW_Group !='QTE';
    
     --Roaming QTE 
      --List theo A_number
      Select A_number, min(cdr_start_time), max(cdr_start_time), count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE NW_Group ='QTE'  group by A_number;
       --All
      Select min(cdr_start_time), max(cdr_start_time),count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE NW_Group ='QTE' ;

  --  2.Tong hop cho 200 thue bao trong danh sach cua VNP, điền thêm số thuê bao vào  in(...)
      Select A_number, min(cdr_start_time), max(cdr_start_time), count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE B_zone='VINAPHONE' and A_number in (... ) group by A_number;

--III. BÁO CÁO SỐ LƯỢNG  FILE ORP: 
--Nguồn, Thời gian bắt đầu, Thời gian kết thúc, Số lượng file, Sequence bắt đầu, Sequence kết thúc, Tổng số bản ghi (Tong dung luong).
      --select * from VNP_COMMON.ORP_SFTP_FILE;
      select slu, min(created_time), max (CREATED_TIME), count(*), min(seq), max(SEQ), sum(FILE_SIZE) from VNP_COMMON.ORP_SFTP_FILE group by slu;
      --select slu, sum(FILE_SIZE) from VNP_COMMON.ORP_SFTP_FILE group by slu;
      
--VI. Báo cáo IR. Báo cáo lưu lượng thoại roaming QTE.
--Số thuê bao, số lượng cuộc gọi, tổng lưu lượng.
       Select A_number, count(*), sum(total_usage) from vnp_data.HOT_RATED_CDR WHERE NW_Group ='QTE' and cdr_type=1  and A_number in (... ) group by A_number;

      
      
      
      
      