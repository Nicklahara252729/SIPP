/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.6.25 : Database - db_sipp
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `sipp_akses` */

DROP TABLE IF EXISTS `sipp_akses`;

CREATE TABLE `sipp_akses` (
  `akses_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_username` varchar(30) NOT NULL,
  `pasar_id` int(2) NOT NULL,
  PRIMARY KEY (`akses_id`),
  KEY `user_username` (`user_username`),
  KEY `pasar_id` (`pasar_id`),
  CONSTRAINT `sipp_akses_ibfk_1` FOREIGN KEY (`user_username`) REFERENCES `sipp_users` (`user_username`),
  CONSTRAINT `sipp_akses_ibfk_2` FOREIGN KEY (`pasar_id`) REFERENCES `sipp_pasar` (`pasar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_akses` */

insert  into `sipp_akses`(`akses_id`,`user_username`,`pasar_id`) values (1,'admin',2),(2,'admin',1),(3,'eet',2),(4,'haris',1);

/*Table structure for table `sipp_baliknama` */

DROP TABLE IF EXISTS `sipp_baliknama`;

CREATE TABLE `sipp_baliknama` (
  `baliknama_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID Balik Nama',
  `dasar_id` int(10) NOT NULL COMMENT 'ID Pendasaran',
  `pedagang_id` int(10) NOT NULL COMMENT 'ID Pedagang Baru',
  `jenis_id` int(2) NOT NULL COMMENT 'ID Jenis Dagang',
  `pasar_id` int(2) NOT NULL COMMENT 'ID Pasar',
  `tempat_id` int(2) NOT NULL COMMENT 'ID Tempat',
  `baliknama_no` varchar(19) NOT NULL COMMENT 'No. Balik Nama',
  `baliknama_tgl` date NOT NULL COMMENT 'Tgl. Balik Nama',
  `baliknama_npwrd` varchar(13) NOT NULL COMMENT 'NPWRD Pedagang Baru',
  `user_username` varchar(30) NOT NULL COMMENT 'Username',
  `baliknama_date_update` date NOT NULL,
  `baliknama_time_update` time NOT NULL,
  PRIMARY KEY (`baliknama_id`),
  KEY `baliknama_tgl` (`baliknama_tgl`),
  KEY `dasar_id` (`dasar_id`),
  KEY `pedagang_id` (`pedagang_id`),
  KEY `jenis_id` (`jenis_id`),
  KEY `baliknama_no` (`baliknama_no`),
  KEY `tempat_id` (`tempat_id`),
  CONSTRAINT `sipp_baliknama_ibfk_1` FOREIGN KEY (`dasar_id`) REFERENCES `sipp_dasar` (`dasar_id`),
  CONSTRAINT `sipp_baliknama_ibfk_2` FOREIGN KEY (`pedagang_id`) REFERENCES `sipp_pedagang` (`pedagang_id`),
  CONSTRAINT `sipp_baliknama_ibfk_3` FOREIGN KEY (`jenis_id`) REFERENCES `sipp_jenis` (`jenis_id`),
  CONSTRAINT `sipp_baliknama_ibfk_4` FOREIGN KEY (`tempat_id`) REFERENCES `sipp_tempat` (`tempat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_baliknama` */

insert  into `sipp_baliknama`(`baliknama_id`,`dasar_id`,`pedagang_id`,`jenis_id`,`pasar_id`,`tempat_id`,`baliknama_no`,`baliknama_tgl`,`baliknama_npwrd`,`user_username`,`baliknama_date_update`,`baliknama_time_update`) values (1,5,2,8,2,3,'511.2/00001/BN/2016','2016-09-13','0208201600006','admin','2016-09-13','17:17:41'),(2,7,2,5,1,2,'511.2/00002/BN/2016','2016-09-14','0105201600008','admin','2016-09-14','11:47:09');

/*Table structure for table `sipp_bentuk` */

DROP TABLE IF EXISTS `sipp_bentuk`;

CREATE TABLE `sipp_bentuk` (
  `bentuk_id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'ID Type',
  `bentuk_nama` varchar(50) NOT NULL COMMENT 'Type Bangunan',
  `bentuk_date_update` date NOT NULL,
  `bentuk_time_update` time NOT NULL,
  PRIMARY KEY (`bentuk_id`),
  KEY `type_name` (`bentuk_nama`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_bentuk` */

insert  into `sipp_bentuk`(`bentuk_id`,`bentuk_nama`,`bentuk_date_update`,`bentuk_time_update`) values (1,'PERMANEN','2016-09-08','11:31:18'),(2,'SEMI PERMANEN','2016-09-08','13:07:00'),(3,'TANPA BANGUNAN','2016-09-08','11:30:52');

/*Table structure for table `sipp_dasar` */

DROP TABLE IF EXISTS `sipp_dasar`;

CREATE TABLE `sipp_dasar` (
  `dasar_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID NPWRD',
  `dasar_no` varchar(35) NOT NULL COMMENT 'No. Surat',
  `dasar_no_lama` varchar(35) DEFAULT NULL COMMENT 'No. Surat Lama jika Perpanjangan',
  `dasar_npwrd` varchar(13) NOT NULL COMMENT 'No. NPWRD',
  `pedagang_id` int(10) NOT NULL COMMENT 'ID Pedagang',
  `pasar_id` int(2) NOT NULL COMMENT 'ID Pasar',
  `jenis_id` int(2) NOT NULL COMMENT 'ID Jenis Dagang',
  `tempat_id` int(2) NOT NULL COMMENT 'ID Tempat',
  `dasar_status` enum('Baru','Perpanjangan','Balik Nama') NOT NULL DEFAULT 'Baru' COMMENT 'Status Surat',
  `dasar_tgl_surat` date NOT NULL,
  `dasar_blok` varchar(10) NOT NULL COMMENT 'Blok Tempat',
  `dasar_nomor` varchar(5) NOT NULL COMMENT 'Nomor Tempat',
  `dasar_panjang` int(5) NOT NULL COMMENT 'Panjang Ukuran',
  `dasar_lebar` int(5) NOT NULL COMMENT 'Lebar Ukuran',
  `dasar_luas` int(5) NOT NULL COMMENT 'Luas Tempat',
  `dasar_dari` date NOT NULL COMMENT 'Dari Tanggal',
  `dasar_sampai` date NOT NULL COMMENT 'Sampai Tanggal',
  `dasar_tgl_print` date DEFAULT NULL COMMENT 'Tgl Cetak Surat',
  `dasar_st_print` int(1) DEFAULT '0' COMMENT '0 = Belum Print, 1 = Sudah Print',
  `dasar_data` int(1) DEFAULT '0' COMMENT '0 = Masih Berlaku, 1 = Tidak Belaku',
  `user_username` varchar(30) NOT NULL COMMENT 'Username',
  `dasar_date_update` date NOT NULL,
  `dasar_time_update` time NOT NULL,
  PRIMARY KEY (`dasar_id`,`dasar_no`,`dasar_npwrd`),
  KEY `dasar_no` (`dasar_no`),
  KEY `dasar_npwrd` (`dasar_npwrd`),
  KEY `pedagang_id` (`pedagang_id`),
  KEY `pasar_id` (`pasar_id`),
  KEY `jenis_id` (`jenis_id`),
  KEY `dasar_tgl_surat` (`dasar_tgl_surat`),
  KEY `tempat_id` (`tempat_id`),
  CONSTRAINT `sipp_dasar_ibfk_1` FOREIGN KEY (`pedagang_id`) REFERENCES `sipp_pedagang` (`pedagang_id`),
  CONSTRAINT `sipp_dasar_ibfk_2` FOREIGN KEY (`pasar_id`) REFERENCES `sipp_pasar` (`pasar_id`),
  CONSTRAINT `sipp_dasar_ibfk_3` FOREIGN KEY (`jenis_id`) REFERENCES `sipp_jenis` (`jenis_id`),
  CONSTRAINT `sipp_dasar_ibfk_4` FOREIGN KEY (`tempat_id`) REFERENCES `sipp_tempat` (`tempat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_dasar` */

insert  into `sipp_dasar`(`dasar_id`,`dasar_no`,`dasar_no_lama`,`dasar_npwrd`,`pedagang_id`,`pasar_id`,`jenis_id`,`tempat_id`,`dasar_status`,`dasar_tgl_surat`,`dasar_blok`,`dasar_nomor`,`dasar_panjang`,`dasar_lebar`,`dasar_luas`,`dasar_dari`,`dasar_sampai`,`dasar_tgl_print`,`dasar_st_print`,`dasar_data`,`user_username`,`dasar_date_update`,`dasar_time_update`) values (1,'511.2/00001/50/BTG/2016',NULL,'0202201600001',1,2,2,3,'Baru','2016-09-12','C','50',4,4,16,'2016-09-12','2017-09-12','2016-09-12',1,1,'admin','2016-09-12','16:20:33'),(2,'511.2/00002/100/BTG/2016',NULL,'0201201600002',2,2,1,2,'Baru','2016-09-12','H','100',2,2,4,'2016-09-12','2017-09-12','2016-09-12',1,1,'admin','2016-09-12','16:27:09'),(3,'511.2/00003/50/BTG/2016','511.2/00001/50/BTG/2016','0202201600001',1,2,2,3,'Perpanjangan','2016-09-12','C','50',4,4,16,'2017-09-12','2018-09-12','2016-09-12',1,1,'admin','2016-09-12','19:53:11'),(4,'511.2/00004/100/BTG/2016','511.2/00002/100/BTG/2016','0201201600002',2,2,1,2,'Perpanjangan','2016-09-12','H','100',2,2,4,'2017-09-12','2018-09-12','2016-09-14',1,0,'eet','2016-09-14','11:42:16'),(5,'511.2/00005/50/BTG/2016','511.2/00003/50/BTG/2016','0202201600001',1,2,2,3,'Perpanjangan','2016-09-12','C','50',4,4,16,'2017-09-12','2018-09-12',NULL,0,1,'admin','2016-09-13','17:17:42'),(6,'511.2/00006/50/BTG/2016','511.2/00004/100/BTG/2016','0208201600006',2,2,8,3,'Balik Nama','2016-09-13','C','50',4,4,16,'2016-09-13','2017-09-13','2016-09-14',1,0,'eet','2016-09-14','11:42:20'),(7,'511.2/00007/250/KLWN/2016',NULL,'0105201600007',3,1,5,2,'Baru','2016-09-14','G','250',3,3,9,'2016-09-14','2017-09-14','2016-09-14',1,1,'admin','2016-09-14','11:47:09'),(8,'511.2/00008/250/KLWN/2016','511.2/00007/250/KLWN/2016','0105201600008',2,1,5,2,'Balik Nama','2016-09-14','G','250',3,3,9,'2016-10-01','2017-10-01',NULL,0,0,'admin','2016-09-14','11:48:11');

/*Table structure for table `sipp_desa` */

DROP TABLE IF EXISTS `sipp_desa`;

CREATE TABLE `sipp_desa` (
  `desa_id` char(10) NOT NULL,
  `kecamatan_id` char(7) NOT NULL,
  `desa_nama` varchar(255) NOT NULL,
  PRIMARY KEY (`desa_id`),
  KEY `desa_nama` (`desa_nama`),
  KEY `kecamatan_id` (`kecamatan_id`),
  CONSTRAINT `sipp_desa_ibfk_1` FOREIGN KEY (`kecamatan_id`) REFERENCES `sipp_kecamatan` (`kecamatan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sipp_desa` */


/*Table structure for table `sipp_jenis` */

DROP TABLE IF EXISTS `sipp_jenis`;

CREATE TABLE `sipp_jenis` (
  `jenis_id` int(2) NOT NULL AUTO_INCREMENT,
  `jenis_kode` varchar(2) NOT NULL,
  `jenis_nama` varchar(50) NOT NULL,
  `jenis_date_update` date NOT NULL,
  `jenis_time_update` time NOT NULL,
  PRIMARY KEY (`jenis_id`,`jenis_kode`),
  KEY `jenis_nama` (`jenis_nama`),
  KEY `jenis_kode` (`jenis_kode`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_jenis` */

insert  into `sipp_jenis`(`jenis_id`,`jenis_kode`,`jenis_nama`,`jenis_date_update`,`jenis_time_update`) values (1,'01','MAKANAN & MINUMAN','2016-09-11','16:43:15'),(2,'02','KONVEKSI KAIN','2016-09-11','16:59:03'),(3,'03','SEPATU, TAS DAN PERALATAN SEKOLAH','2016-09-11','16:59:44'),(4,'04','SAYURAN','2016-09-11','18:35:06'),(5,'05','DAGING MENTAH','2016-09-11','18:35:21'),(6,'06','DAGING OLAHAN','2016-09-11','18:35:27'),(7,'07','MAINAN ANAK-ANAK','2016-09-11','18:35:44'),(8,'08','SEMBAKO','2016-09-11','18:35:56'),(9,'09','PERABOT RUMAH TANGGA','2016-09-11','18:36:13'),(10,'10','SEPEDA MOTOR','2016-09-11','18:36:22'),(11,'11','MOBIL','2016-09-11','18:36:31');

/*Table structure for table `sipp_kabupaten` */

DROP TABLE IF EXISTS `sipp_kabupaten`;

CREATE TABLE `sipp_kabupaten` (
  `kabupaten_id` char(4) NOT NULL,
  `provinsi_id` char(2) NOT NULL,
  `kabupaten_nama` varchar(255) NOT NULL,
  PRIMARY KEY (`kabupaten_id`),
  KEY `kabupaten_nama` (`kabupaten_nama`),
  KEY `provinsi_id` (`provinsi_id`),
  CONSTRAINT `sipp_kabupaten_ibfk_1` FOREIGN KEY (`provinsi_id`) REFERENCES `sipp_provinsi` (`provinsi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sipp_kabupaten` */

insert  into `sipp_kabupaten`(`kabupaten_id`,`provinsi_id`,`kabupaten_nama`) values ('1101','11','KABUPATEN SIMEULUE'),('1102','11','KABUPATEN ACEH SINGKIL'),('1103','11','KABUPATEN ACEH SELATAN'),('1104','11','KABUPATEN ACEH TENGGARA'),('1105','11','KABUPATEN ACEH TIMUR'),('1106','11','KABUPATEN ACEH TENGAH'),('1107','11','KABUPATEN ACEH BARAT'),('1108','11','KABUPATEN ACEH BESAR'),('1109','11','KABUPATEN PIDIE'),('1110','11','KABUPATEN BIREUEN'),('1111','11','KABUPATEN ACEH UTARA'),('1112','11','KABUPATEN ACEH BARAT DAYA'),('1113','11','KABUPATEN GAYO LUES'),('1114','11','KABUPATEN ACEH TAMIANG'),('1115','11','KABUPATEN NAGAN RAYA'),('1116','11','KABUPATEN ACEH JAYA'),('1117','11','KABUPATEN BENER MERIAH'),('1118','11','KABUPATEN PIDIE JAYA'),('1171','11','KOTA BANDA ACEH'),('1172','11','KOTA SABANG'),('1173','11','KOTA LANGSA'),('1174','11','KOTA LHOKSEUMAWE'),('1175','11','KOTA SUBULUSSALAM'),('1201','12','KABUPATEN NIAS'),('1202','12','KABUPATEN MANDAILING NATAL'),('1203','12','KABUPATEN TAPANULI SELATAN'),('1204','12','KABUPATEN TAPANULI TENGAH'),('1205','12','KABUPATEN TAPANULI UTARA'),('1206','12','KABUPATEN TOBA SAMOSIR'),('1207','12','KABUPATEN LABUHAN BATU'),('1208','12','KABUPATEN ASAHAN'),('1209','12','KABUPATEN SIMALUNGUN'),('1210','12','KABUPATEN DAIRI'),('1211','12','KABUPATEN KARO'),('1212','12','KABUPATEN DELI SERDANG'),('1213','12','KABUPATEN LANGKAT'),('1214','12','KABUPATEN NIAS SELATAN'),('1215','12','KABUPATEN HUMBANG HASUNDUTAN'),('1216','12','KABUPATEN PAKPAK BHARAT'),('1217','12','KABUPATEN SAMOSIR'),('1218','12','KABUPATEN SERDANG BEDAGAI'),('1219','12','KABUPATEN BATU BARA'),('1220','12','KABUPATEN PADANG LAWAS UTARA'),('1221','12','KABUPATEN PADANG LAWAS'),('1222','12','KABUPATEN LABUHAN BATU SELATAN'),('1223','12','KABUPATEN LABUHAN BATU UTARA'),('1224','12','KABUPATEN NIAS UTARA'),('1225','12','KABUPATEN NIAS BARAT'),('1271','12','KOTA SIBOLGA'),('1272','12','KOTA TANJUNG BALAI'),('1273','12','KOTA PEMATANG SIANTAR'),('1274','12','KOTA TEBING TINGGI'),('1275','12','KOTA MEDAN'),('1276','12','KOTA BINJAI'),('1277','12','KOTA PADANGSIDIMPUAN'),('1278','12','KOTA GUNUNGSITOLI'),('1301','13','KABUPATEN KEPULAUAN MENTAWAI'),('1302','13','KABUPATEN PESISIR SELATAN'),('1303','13','KABUPATEN SOLOK'),('1304','13','KABUPATEN SIJUNJUNG'),('1305','13','KABUPATEN TANAH DATAR'),('1306','13','KABUPATEN PADANG PARIAMAN'),('1307','13','KABUPATEN AGAM'),('1308','13','KABUPATEN LIMA PULUH KOTA'),('1309','13','KABUPATEN PASAMAN'),('1310','13','KABUPATEN SOLOK SELATAN'),('1311','13','KABUPATEN DHARMASRAYA'),('1312','13','KABUPATEN PASAMAN BARAT'),('1371','13','KOTA PADANG'),('1372','13','KOTA SOLOK'),('1373','13','KOTA SAWAH LUNTO'),('1374','13','KOTA PADANG PANJANG'),('1375','13','KOTA BUKITTINGGI'),('1376','13','KOTA PAYAKUMBUH'),('1377','13','KOTA PARIAMAN'),('1401','14','KABUPATEN KUANTAN SINGINGI'),('1402','14','KABUPATEN INDRAGIRI HULU'),('1403','14','KABUPATEN INDRAGIRI HILIR'),('1404','14','KABUPATEN PELALAWAN'),('1405','14','KABUPATEN S I A K'),('1406','14','KABUPATEN KAMPAR'),('1407','14','KABUPATEN ROKAN HULU'),('1408','14','KABUPATEN BENGKALIS'),('1409','14','KABUPATEN ROKAN HILIR'),('1410','14','KABUPATEN KEPULAUAN MERANTI'),('1471','14','KOTA PEKANBARU'),('1473','14','KOTA D U M A I'),('1501','15','KABUPATEN KERINCI'),('1502','15','KABUPATEN MERANGIN'),('1503','15','KABUPATEN SAROLANGUN'),('1504','15','KABUPATEN BATANG HARI'),('1505','15','KABUPATEN MUARO JAMBI'),('1506','15','KABUPATEN TANJUNG JABUNG TIMUR'),('1507','15','KABUPATEN TANJUNG JABUNG BARAT'),('1508','15','KABUPATEN TEBO'),('1509','15','KABUPATEN BUNGO'),('1571','15','KOTA JAMBI'),('1572','15','KOTA SUNGAI PENUH'),('1601','16','KABUPATEN OGAN KOMERING ULU'),('1602','16','KABUPATEN OGAN KOMERING ILIR'),('1603','16','KABUPATEN MUARA ENIM'),('1604','16','KABUPATEN LAHAT'),('1605','16','KABUPATEN MUSI RAWAS'),('1606','16','KABUPATEN MUSI BANYUASIN'),('1607','16','KABUPATEN BANYU ASIN'),('1608','16','KABUPATEN OGAN KOMERING ULU SELATAN'),('1609','16','KABUPATEN OGAN KOMERING ULU TIMUR'),('1610','16','KABUPATEN OGAN ILIR'),('1611','16','KABUPATEN EMPAT LAWANG'),('1612','16','KABUPATEN PENUKAL ABAB LEMATANG ILIR'),('1613','16','KABUPATEN MUSI RAWAS UTARA'),('1671','16','KOTA PALEMBANG'),('1672','16','KOTA PRABUMULIH'),('1673','16','KOTA PAGAR ALAM'),('1674','16','KOTA LUBUKLINGGAU'),('1701','17','KABUPATEN BENGKULU SELATAN'),('1702','17','KABUPATEN REJANG LEBONG'),('1703','17','KABUPATEN BENGKULU UTARA'),('1704','17','KABUPATEN KAUR'),('1705','17','KABUPATEN SELUMA'),('1706','17','KABUPATEN MUKOMUKO'),('1707','17','KABUPATEN LEBONG'),('1708','17','KABUPATEN KEPAHIANG'),('1709','17','KABUPATEN BENGKULU TENGAH'),('1771','17','KOTA BENGKULU'),('1801','18','KABUPATEN LAMPUNG BARAT'),('1802','18','KABUPATEN TANGGAMUS'),('1803','18','KABUPATEN LAMPUNG SELATAN'),('1804','18','KABUPATEN LAMPUNG TIMUR'),('1805','18','KABUPATEN LAMPUNG TENGAH'),('1806','18','KABUPATEN LAMPUNG UTARA'),('1807','18','KABUPATEN WAY KANAN'),('1808','18','KABUPATEN TULANGBAWANG'),('1809','18','KABUPATEN PESAWARAN'),('1810','18','KABUPATEN PRINGSEWU'),('1811','18','KABUPATEN MESUJI'),('1812','18','KABUPATEN TULANG BAWANG BARAT'),('1813','18','KABUPATEN PESISIR BARAT'),('1871','18','KOTA BANDAR LAMPUNG'),('1872','18','KOTA METRO'),('1901','19','KABUPATEN BANGKA'),('1902','19','KABUPATEN BELITUNG'),('1903','19','KABUPATEN BANGKA BARAT'),('1904','19','KABUPATEN BANGKA TENGAH'),('1905','19','KABUPATEN BANGKA SELATAN'),('1906','19','KABUPATEN BELITUNG TIMUR'),('1971','19','KOTA PANGKAL PINANG'),('2101','21','KABUPATEN KARIMUN'),('2102','21','KABUPATEN BINTAN'),('2103','21','KABUPATEN NATUNA'),('2104','21','KABUPATEN LINGGA'),('2105','21','KABUPATEN KEPULAUAN ANAMBAS'),('2171','21','KOTA B A T A M'),('2172','21','KOTA TANJUNG PINANG'),('3101','31','KABUPATEN KEPULAUAN SERIBU'),('3171','31','KOTA JAKARTA SELATAN'),('3172','31','KOTA JAKARTA TIMUR'),('3173','31','KOTA JAKARTA PUSAT'),('3174','31','KOTA JAKARTA BARAT'),('3175','31','KOTA JAKARTA UTARA'),('3201','32','KABUPATEN BOGOR'),('3202','32','KABUPATEN SUKABUMI'),('3203','32','KABUPATEN CIANJUR'),('3204','32','KABUPATEN BANDUNG'),('3205','32','KABUPATEN GARUT'),('3206','32','KABUPATEN TASIKMALAYA'),('3207','32','KABUPATEN CIAMIS'),('3208','32','KABUPATEN KUNINGAN'),('3209','32','KABUPATEN CIREBON'),('3210','32','KABUPATEN MAJALENGKA'),('3211','32','KABUPATEN SUMEDANG'),('3212','32','KABUPATEN INDRAMAYU'),('3213','32','KABUPATEN SUBANG'),('3214','32','KABUPATEN PURWAKARTA'),('3215','32','KABUPATEN KARAWANG'),('3216','32','KABUPATEN BEKASI'),('3217','32','KABUPATEN BANDUNG BARAT'),('3218','32','KABUPATEN PANGANDARAN'),('3271','32','KOTA BOGOR'),('3272','32','KOTA SUKABUMI'),('3273','32','KOTA BANDUNG'),('3274','32','KOTA CIREBON'),('3275','32','KOTA BEKASI'),('3276','32','KOTA DEPOK'),('3277','32','KOTA CIMAHI'),('3278','32','KOTA TASIKMALAYA'),('3279','32','KOTA BANJAR'),('3301','33','KABUPATEN CILACAP'),('3302','33','KABUPATEN BANYUMAS'),('3303','33','KABUPATEN PURBALINGGA'),('3304','33','KABUPATEN BANJARNEGARA'),('3305','33','KABUPATEN KEBUMEN'),('3306','33','KABUPATEN PURWOREJO'),('3307','33','KABUPATEN WONOSOBO'),('3308','33','KABUPATEN MAGELANG'),('3309','33','KABUPATEN BOYOLALI'),('3310','33','KABUPATEN KLATEN'),('3311','33','KABUPATEN SUKOHARJO'),('3312','33','KABUPATEN WONOGIRI'),('3313','33','KABUPATEN KARANGANYAR'),('3314','33','KABUPATEN SRAGEN'),('3315','33','KABUPATEN GROBOGAN'),('3316','33','KABUPATEN BLORA'),('3317','33','KABUPATEN REMBANG'),('3318','33','KABUPATEN PATI'),('3319','33','KABUPATEN KUDUS'),('3320','33','KABUPATEN JEPARA'),('3321','33','KABUPATEN DEMAK'),('3322','33','KABUPATEN SEMARANG'),('3323','33','KABUPATEN TEMANGGUNG'),('3324','33','KABUPATEN KENDAL'),('3325','33','KABUPATEN BATANG'),('3326','33','KABUPATEN PEKALONGAN'),('3327','33','KABUPATEN PEMALANG'),('3328','33','KABUPATEN TEGAL'),('3329','33','KABUPATEN BREBES'),('3371','33','KOTA MAGELANG'),('3372','33','KOTA SURAKARTA'),('3373','33','KOTA SALATIGA'),('3374','33','KOTA SEMARANG'),('3375','33','KOTA PEKALONGAN'),('3376','33','KOTA TEGAL'),('3401','34','KABUPATEN KULON PROGO'),('3402','34','KABUPATEN BANTUL'),('3403','34','KABUPATEN GUNUNG KIDUL'),('3404','34','KABUPATEN SLEMAN'),('3471','34','KOTA YOGYAKARTA'),('3501','35','KABUPATEN PACITAN'),('3502','35','KABUPATEN PONOROGO'),('3503','35','KABUPATEN TRENGGALEK'),('3504','35','KABUPATEN TULUNGAGUNG'),('3505','35','KABUPATEN BLITAR'),('3506','35','KABUPATEN KEDIRI'),('3507','35','KABUPATEN MALANG'),('3508','35','KABUPATEN LUMAJANG'),('3509','35','KABUPATEN JEMBER'),('3510','35','KABUPATEN BANYUWANGI'),('3511','35','KABUPATEN BONDOWOSO'),('3512','35','KABUPATEN SITUBONDO'),('3513','35','KABUPATEN PROBOLINGGO'),('3514','35','KABUPATEN PASURUAN'),('3515','35','KABUPATEN SIDOARJO'),('3516','35','KABUPATEN MOJOKERTO'),('3517','35','KABUPATEN JOMBANG'),('3518','35','KABUPATEN NGANJUK'),('3519','35','KABUPATEN MADIUN'),('3520','35','KABUPATEN MAGETAN'),('3521','35','KABUPATEN NGAWI'),('3522','35','KABUPATEN BOJONEGORO'),('3523','35','KABUPATEN TUBAN'),('3524','35','KABUPATEN LAMONGAN'),('3525','35','KABUPATEN GRESIK'),('3526','35','KABUPATEN BANGKALAN'),('3527','35','KABUPATEN SAMPANG'),('3528','35','KABUPATEN PAMEKASAN'),('3529','35','KABUPATEN SUMENEP'),('3571','35','KOTA KEDIRI'),('3572','35','KOTA BLITAR'),('3573','35','KOTA MALANG'),('3574','35','KOTA PROBOLINGGO'),('3575','35','KOTA PASURUAN'),('3576','35','KOTA MOJOKERTO'),('3577','35','KOTA MADIUN'),('3578','35','KOTA SURABAYA'),('3579','35','KOTA BATU'),('3601','36','KABUPATEN PANDEGLANG'),('3602','36','KABUPATEN LEBAK'),('3603','36','KABUPATEN TANGERANG'),('3604','36','KABUPATEN SERANG'),('3671','36','KOTA TANGERANG'),('3672','36','KOTA CILEGON'),('3673','36','KOTA SERANG'),('3674','36','KOTA TANGERANG SELATAN'),('5101','51','KABUPATEN JEMBRANA'),('5102','51','KABUPATEN TABANAN'),('5103','51','KABUPATEN BADUNG'),('5104','51','KABUPATEN GIANYAR'),('5105','51','KABUPATEN KLUNGKUNG'),('5106','51','KABUPATEN BANGLI'),('5107','51','KABUPATEN KARANG ASEM'),('5108','51','KABUPATEN BULELENG'),('5171','51','KOTA DENPASAR'),('5201','52','KABUPATEN LOMBOK BARAT'),('5202','52','KABUPATEN LOMBOK TENGAH'),('5203','52','KABUPATEN LOMBOK TIMUR'),('5204','52','KABUPATEN SUMBAWA'),('5205','52','KABUPATEN DOMPU'),('5206','52','KABUPATEN BIMA'),('5207','52','KABUPATEN SUMBAWA BARAT'),('5208','52','KABUPATEN LOMBOK UTARA'),('5271','52','KOTA MATARAM'),('5272','52','KOTA BIMA'),('5301','53','KABUPATEN SUMBA BARAT'),('5302','53','KABUPATEN SUMBA TIMUR'),('5303','53','KABUPATEN KUPANG'),('5304','53','KABUPATEN TIMOR TENGAH SELATAN'),('5305','53','KABUPATEN TIMOR TENGAH UTARA'),('5306','53','KABUPATEN BELU'),('5307','53','KABUPATEN ALOR'),('5308','53','KABUPATEN LEMBATA'),('5309','53','KABUPATEN FLORES TIMUR'),('5310','53','KABUPATEN SIKKA'),('5311','53','KABUPATEN ENDE'),('5312','53','KABUPATEN NGADA'),('5313','53','KABUPATEN MANGGARAI'),('5314','53','KABUPATEN ROTE NDAO'),('5315','53','KABUPATEN MANGGARAI BARAT'),('5316','53','KABUPATEN SUMBA TENGAH'),('5317','53','KABUPATEN SUMBA BARAT DAYA'),('5318','53','KABUPATEN NAGEKEO'),('5319','53','KABUPATEN MANGGARAI TIMUR'),('5320','53','KABUPATEN SABU RAIJUA'),('5321','53','KABUPATEN MALAKA'),('5371','53','KOTA KUPANG'),('6101','61','KABUPATEN SAMBAS'),('6102','61','KABUPATEN BENGKAYANG'),('6103','61','KABUPATEN LANDAK'),('6104','61','KABUPATEN MEMPAWAH'),('6105','61','KABUPATEN SANGGAU'),('6106','61','KABUPATEN KETAPANG'),('6107','61','KABUPATEN SINTANG'),('6108','61','KABUPATEN KAPUAS HULU'),('6109','61','KABUPATEN SEKADAU'),('6110','61','KABUPATEN MELAWI'),('6111','61','KABUPATEN KAYONG UTARA'),('6112','61','KABUPATEN KUBU RAYA'),('6171','61','KOTA PONTIANAK'),('6172','61','KOTA SINGKAWANG'),('6201','62','KABUPATEN KOTAWARINGIN BARAT'),('6202','62','KABUPATEN KOTAWARINGIN TIMUR'),('6203','62','KABUPATEN KAPUAS'),('6204','62','KABUPATEN BARITO SELATAN'),('6205','62','KABUPATEN BARITO UTARA'),('6206','62','KABUPATEN SUKAMARA'),('6207','62','KABUPATEN LAMANDAU'),('6208','62','KABUPATEN SERUYAN'),('6209','62','KABUPATEN KATINGAN'),('6210','62','KABUPATEN PULANG PISAU'),('6211','62','KABUPATEN GUNUNG MAS'),('6212','62','KABUPATEN BARITO TIMUR'),('6213','62','KABUPATEN MURUNG RAYA'),('6271','62','KOTA PALANGKA RAYA'),('6301','63','KABUPATEN TANAH LAUT'),('6302','63','KABUPATEN KOTA BARU'),('6303','63','KABUPATEN BANJAR'),('6304','63','KABUPATEN BARITO KUALA'),('6305','63','KABUPATEN TAPIN'),('6306','63','KABUPATEN HULU SUNGAI SELATAN'),('6307','63','KABUPATEN HULU SUNGAI TENGAH'),('6308','63','KABUPATEN HULU SUNGAI UTARA'),('6309','63','KABUPATEN TABALONG'),('6310','63','KABUPATEN TANAH BUMBU'),('6311','63','KABUPATEN BALANGAN'),('6371','63','KOTA BANJARMASIN'),('6372','63','KOTA BANJAR BARU'),('6401','64','KABUPATEN PASER'),('6402','64','KABUPATEN KUTAI BARAT'),('6403','64','KABUPATEN KUTAI KARTANEGARA'),('6404','64','KABUPATEN KUTAI TIMUR'),('6405','64','KABUPATEN BERAU'),('6409','64','KABUPATEN PENAJAM PASER UTARA'),('6411','64','KABUPATEN MAHAKAM HULU'),('6471','64','KOTA BALIKPAPAN'),('6472','64','KOTA SAMARINDA'),('6474','64','KOTA BONTANG'),('6501','65','KABUPATEN MALINAU'),('6502','65','KABUPATEN BULUNGAN'),('6503','65','KABUPATEN TANA TIDUNG'),('6504','65','KABUPATEN NUNUKAN'),('6571','65','KOTA TARAKAN'),('7101','71','KABUPATEN BOLAANG MONGONDOW'),('7102','71','KABUPATEN MINAHASA'),('7103','71','KABUPATEN KEPULAUAN SANGIHE'),('7104','71','KABUPATEN KEPULAUAN TALAUD'),('7105','71','KABUPATEN MINAHASA SELATAN'),('7106','71','KABUPATEN MINAHASA UTARA'),('7107','71','KABUPATEN BOLAANG MONGONDOW UTARA'),('7108','71','KABUPATEN SIAU TAGULANDANG BIARO'),('7109','71','KABUPATEN MINAHASA TENGGARA'),('7110','71','KABUPATEN BOLAANG MONGONDOW SELATAN'),('7111','71','KABUPATEN BOLAANG MONGONDOW TIMUR'),('7171','71','KOTA MANADO'),('7172','71','KOTA BITUNG'),('7173','71','KOTA TOMOHON'),('7174','71','KOTA KOTAMOBAGU'),('7201','72','KABUPATEN BANGGAI KEPULAUAN'),('7202','72','KABUPATEN BANGGAI'),('7203','72','KABUPATEN MOROWALI'),('7204','72','KABUPATEN POSO'),('7205','72','KABUPATEN DONGGALA'),('7206','72','KABUPATEN TOLI-TOLI'),('7207','72','KABUPATEN BUOL'),('7208','72','KABUPATEN PARIGI MOUTONG'),('7209','72','KABUPATEN TOJO UNA-UNA'),('7210','72','KABUPATEN SIGI'),('7211','72','KABUPATEN BANGGAI LAUT'),('7212','72','KABUPATEN MOROWALI UTARA'),('7271','72','KOTA PALU'),('7301','73','KABUPATEN KEPULAUAN SELAYAR'),('7302','73','KABUPATEN BULUKUMBA'),('7303','73','KABUPATEN BANTAENG'),('7304','73','KABUPATEN JENEPONTO'),('7305','73','KABUPATEN TAKALAR'),('7306','73','KABUPATEN GOWA'),('7307','73','KABUPATEN SINJAI'),('7308','73','KABUPATEN MAROS'),('7309','73','KABUPATEN PANGKAJENE DAN KEPULAUAN'),('7310','73','KABUPATEN BARRU'),('7311','73','KABUPATEN BONE'),('7312','73','KABUPATEN SOPPENG'),('7313','73','KABUPATEN WAJO'),('7314','73','KABUPATEN SIDENRENG RAPPANG'),('7315','73','KABUPATEN PINRANG'),('7316','73','KABUPATEN ENREKANG'),('7317','73','KABUPATEN LUWU'),('7318','73','KABUPATEN TANA TORAJA'),('7322','73','KABUPATEN LUWU UTARA'),('7325','73','KABUPATEN LUWU TIMUR'),('7326','73','KABUPATEN TORAJA UTARA'),('7371','73','KOTA MAKASSAR'),('7372','73','KOTA PAREPARE'),('7373','73','KOTA PALOPO'),('7401','74','KABUPATEN BUTON'),('7402','74','KABUPATEN MUNA'),('7403','74','KABUPATEN KONAWE'),('7404','74','KABUPATEN KOLAKA'),('7405','74','KABUPATEN KONAWE SELATAN'),('7406','74','KABUPATEN BOMBANA'),('7407','74','KABUPATEN WAKATOBI'),('7408','74','KABUPATEN KOLAKA UTARA'),('7409','74','KABUPATEN BUTON UTARA'),('7410','74','KABUPATEN KONAWE UTARA'),('7411','74','KABUPATEN KOLAKA TIMUR'),('7412','74','KABUPATEN KONAWE KEPULAUAN'),('7413','74','KABUPATEN MUNA BARAT'),('7414','74','KABUPATEN BUTON TENGAH'),('7415','74','KABUPATEN BUTON SELATAN'),('7471','74','KOTA KENDARI'),('7472','74','KOTA BAUBAU'),('7501','75','KABUPATEN BOALEMO'),('7502','75','KABUPATEN GORONTALO'),('7503','75','KABUPATEN POHUWATO'),('7504','75','KABUPATEN BONE BOLANGO'),('7505','75','KABUPATEN GORONTALO UTARA'),('7571','75','KOTA GORONTALO'),('7601','76','KABUPATEN MAJENE'),('7602','76','KABUPATEN POLEWALI MANDAR'),('7603','76','KABUPATEN MAMASA'),('7604','76','KABUPATEN MAMUJU'),('7605','76','KABUPATEN MAMUJU UTARA'),('7606','76','KABUPATEN MAMUJU TENGAH'),('8101','81','KABUPATEN MALUKU TENGGARA BARAT'),('8102','81','KABUPATEN MALUKU TENGGARA'),('8103','81','KABUPATEN MALUKU TENGAH'),('8104','81','KABUPATEN BURU'),('8105','81','KABUPATEN KEPULAUAN ARU'),('8106','81','KABUPATEN SERAM BAGIAN BARAT'),('8107','81','KABUPATEN SERAM BAGIAN TIMUR'),('8108','81','KABUPATEN MALUKU BARAT DAYA'),('8109','81','KABUPATEN BURU SELATAN'),('8171','81','KOTA AMBON'),('8172','81','KOTA TUAL'),('8201','82','KABUPATEN HALMAHERA BARAT'),('8202','82','KABUPATEN HALMAHERA TENGAH'),('8203','82','KABUPATEN KEPULAUAN SULA'),('8204','82','KABUPATEN HALMAHERA SELATAN'),('8205','82','KABUPATEN HALMAHERA UTARA'),('8206','82','KABUPATEN HALMAHERA TIMUR'),('8207','82','KABUPATEN PULAU MOROTAI'),('8208','82','KABUPATEN PULAU TALIABU'),('8271','82','KOTA TERNATE'),('8272','82','KOTA TIDORE KEPULAUAN'),('9101','91','KABUPATEN FAKFAK'),('9102','91','KABUPATEN KAIMANA'),('9103','91','KABUPATEN TELUK WONDAMA'),('9104','91','KABUPATEN TELUK BINTUNI'),('9105','91','KABUPATEN MANOKWARI'),('9106','91','KABUPATEN SORONG SELATAN'),('9107','91','KABUPATEN SORONG'),('9108','91','KABUPATEN RAJA AMPAT'),('9109','91','KABUPATEN TAMBRAUW'),('9110','91','KABUPATEN MAYBRAT'),('9111','91','KABUPATEN MANOKWARI SELATAN'),('9112','91','KABUPATEN PEGUNUNGAN ARFAK'),('9171','91','KOTA SORONG'),('9401','94','KABUPATEN MERAUKE'),('9402','94','KABUPATEN JAYAWIJAYA'),('9403','94','KABUPATEN JAYAPURA'),('9404','94','KABUPATEN NABIRE'),('9408','94','KABUPATEN KEPULAUAN YAPEN'),('9409','94','KABUPATEN BIAK NUMFOR'),('9410','94','KABUPATEN PANIAI'),('9411','94','KABUPATEN PUNCAK JAYA'),('9412','94','KABUPATEN MIMIKA'),('9413','94','KABUPATEN BOVEN DIGOEL'),('9414','94','KABUPATEN MAPPI'),('9415','94','KABUPATEN ASMAT'),('9416','94','KABUPATEN YAHUKIMO'),('9417','94','KABUPATEN PEGUNUNGAN BINTANG'),('9418','94','KABUPATEN TOLIKARA'),('9419','94','KABUPATEN SARMI'),('9420','94','KABUPATEN KEEROM'),('9426','94','KABUPATEN WAROPEN'),('9427','94','KABUPATEN SUPIORI'),('9428','94','KABUPATEN MAMBERAMO RAYA'),('9429','94','KABUPATEN NDUGA'),('9430','94','KABUPATEN LANNY JAYA'),('9431','94','KABUPATEN MAMBERAMO TENGAH'),('9432','94','KABUPATEN YALIMO'),('9433','94','KABUPATEN PUNCAK'),('9434','94','KABUPATEN DOGIYAI'),('9435','94','KABUPATEN INTAN JAYA'),('9436','94','KABUPATEN DEIYAI'),('9471','94','KOTA JAYAPURA');

/*Table structure for table `sipp_kecamatan` */

DROP TABLE IF EXISTS `sipp_kecamatan`;

CREATE TABLE `sipp_kecamatan` (
  `kecamatan_id` char(7) NOT NULL,
  `kabupaten_id` char(4) NOT NULL,
  `kecamatan_nama` varchar(255) NOT NULL,
  PRIMARY KEY (`kecamatan_id`),
  KEY `kecamatan_nama` (`kecamatan_nama`),
  KEY `kabupaten_id` (`kabupaten_id`),
  CONSTRAINT `sipp_kecamatan_ibfk_1` FOREIGN KEY (`kabupaten_id`) REFERENCES `sipp_kabupaten` (`kabupaten_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sipp_kecamatan` */


/*Table structure for table `sipp_kelas` */

DROP TABLE IF EXISTS `sipp_kelas`;

CREATE TABLE `sipp_kelas` (
  `kelas_id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'ID Kelas Pasar',
  `kelas_nama` varchar(50) NOT NULL COMMENT 'Nama Kelas Pasar',
  `kelas_date_update` date NOT NULL,
  `kelas_time_update` time NOT NULL,
  PRIMARY KEY (`kelas_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_kelas` */

insert  into `sipp_kelas`(`kelas_id`,`kelas_nama`,`kelas_date_update`,`kelas_time_update`) values (1,'IA','2016-09-09','13:04:04'),(2,'IB','2016-09-09','11:43:06'),(3,'IIA','2016-09-09','11:43:28'),(4,'IIB','2016-09-09','11:43:39'),(5,'IIIA','2016-09-09','11:43:47'),(6,'IIIB','2016-09-09','11:43:55');

/*Table structure for table `sipp_kepemilikan` */

DROP TABLE IF EXISTS `sipp_kepemilikan`;

CREATE TABLE `sipp_kepemilikan` (
  `kepemilikan_id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'ID Surat Kepemilikan Lahan',
  `kepemilikan_nama` varchar(30) NOT NULL COMMENT 'Nama Pemilik Lahan',
  `kepemilikan_date_update` date NOT NULL,
  `kepemilikan_time_update` time NOT NULL,
  PRIMARY KEY (`kepemilikan_id`),
  KEY `skl_name` (`kepemilikan_nama`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_kepemilikan` */

insert  into `sipp_kepemilikan`(`kepemilikan_id`,`kepemilikan_nama`,`kepemilikan_date_update`,`kepemilikan_time_update`) values (1,'PEMDA','2016-09-08','14:13:37'),(2,'SWASTA','2016-09-08','14:12:16'),(3,'DESA/ADAT','2016-09-08','14:12:24');

/*Table structure for table `sipp_kondisi` */

DROP TABLE IF EXISTS `sipp_kondisi`;

CREATE TABLE `sipp_kondisi` (
  `kondisi_id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'ID Condition',
  `kondisi_nama` varchar(30) NOT NULL COMMENT 'Kondisi Bangunan',
  `kondisi_date_update` date NOT NULL,
  `kondisi_time_update` time NOT NULL,
  PRIMARY KEY (`kondisi_id`),
  KEY `condition_name` (`kondisi_nama`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_kondisi` */

insert  into `sipp_kondisi`(`kondisi_id`,`kondisi_nama`,`kondisi_date_update`,`kondisi_time_update`) values (1,'BERAT','2016-09-08','14:03:00'),(2,'SEDANG','2016-09-08','13:56:10'),(3,'RINGAN','2016-09-08','13:56:16');

/*Table structure for table `sipp_pasar` */

DROP TABLE IF EXISTS `sipp_pasar`;

CREATE TABLE `sipp_pasar` (
  `pasar_id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'ID Pasar',
  `kelas_id` int(2) NOT NULL COMMENT 'ID Kelas',
  `bentuk_id` int(2) NOT NULL COMMENT 'ID Type',
  `kondisi_id` int(2) NOT NULL COMMENT 'ID Kondisi',
  `kepemilikan_id` int(2) NOT NULL COMMENT 'ID SKL',
  `provinsi_id` char(2) DEFAULT NULL COMMENT 'ID Provinsi',
  `kabupaten_id` char(4) DEFAULT NULL COMMENT 'ID Kabupaten',
  `kecamatan_id` char(7) DEFAULT NULL COMMENT 'ID Kecamatan',
  `desa_id` char(10) DEFAULT NULL COMMENT 'ID Desa',
  `pasar_inisial` varchar(2) NOT NULL COMMENT 'Inisial',
  `pasar_kode` varchar(15) NOT NULL COMMENT 'Kode Pasar',
  `pasar_nama` varchar(50) NOT NULL COMMENT 'Nama Pasar',
  `pasar_thn_berdiri` varchar(4) NOT NULL COMMENT 'Tahun Berdiri',
  `pasar_alamat` varchar(100) NOT NULL COMMENT 'Alamat',
  `pasar_lat` float(10,6) DEFAULT NULL COMMENT 'Latitude',
  `pasar_long` float(10,6) DEFAULT NULL COMMENT 'Longitude',
  `pasar_luas_tnh` int(10) DEFAULT '0' COMMENT 'Luas Tanah',
  `pasar_luas_bangun` int(10) DEFAULT '0' COMMENT 'Luas Bangunan',
  `pasar_jml_lantai` int(2) DEFAULT '0' COMMENT 'Jml. Lantai',
  `pasar_jml_blok` int(2) DEFAULT '0' COMMENT 'Jml. Blok',
  `pasar_jml_ruko` int(2) DEFAULT '0' COMMENT 'Jml. Ruko',
  `pasar_jml_kios` int(2) DEFAULT '0' COMMENT 'Jml. Kios',
  `pasar_jml_los` int(2) DEFAULT '0' COMMENT 'Jml. LOS',
  `pasar_jml_dasaran` int(2) DEFAULT '0' COMMENT 'Jml. Dasaran',
  `pasar_operasional` enum('H','M','-') NOT NULL DEFAULT '-' COMMENT 'H=Harian, M=Mingguan',
  `pasar_omzet_hari` int(20) DEFAULT '0' COMMENT 'Omzet Harian',
  `pasar_omzet_minggu` int(20) DEFAULT '0' COMMENT 'Omzet Mingguan',
  `pasar_omzet_bulan` int(20) DEFAULT '0' COMMENT 'Omzet Bulanan',
  `pasar_omzet_tahun` int(20) DEFAULT '0' COMMENT 'Omzet Tahunan',
  `pasar_parkir` int(1) NOT NULL DEFAULT '0' COMMENT 'Fas. Parkir',
  `pasar_mck` int(1) NOT NULL DEFAULT '0' COMMENT 'Fas. MCK',
  `pasar_tps` int(1) NOT NULL DEFAULT '0' COMMENT 'Fas. TPS',
  `pasar_mushola` int(1) NOT NULL DEFAULT '0' COMMENT 'Fas. Tempat Ibadah',
  `pasar_pengelola` enum('Baik','Baru','Cukup','Kurang','-') NOT NULL DEFAULT '-' COMMENT 'Pengelolaan Pasar',
  `pasar_foto` varchar(100) DEFAULT NULL COMMENT 'Foto Pasar',
  `pasar_nip` varchar(30) NOT NULL COMMENT 'NIP',
  `pasar_koordinator` varchar(50) NOT NULL COMMENT 'Koordinator',
  `user_username` varchar(30) NOT NULL COMMENT 'Username',
  `pasar_date_update` date NOT NULL,
  `pasar_time_update` time NOT NULL,
  PRIMARY KEY (`pasar_id`),
  KEY `class_id` (`kelas_id`),
  KEY `type_id` (`bentuk_id`),
  KEY `code_name` (`pasar_kode`,`pasar_nama`),
  KEY `skl_id` (`kepemilikan_id`),
  KEY `provinsi_id` (`provinsi_id`),
  KEY `kabupaten_id` (`kabupaten_id`),
  KEY `kecamatan_id` (`kecamatan_id`),
  KEY `desa_id` (`desa_id`),
  KEY `kondisi_id` (`kondisi_id`),
  CONSTRAINT `sipp_pasar_ibfk_1` FOREIGN KEY (`kelas_id`) REFERENCES `sipp_kelas` (`kelas_id`),
  CONSTRAINT `sipp_pasar_ibfk_3` FOREIGN KEY (`kepemilikan_id`) REFERENCES `sipp_kepemilikan` (`kepemilikan_id`),
  CONSTRAINT `sipp_pasar_ibfk_4` FOREIGN KEY (`provinsi_id`) REFERENCES `sipp_provinsi` (`provinsi_id`),
  CONSTRAINT `sipp_pasar_ibfk_5` FOREIGN KEY (`kabupaten_id`) REFERENCES `sipp_kabupaten` (`kabupaten_id`),
  CONSTRAINT `sipp_pasar_ibfk_6` FOREIGN KEY (`kecamatan_id`) REFERENCES `sipp_kecamatan` (`kecamatan_id`),
  CONSTRAINT `sipp_pasar_ibfk_7` FOREIGN KEY (`desa_id`) REFERENCES `sipp_desa` (`desa_id`),
  CONSTRAINT `sipp_pasar_ibfk_8` FOREIGN KEY (`kondisi_id`) REFERENCES `sipp_kondisi` (`kondisi_id`),
  CONSTRAINT `sipp_pasar_ibfk_9` FOREIGN KEY (`bentuk_id`) REFERENCES `sipp_bentuk` (`bentuk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_pasar` */

insert  into `sipp_pasar`(`pasar_id`,`kelas_id`,`bentuk_id`,`kondisi_id`,`kepemilikan_id`,`provinsi_id`,`kabupaten_id`,`kecamatan_id`,`desa_id`,`pasar_inisial`,`pasar_kode`,`pasar_nama`,`pasar_thn_berdiri`,`pasar_alamat`,`pasar_lat`,`pasar_long`,`pasar_luas_tnh`,`pasar_luas_bangun`,`pasar_jml_lantai`,`pasar_jml_blok`,`pasar_jml_ruko`,`pasar_jml_kios`,`pasar_jml_los`,`pasar_jml_dasaran`,`pasar_operasional`,`pasar_omzet_hari`,`pasar_omzet_minggu`,`pasar_omzet_bulan`,`pasar_omzet_tahun`,`pasar_parkir`,`pasar_mck`,`pasar_tps`,`pasar_mushola`,`pasar_pengelola`,`pasar_foto`,`pasar_nip`,`pasar_koordinator`,`user_username`,`pasar_date_update`,`pasar_time_update`) values (1,3,1,1,1,'33','3319','3319020','3319020025','01','KLWN','PASAR KLIWON','1996','DESA RENDENG',0.000000,0.000000,27681,13380,3,0,0,509,1846,0,'H',0,0,0,0,1,1,1,1,'Baik',NULL,'334343','ALBERTUS HARIEZ','admin','2016-09-11','17:04:05'),(2,3,1,1,1,'33','3319','3319030','3319030008','02','BTG','PASAR BITINGAN','1998','DESA PLOSO',0.000000,0.000000,17410,15428,3,0,0,336,1218,0,'H',0,0,0,0,1,1,1,1,'Cukup',NULL,'44444','SUJADI','admin','2016-09-11','17:06:04');

/*Table structure for table `sipp_pedagang` */

DROP TABLE IF EXISTS `sipp_pedagang`;

CREATE TABLE `sipp_pedagang` (
  `pedagang_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID Pelanggan',
  `pedagang_nik` varchar(16) NOT NULL COMMENT 'NIK KTP',
  `pedagang_nama` varchar(50) NOT NULL COMMENT 'Nama',
  `pedagang_tgl_lahir` date NOT NULL COMMENT 'Tgl. Lahir',
  `pedagang_alamat` varchar(100) NOT NULL COMMENT 'Alamat',
  `provinsi_id` char(2) NOT NULL COMMENT 'Provinsi',
  `kabupaten_id` char(4) NOT NULL COMMENT 'Kabupaten',
  `pedagang_foto` varchar(100) DEFAULT NULL,
  `user_username` varchar(30) NOT NULL,
  `pedagang_date_update` date NOT NULL,
  `pedagang_time_update` time NOT NULL,
  PRIMARY KEY (`pedagang_id`),
  KEY `pedagang_nama` (`pedagang_nama`),
  KEY `pedagang_nik` (`pedagang_nik`),
  KEY `provinsi_id` (`provinsi_id`),
  KEY `kabupaten_id` (`kabupaten_id`),
  CONSTRAINT `sipp_pedagang_ibfk_1` FOREIGN KEY (`provinsi_id`) REFERENCES `sipp_provinsi` (`provinsi_id`),
  CONSTRAINT `sipp_pedagang_ibfk_2` FOREIGN KEY (`kabupaten_id`) REFERENCES `sipp_kabupaten` (`kabupaten_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_pedagang` */

insert  into `sipp_pedagang`(`pedagang_id`,`pedagang_nik`,`pedagang_nama`,`pedagang_tgl_lahir`,`pedagang_alamat`,`provinsi_id`,`kabupaten_id`,`pedagang_foto`,`user_username`,`pedagang_date_update`,`pedagang_time_update`) values (1,'3319042107870002','JAMA\' ROCHMAD MUTTAQIN','1987-07-21','DESA UNDAAN KIDUL RT. 03/01','33','3319','Pedagang_jama-rochmad-muttaqin_1473481570.jpg','admin','2016-09-10','11:47:46'),(2,'3319042107870003','AMBAR SETIYANI','1988-12-05','DUSUN TERSONO','33','3319','Pedagang_ambar-setiyani_1473684780.jpg','admin','2016-09-12','19:53:00'),(3,'3319042107870004','JOKO SANTOSO','1986-09-01','MEJOBO','33','3319',NULL,'admin','2016-09-14','11:27:13');

/*Table structure for table `sipp_petugas` */

DROP TABLE IF EXISTS `sipp_petugas`;

CREATE TABLE `sipp_petugas` (
  `petugas_id` int(1) NOT NULL AUTO_INCREMENT,
  `petugas_nik_kadin` varchar(22) NOT NULL COMMENT 'NIK Kadin Pasar',
  `petugas_nama_kadin` varchar(50) NOT NULL COMMENT 'Nama Kadin',
  `petugas_jab_kadin` varchar(50) DEFAULT NULL COMMENT 'Jabatan Kadin',
  `petugas_title_kadin` text COMMENT 'Title Kadin',
  PRIMARY KEY (`petugas_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_petugas` */

insert  into `sipp_petugas`(`petugas_id`,`petugas_nik_kadin`,`petugas_nama_kadin`,`petugas_jab_kadin`,`petugas_title_kadin`) values (1,'19621229 199208 2 002','Dra. SUDIHARTI','Pembina Tingkat 1','Plt. KEPALA DINAS PERDAGANGAN DAN \r\nPENGELOLAAN PASAR');

/*Table structure for table `sipp_provinsi` */

DROP TABLE IF EXISTS `sipp_provinsi`;

CREATE TABLE `sipp_provinsi` (
  `provinsi_id` char(2) NOT NULL,
  `provinsi_nama` varchar(255) NOT NULL,
  PRIMARY KEY (`provinsi_id`),
  KEY `provinsi_nama` (`provinsi_nama`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sipp_provinsi` */

insert  into `sipp_provinsi`(`provinsi_id`,`provinsi_nama`) values ('11','ACEH'),('51','BALI'),('36','BANTEN'),('17','BENGKULU'),('34','DI YOGYAKARTA'),('31','DKI JAKARTA'),('75','GORONTALO'),('15','JAMBI'),('32','JAWA BARAT'),('33','JAWA TENGAH'),('35','JAWA TIMUR'),('61','KALIMANTAN BARAT'),('63','KALIMANTAN SELATAN'),('62','KALIMANTAN TENGAH'),('64','KALIMANTAN TIMUR'),('65','KALIMANTAN UTARA'),('19','KEPULAUAN BANGKA BELITUNG'),('21','KEPULAUAN RIAU'),('18','LAMPUNG'),('81','MALUKU'),('82','MALUKU UTARA'),('52','NUSA TENGGARA BARAT'),('53','NUSA TENGGARA TIMUR'),('94','PAPUA'),('91','PAPUA BARAT'),('14','RIAU'),('76','SULAWESI BARAT'),('73','SULAWESI SELATAN'),('72','SULAWESI TENGAH'),('74','SULAWESI TENGGARA'),('71','SULAWESI UTARA'),('13','SUMATERA BARAT'),('16','SUMATERA SELATAN'),('12','SUMATERA UTARA');

/*Table structure for table `sipp_tempat` */

DROP TABLE IF EXISTS `sipp_tempat`;

CREATE TABLE `sipp_tempat` (
  `tempat_id` int(2) NOT NULL AUTO_INCREMENT,
  `tempat_nama` varchar(10) NOT NULL,
  `tempat_date_update` date DEFAULT NULL,
  `tempat_time_update` time DEFAULT NULL,
  PRIMARY KEY (`tempat_id`),
  KEY `tempat_nama` (`tempat_nama`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_tempat` */

insert  into `sipp_tempat`(`tempat_id`,`tempat_nama`,`tempat_date_update`,`tempat_time_update`) values (1,'RUKO','2016-09-11','19:51:03'),(2,'KIOS','2016-09-11','19:51:09'),(3,'LOS','2016-09-11','19:51:38');

/*Table structure for table `sipp_tmp_surat` */

DROP TABLE IF EXISTS `sipp_tmp_surat`;

CREATE TABLE `sipp_tmp_surat` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `no` varchar(5) DEFAULT NULL,
  `tahun` int(4) NOT NULL,
  `no_surat` varchar(35) DEFAULT NULL,
  `no_npwrd` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`,`tahun`),
  KEY `no_surat` (`no_surat`),
  KEY `no_npwrd` (`no_npwrd`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sipp_tmp_surat` */

insert  into `sipp_tmp_surat`(`id`,`no`,`tahun`,`no_surat`,`no_npwrd`) values (1,'00008',2016,'511.2/00008/250/KLWN/2016','0105201600008');

/*Table structure for table `sipp_tmp_surat_balik` */

DROP TABLE IF EXISTS `sipp_tmp_surat_balik`;

CREATE TABLE `sipp_tmp_surat_balik` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `no` varchar(5) NOT NULL,
  `tahun` int(4) DEFAULT NULL,
  `no_surat` varchar(19) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `sipp_tmp_surat_balik` */

insert  into `sipp_tmp_surat_balik`(`id`,`no`,`tahun`,`no_surat`) values (1,'00002',2016,'511.2/00002/BN/2016');

/*Table structure for table `sipp_users` */

DROP TABLE IF EXISTS `sipp_users`;

CREATE TABLE `sipp_users` (
  `user_username` varchar(30) NOT NULL COMMENT 'Username',
  `user_password` varchar(100) NOT NULL COMMENT 'Password',
  `user_name` varchar(50) NOT NULL COMMENT 'Nama Lengkap',
  `user_address` text COMMENT 'Alamat',
  `user_phone` varchar(30) DEFAULT NULL COMMENT 'No. Telp',
  `user_level` enum('Admin','Supervisor','Operator') NOT NULL DEFAULT 'Operator' COMMENT 'Level User',
  `user_avatar` varchar(100) DEFAULT NULL COMMENT 'Foto',
  `user_status` enum('Active','Non Active') NOT NULL DEFAULT 'Active' COMMENT 'Status User',
  `user_date_update` date NOT NULL COMMENT 'Date',
  `user_time_update` time NOT NULL COMMENT 'Time',
  PRIMARY KEY (`user_username`),
  KEY `users_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sipp_users` */

insert  into `sipp_users`(`user_username`,`user_password`,`user_name`,`user_address`,`user_phone`,`user_level`,`user_avatar`,`user_status`,`user_date_update`,`user_time_update`) values ('admin','d033e22ae348aeb5660fc2140aec35850c4da997','ADMINISTRATOR WEBSITE','KUDUS','085640969727','Admin','Avatar__1473583293.jpg','Active','2016-09-11','15:42:28'),('eet','fffb4979b2ebcbd7fb3fdbfd7ca6b1a30af0ab7d','EET','HUMANIKA','09988','Supervisor',NULL,'Active','2016-09-11','15:24:50'),('haris','d1fc2cce1d2eb0410522a54beeab67a61b05233a','ALBERTUS HARIS','JEPARA','088989888887','Operator',NULL,'Active','2016-09-11','15:47:06');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;