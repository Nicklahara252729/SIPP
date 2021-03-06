<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Pendasaran_model extends CI_Model {
	var $column_order 	= array(null, 'd.dasar_no', 'd.dasar_sampai', 'd.dasar_npwrd', 'p.penduduk_nama', 's.pasar_nama', 'd.dasar_status', null);
    var $column_search 	= array('d.dasar_no', 'd.dasar_sampai', 'd.dasar_npwrd', 'p.penduduk_nama', 's.pasar_nama', 'd.dasar_status');
    var $order 			= array('d.dasar_id' => 'desc', 's.pasar_nama' => 'asc', 'p.penduduk_nama' => 'asc');

	function __construct() {
		parent::__construct();
	}

	private function _get_datatables_query() {
       	$user_username = $this->session->userdata('username');
		
		if ($this->session->userdata('level', 'true') == 'Admin') {
        	if ($this->input->post('lstPasar', 'true')) {
            	$this->db->where('d.pasar_id', $this->input->post('lstPasar', 'true'));
        	}
        	if ($this->input->post('lstTempat', 'true')) {
            	$this->db->where('d.tempat_id', $this->input->post('lstTempat', 'true'));
        	}
        	if ($this->input->post('blok', 'true')) {
            	$this->db->where('d.dasar_blok', strtoupper($this->input->post('blok', 'true')));
        	}
        	if ($this->input->post('lstStatus', 'true')) {
            	$this->db->where('d.dasar_status', $this->input->post('lstStatus', 'true'));
        	}
        	if ($this->input->post('lstStatusCetak', 'true')) {
            	$this->db->where('d.dasar_st_print', $this->input->post('lstStatusCetak', 'true'));
        	}
        	if ($this->input->post('lstStatusACC', 'true')) {
            	$this->db->where('d.dasar_acc', $this->input->post('lstStatusACC', 'true'));
        	}
        	if ($this->input->post('lstStatusSurat', 'true')) {
            	$this->db->where('d.dasar_data', $this->input->post('lstStatusSurat', 'true'));
        	}

			$this->db->select('d.dasar_id, d.dasar_no, d.dasar_sampai, d.dasar_npwrd, d.dasar_blok, d.dasar_nomor,
			d.dasar_luas, d.dasar_status, d.dasar_st_print, d.dasar_acc, d.dasar_data, p.penduduk_nama, s.pasar_nama, t.tempat_nama');
			$this->db->from('sipp_dasar d');
			$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
			$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
			$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
		} else {
        	if ($this->input->post('lstPasar', 'true')) {
            	$this->db->where('d.pasar_id', $this->input->post('lstPasar', 'true'));
        	}
        	if ($this->input->post('lstTempat', 'true')) {
            	$this->db->where('d.tempat_id', $this->input->post('lstTempat', 'true'));
        	}
        	if ($this->input->post('blok', 'true')) {
            	$this->db->where('d.dasar_blok', strtoupper($this->input->post('blok', 'true')));
        	}
        	if ($this->input->post('lstStatus', 'true')) {
            	$this->db->where('d.dasar_status', $this->input->post('lstStatus', 'true'));
        	}
        	if ($this->input->post('lstStatusCetak', 'true')) {
            	$this->db->where('d.dasar_st_print', $this->input->post('lstStatusCetak', 'true'));
        	}
        	if ($this->input->post('lstStatusACC', 'true')) {
            	$this->db->where('d.dasar_acc', $this->input->post('lstStatusACC', 'true'));
        	}
        	if ($this->input->post('lstStatusSurat', 'true')) {
            	$this->db->where('d.dasar_data', $this->input->post('lstStatusSurat', 'true'));
        	}

			$this->db->select('d.dasar_id, d.dasar_no, d.dasar_sampai, d.dasar_npwrd, d.dasar_blok, d.dasar_nomor,
			d.dasar_luas, d.dasar_status, d.dasar_st_print, d.dasar_acc, d.dasar_data, p.penduduk_nama, s.pasar_nama, t.tempat_nama');
			$this->db->from('sipp_dasar d');
			$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
			$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
			$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
			$this->db->join('sipp_akses a', 's.pasar_id = a.pasar_id');
			$this->db->where('a.user_username', $user_username);
		}

        $i = 0;

        foreach ($this->column_search as $item) {
            if($_POST['search']['value']) {
                if($i===0) {
                    $this->db->group_start();
                    $this->db->like($item, $_POST['search']['value']);
                } else {
                    $this->db->or_like($item, $_POST['search']['value']);
                }
 
                if(count($this->column_search) - 1 == $i)
                    $this->db->group_end();
            }
            $i++;
        }
         
        if(isset($_POST['order'])) {
            $this->db->order_by($this->column_order[$_POST['order']['0']['column']], $_POST['order']['0']['dir']);
        } else if(isset($this->order)) {
            $order = $this->order;
            $this->db->order_by(key($order), $order[key($order)]);
        }
    }
 
    function get_datatables() {
        $this->_get_datatables_query();
        if($_POST['length'] != -1)
        $this->db->limit($_POST['length'], $_POST['start']);
        $query = $this->db->get();
        return $query->result();
    }
 
    function count_filtered() {
        $this->_get_datatables_query();
        $query = $this->db->get();
        return $query->num_rows();
    }

    public function count_all() {
        $user_username = $this->session->userdata('username');
		
		if ($this->session->userdata('level') == 'Admin') {
			$this->db->select('d.dasar_id, d.dasar_no, d.dasar_sampai, d.dasar_npwrd, d.dasar_blok, d.dasar_nomor,
			d.dasar_luas, d.dasar_status, d.dasar_st_print, d.dasar_acc, d.dasar_data, p.penduduk_nama, s.pasar_nama, t.tempat_nama');
			$this->db->from('sipp_dasar d');
			$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
			$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
			$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
		} else {
			$this->db->select('d.dasar_id, d.dasar_no, d.dasar_sampai, d.dasar_npwrd, d.dasar_blok, d.dasar_nomor,
			d.dasar_luas, d.dasar_status, d.dasar_st_print, d.dasar_acc, d.dasar_data, p.penduduk_nama, s.pasar_nama, t.tempat_nama');
			$this->db->from('sipp_dasar d');
			$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
			$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
			$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
			$this->db->join('sipp_akses a', 's.pasar_id = a.pasar_id');
			$this->db->where('a.user_username', $user_username);
		}

        return $this->db->count_all_results();
    }

	/*function select_all() {
		$user_username = $this->session->userdata('username');

		if ($this->session->userdata('level') == 'Admin') {
			$this->db->select('d.*, p.penduduk_nama, s.pasar_nama, t.tempat_nama');
			$this->db->from('sipp_dasar d');
			$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
			$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
			$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
			$this->db->order_by('d.dasar_id','desc');
			$this->db->order_by('d.pasar_id','asc');
			$this->db->order_by('d.dasar_blok','asc');
			$this->db->order_by('d.dasar_nomor','asc');

			return $this->db->get();
		} else {
			$this->db->select('d.*, p.penduduk_nama, s.pasar_nama, t.tempat_nama');
			$this->db->from('sipp_dasar d');
			$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
			$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
			$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
			$this->db->join('sipp_akses a', 's.pasar_id = a.pasar_id');
			$this->db->where('a.user_username', $user_username);
			$this->db->order_by('d.dasar_id','desc');
			$this->db->order_by('d.pasar_id','asc');
			$this->db->order_by('d.dasar_blok','asc');
			$this->db->order_by('d.dasar_nomor','asc');

			return $this->db->get();
		}
	}*/

	function select_pasar() {
		$user_username = $this->session->userdata('username');

		if ($this->session->userdata('level') == 'Admin') {
			$this->db->select('p.*, k.kecamatan_nama, d.desa_nama');
			$this->db->from('sipp_pasar p');
			$this->db->join('sipp_kecamatan k', 'p.kecamatan_id = k.kecamatan_id');
			$this->db->join('sipp_desa d', 'p.desa_id = d.desa_id');
			$this->db->order_by('p.pasar_nama', 'asc');

			return $this->db->get();
		} else {
			$this->db->select('p.*, k.kecamatan_nama, d.desa_nama');
			$this->db->from('sipp_pasar p');
			$this->db->join('sipp_kecamatan k', 'p.kecamatan_id = k.kecamatan_id');
			$this->db->join('sipp_desa d', 'p.desa_id = d.desa_id');
			$this->db->join('sipp_akses a', 'p.pasar_id = a.pasar_id');
			$this->db->where('a.user_username', $user_username);
			$this->db->order_by('p.pasar_nama', 'asc');

			return $this->db->get();
		}
	}

	function select_tempat() {
		$this->db->select('*');
		$this->db->from('sipp_tempat');
		$this->db->order_by('tempat_id', 'asc');

		return $this->db->get();
	}

	function select_penduduk_cari($nama) {
		$this->db->select('p.*, v.provinsi_nama, k.kabupaten_nama, c.kecamatan_nama, d.desa_nama');
		$this->db->from('sipp_penduduk p');
		$this->db->join('sipp_provinsi v', 'p.provinsi_id = v.provinsi_id');
		$this->db->join('sipp_kabupaten k', 'p.kabupaten_id = k.kabupaten_id');
		$this->db->join('sipp_kecamatan c', 'p.kecamatan_id = c.kecamatan_id');
		$this->db->join('sipp_desa d', 'p.desa_id = d.desa_id');
		$this->db->or_like('p.penduduk_nik', $nama);
		$this->db->or_like('p.penduduk_nama', $nama);
		$this->db->limit(20);

		return $this->db->get();
	}

	function select_penduduk($penduduk_id) {
		$this->db->select('p.*, v.provinsi_nama, k.kabupaten_nama, c.kecamatan_nama, d.desa_nama');
		$this->db->from('sipp_penduduk p');
		$this->db->join('sipp_provinsi v', 'p.provinsi_id = v.provinsi_id');
		$this->db->join('sipp_kabupaten k', 'p.kabupaten_id = k.kabupaten_id');
		$this->db->join('sipp_kecamatan c', 'p.kecamatan_id = c.kecamatan_id');
		$this->db->join('sipp_desa d', 'p.desa_id = d.desa_id');
		$this->db->where('p.penduduk_id', $penduduk_id);

		return $this->db->get();
	}

	function select_jenis() {
		$this->db->select('*');
		$this->db->from('sipp_jenis');
		$this->db->order_by('jenis_nama', 'asc');

		return $this->db->get();
	}

	function getkodeuniksurat() {
		// Tahun Pembuatan Surat
		$tanggal 		= date('Y-m-d');
		$xtgl1 			= explode("-",$tanggal);
		$thn1 			= $xtgl1[0];

		$this->db->select('RIGHT(no, 5) as kode', FALSE);
		$this->db->where('id', 1);
		$this->db->where('tahun', $thn1);

		$query = $this->db->get('sipp_tmp_surat');
		if ($query->num_rows() <> 0) {
			$data = $query->row();
			$kode = intval($data->kode) + 1;
		} else {
			$kode = 1;
		}

		$nourut = str_pad($kode, 5, "0", STR_PAD_LEFT);
		$kodesurat = '511.2/'.$nourut;
		return $kodesurat;
   	}

   	function getkodeuniknpwrd() {
   		// Tahun Pembuatan Surat
		$tanggal 		= date('Y-m-d');
		$xtgl1 			= explode("-",$tanggal);
		$thn1 			= $xtgl1[0];

        $this->db->select('RIGHT(no, 5) as kode', FALSE);
		$this->db->where('id', 1);
		$this->db->where('tahun', $thn1);

		$query = $this->db->get('sipp_tmp_surat');
		if ($query->num_rows() <> 0) {
			$data = $query->row();
			$kode = intval($data->kode) + 1;
		} else {
			$kode = 1;
		}

		$nourut = str_pad($kode, 5, "0", STR_PAD_LEFT);
		return $nourut;
   	}

	function insert_data() {
		// Update Foto
		if (!empty($_FILES['userfile']['name'])) {
			$data = array(
					'penduduk_foto' 		=> $this->upload->file_name,
			   		'user_username' 		=> $this->session->userdata('username'),
			   		'penduduk_date_update' 	=> date('Y-m-d'),
			   		'penduduk_time_update' 	=> date('Y-m-d H:i:s')
			);
		} else {
			$data = array(
			   		'user_username' 		=> $this->session->userdata('username'),
			   		'penduduk_date_update' 	=> date('Y-m-d'),
			   		'penduduk_time_update' 	=> date('Y-m-d H:i:s')
			);
		}
		$penduduk_id = $this->input->post('penduduk_id');
		$this->db->where('penduduk_id', $penduduk_id);
		$this->db->update('sipp_penduduk', $data);

		// Tgl. Surat
		$tgl_surat 		= $this->input->post('tgl_surat');
		$xtgl 			= explode("-",$tgl_surat);
		$thn 			= $xtgl[2];
		$bln 			= $xtgl[1];
		$tgl 			= $xtgl[0];
		$tanggal_srt 	= $thn.'-'.$bln.'-'.$tgl;
		// Dari Tanggal
		$tgl_dari 		= $this->input->post('tgl1');
		$xtgld 			= explode("-",$tgl_dari);
		$thnd 			= $xtgld[2];
		$blnd 			= $xtgld[1];
		$tgld 			= $xtgld[0];
		$tanggal_dari 	= $thnd.'-'.$blnd.'-'.$tgld;
		// Sampai Tanggal
		$tgl_sampai 	= $this->input->post('tgl2');
		$xtgls 			= explode("-",$tgl_sampai);
		$thns 			= $xtgls[2];
		$blns 			= $xtgls[1];
		$tgls 			= $xtgls[0];
		$tanggal_sampai	= $thns.'-'.$blns.'-'.$tgls;

		// Tahun Pembuatan Surat
		$tanggal 		= date('Y-m-d');
		$xtgl1 			= explode("-",$tanggal);
		$tahun 			= $xtgl1[0];
		// Nomor
		$nomor 			= strtoupper(trim($this->input->post('nomor')));
		// Kode Pasar
		$kode_pasar		= trim($this->input->post('pasar_kode'));
		// No Surat
		$nosurat 		= $this->pendasaran_model->getkodeuniksurat();
		$No_Surat 		= $nosurat.'/'.$nomor.'/'.$kode_pasar.'/'.$tahun; // 511.2/No Urut/Nomor/Kode Pasar/Tahun Surat
		// NPWRD = KodePasar+KodeJenis+Tahun+NoUrut
		$kodepasar 		= trim($this->input->post('pasar_inisial'));
		$jenisdagang 	= trim($this->input->post('jenis_kode'));
		$no_urut 		= $this->pendasaran_model->getkodeuniknpwrd();
		$No_NPWRD		= $kodepasar.$jenisdagang.$tahun.$no_urut;

		// Update Temporary Surat
		$data = array(
				'no_surat'		=> strtoupper(trim($No_Surat)),
				'no_npwrd'		=> strtoupper(trim($No_NPWRD)),
				'tahun'			=> $tahun,
				'no'			=> $no_urut
			);

		$this->db->where('id', 1);
		$this->db->update('sipp_tmp_surat', $data);

		// Insert ke Tabel Pendasaran
		$data = array(
				'dasar_no'				=> strtoupper(trim($No_Surat)),
				'dasar_npwrd'			=> strtoupper(trim($No_NPWRD)),
				'penduduk_id'			=> $this->input->post('penduduk_id'),
				'pasar_id'				=> $this->input->post('lstPasar'),
				'jenis_id'				=> $this->input->post('lstJenis'),
				'tempat_id'				=> $this->input->post('rdTempat'),
				'dasar_tgl_surat'		=> $tanggal_srt,
				'dasar_dari'			=> $tanggal_dari,
				'dasar_sampai'			=> $tanggal_sampai,
				'dasar_blok'			=> strtoupper(trim($this->input->post('blok'))),
				'dasar_nomor'			=> strtoupper(trim($this->input->post('nomor'))),
				'dasar_panjang'			=> $this->input->post('panjang'),
				'dasar_lebar'			=> $this->input->post('lebar'),
				'dasar_luas'			=> $this->input->post('luas'),
				'dasar_bts_utara'		=> strtoupper($this->input->post('utara')),
				'dasar_bts_selatan'		=> strtoupper($this->input->post('selatan')),
				'dasar_bts_timur'		=> strtoupper($this->input->post('timur')),
				'dasar_bts_barat'		=> strtoupper($this->input->post('barat')),
		   		'user_username' 		=> $this->session->userdata('username'),
		   		'dasar_date_update' 	=> date('Y-m-d'),
		   		'dasar_time_update' 	=> date('Y-m-d H:i:s')
		);

		$this->db->insert('sipp_dasar', $data);
	}

	function update_data_acc() {
		$dasar_id = $this->uri->segment(4);

		$data = array(
				'dasar_acc' => 2
		);

		$this->db->where('dasar_id', $dasar_id);
		$this->db->update('sipp_dasar', $data);
	}

	function select_detail_by_id($dasar_id) {
		$this->db->select('d.*, p.*, v.provinsi_nama, b.kabupaten_nama, k.kecamatan_nama, e.desa_nama,
							s.pasar_inisial, s.pasar_nama, s.pasar_kode, s.pasar_alamat, kc.kecamatan_nama as kecamatan_pasar,
							ds.desa_nama as desa_pasar, j.jenis_kode, j.jenis_nama, t.tempat_nama');
		$this->db->from('sipp_dasar d');
		$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
		$this->db->join('sipp_provinsi v', 'p.provinsi_id = v.provinsi_id');
		$this->db->join('sipp_kabupaten b', 'p.kabupaten_id = b.kabupaten_id');
		$this->db->join('sipp_kecamatan k', 'p.kecamatan_id = k.kecamatan_id');
		$this->db->join('sipp_desa e', 'p.desa_id = e.desa_id');
		$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
		$this->db->join('sipp_kecamatan kc', 's.kecamatan_id = kc.kecamatan_id');
		$this->db->join('sipp_desa ds', 's.desa_id = ds.desa_id');
		$this->db->join('sipp_jenis j', 'd.jenis_id = j.jenis_id');
		$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
		$this->db->where('d.dasar_id', $dasar_id);

		return $this->db->get();
	}

	function update_data() {
		// Update Foto
		if (!empty($_FILES['userfile']['name'])) {
			$data = array(
					'penduduk_foto' 		=> $this->upload->file_name,
			   		'user_username' 		=> $this->session->userdata('username'),
			   		'penduduk_date_update' 	=> date('Y-m-d'),
			   		'penduduk_time_update' 	=> date('Y-m-d H:i:s')
			);
		} else {
			$data = array(
			   		'user_username' 		=> $this->session->userdata('username'),
			   		'penduduk_date_update' 	=> date('Y-m-d'),
			   		'penduduk_time_update' 	=> date('Y-m-d H:i:s')
			);
		}

		$penduduk_id = $this->input->post('penduduk_id');
		$this->db->where('penduduk_id', $penduduk_id);
		$this->db->update('sipp_penduduk', $data);

		$dasar_id    	= $this->input->post('id');

		// Tgl. Surat
		$tgl_surat 		= $this->input->post('tgl_surat');
		$xtgl 			= explode("-",$tgl_surat);
		$thn 			= $xtgl[2];
		$bln 			= $xtgl[1];
		$tgl 			= $xtgl[0];
		$tanggal_srt 	= $thn.'-'.$bln.'-'.$tgl;
		// Dari Tanggal
		$tgl_dari 		= $this->input->post('tgl1');
		$xtgld 			= explode("-",$tgl_dari);
		$thnd 			= $xtgld[2];
		$blnd 			= $xtgld[1];
		$tgld 			= $xtgld[0];
		$tanggal_dari 	= $thnd.'-'.$blnd.'-'.$tgld;
		// Sampai Tanggal
		$tgl_sampai 	= $this->input->post('tgl2');
		$xtgls 			= explode("-",$tgl_sampai);
		$thns 			= $xtgls[2];
		$blns 			= $xtgls[1];
		$tgls 			= $xtgls[0];
		$tanggal_sampai	= $thns.'-'.$blns.'-'.$tgls;

		$data = array(
				'penduduk_id'			=> $this->input->post('penduduk_id'),
				'jenis_id'				=> $this->input->post('lstJenis'),
				'tempat_id'				=> $this->input->post('rdTempat'),
				'dasar_tgl_surat'		=> $tanggal_srt,
				'dasar_dari'			=> $tanggal_dari,
				'dasar_sampai'			=> $tanggal_sampai,
				'dasar_blok'			=> strtoupper(trim($this->input->post('blok'))),
				'dasar_nomor'			=> strtoupper(trim($this->input->post('nomor'))),
				'dasar_panjang'			=> $this->input->post('panjang'),
				'dasar_lebar'			=> $this->input->post('lebar'),
				'dasar_luas'			=> $this->input->post('luas'),
				'dasar_bts_utara'		=> strtoupper($this->input->post('utara')),
				'dasar_bts_selatan'		=> strtoupper($this->input->post('selatan')),
				'dasar_bts_timur'		=> strtoupper($this->input->post('timur')),
				'dasar_bts_barat'		=> strtoupper($this->input->post('barat')),
		   		'user_username' 		=> $this->session->userdata('username'),
		   		'dasar_date_update' 	=> date('Y-m-d'),
		   		'dasar_time_update' 	=> date('Y-m-d H:i:s')
		);

		$this->db->where('dasar_id', $dasar_id);
		$this->db->update('sipp_dasar', $data);
	}

	function update_data_print() {
		$dasar_id    	= $this->uri->segment(4);

		$data = array(
				'dasar_st_print'		=> 2,
				'dasar_tgl_print'		=> date('Y-m-d'),
		   		'user_username' 		=> $this->session->userdata('username'),
		   		'dasar_date_update' 	=> date('Y-m-d'),
		   		'dasar_time_update' 	=> date('Y-m-d H:i:s')
		);

		$this->db->where('dasar_id', $dasar_id);
		$this->db->update('sipp_dasar', $data);
	}

/*	function select_detail_preview($dasar_id) {
		$this->db->select('d.*, p.penduduk_nik, p.penduduk_nama, p.penduduk_tgl_lahir, p.penduduk_alamat, p.penduduk_foto, s.pasar_nama, s.pasar_alamat, k.kabupaten_nama, e.provinsi_nama, j.jenis_nama, t.tempat_nama');
		$this->db->from('sipp_dasar d');
		$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
		$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
		$this->db->join('sipp_jenis j', 'd.jenis_id = j.jenis_id');
		$this->db->join('sipp_provinsi e', 'p.provinsi_id = e.provinsi_id');
		$this->db->join('sipp_kabupaten k', 'p.kabupaten_id = k.kabupaten_id');
		$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
		$this->db->where('d.dasar_id', $dasar_id);

		return $this->db->get();
	}
*/

	function select_petugas() {
		$this->db->select('*');
		$this->db->from('sipp_petugas');
		$this->db->where('petugas_id', 1);

		return $this->db->get();
	}

	function insert_data_perpanjangan() {
		$dasar_id    	= $this->input->post('id');
		// Tgl. Surat
		$tgl_surat 		= $this->input->post('tgl_surat');
		$xtgl 			= explode("-",$tgl_surat);
		$thn 			= $xtgl[2];
		$bln 			= $xtgl[1];
		$tgl 			= $xtgl[0];
		$tanggal_srt 	= $thn.'-'.$bln.'-'.$tgl;
		// Dari Tanggal
		$tgl_dari 		= $this->input->post('tgl1');
		$xtgld 			= explode("-",$tgl_dari);
		$thnd 			= $xtgld[2];
		$blnd 			= $xtgld[1];
		$tgld 			= $xtgld[0];
		$tanggal_dari 	= $thnd.'-'.$blnd.'-'.$tgld;
		// Sampai Tanggal
		$tgl_sampai 	= $this->input->post('tgl2');
		$xtgls 			= explode("-",$tgl_sampai);
		$thns 			= $xtgls[2];
		$blns 			= $xtgls[1];
		$tgls 			= $xtgls[0];
		$tanggal_sampai	= $thns.'-'.$blns.'-'.$tgls;

		// Tahun Pembuatan Surat
		$tanggal 		= date('Y-m-d');
		$xtgl1 			= explode("-",$tanggal);
		$tahun 			= $xtgl1[0];
		// Nomor
		$nomor 			= strtoupper(trim($this->input->post('nomor')));
		// Kode Pasar
		$kode_pasar		= trim($this->input->post('pasar_kode'));
		// No Surat
		$nosurat 		= $this->pendasaran_model->getkodeuniksurat();
		$No_Surat 		= $nosurat.'/'.$nomor.'/'.$kode_pasar.'/'.$tahun; // 511.2/No Urut/Nomor/Kode Pasar/Tahun Surat
		// No Urut
		$no_urut 		= $this->pendasaran_model->getkodeuniknpwrd();
		$No_NPWRD 		= $this->input->post('npwrd');

		// Update Surat Lama jadi di Perpanjang
		$data = array(
				'dasar_data'		=> 2
			);

		$this->db->where('dasar_id', $dasar_id);
		$this->db->update('sipp_dasar', $data);

		// Update Temporary Surat
		$data = array(
				'no_surat'		=> strtoupper(trim($No_Surat)),
				'no_npwrd'		=> strtoupper(trim($No_NPWRD)),
				'tahun'			=> $tahun,
				'no'			=> $no_urut
			);

		$this->db->where('id', 1);
		$this->db->update('sipp_tmp_surat', $data);

		// Insert ke Tabel Pendasaran
		$data = array(
				'dasar_no'				=> strtoupper(trim($No_Surat)),
				'dasar_npwrd'			=> $this->input->post('npwrd'),
				'dasar_no_lama'			=> $this->input->post('no_surat_lama'),
				'dasar_status'			=> 'Perpanjangan',
				'penduduk_id'			=> $this->input->post('penduduk_id'),
				'pasar_id'				=> $this->input->post('pasar_id'),
				'jenis_id'				=> $this->input->post('jenis_id'),
				'tempat_id'				=> $this->input->post('rdTempat'),
				'dasar_tgl_surat'		=> $tanggal_srt,
				'dasar_dari'			=> $tanggal_dari,
				'dasar_sampai'			=> $tanggal_sampai,
				'dasar_blok'			=> strtoupper(trim($this->input->post('blok'))),
				'dasar_nomor'			=> strtoupper(trim($this->input->post('nomor'))),
				'dasar_panjang'			=> $this->input->post('panjang'),
				'dasar_lebar'			=> $this->input->post('lebar'),
				'dasar_luas'			=> $this->input->post('luas'),
		   		'user_username' 		=> $this->session->userdata('username'),
		   		'dasar_date_update' 	=> date('Y-m-d'),
		   		'dasar_time_update' 	=> date('Y-m-d H:i:s')
		);

		$this->db->insert('sipp_dasar', $data);
	}

	function check_data_skrd($kode) {
		$this->db->select('dasar_id');
		$this->db->from('sipp_skrd');
		$this->db->where('dasar_id', $kode);

		return $this->db->get();
	}

	function delete_data($kode) {
		$this->db->where('dasar_id', $kode);
		$this->db->delete('sipp_dasar');
	}

	function update_data_acc_all() {
		$data = array(
				'dasar_acc' => 2
		);

		$this->db->where('dasar_acc', 1);
		$this->db->update('sipp_dasar', $data);
	}


	function select_data_export() {
		$lstPasar 		= $this->input->post('lstPasar', 'true');
		$lstTempat 		= $this->input->post('lstTempat', 'true');
		$blok 			= $this->input->post('blok', 'true');
		$lstStatus 		= $this->input->post('lstStatus', 'true');
		$lstStatusCetak = $this->input->post('lstStatusCetak', 'true');
		$lstStatusACC 	= $this->input->post('lstStatusACC', 'true');
		$lstStatusSurat = $this->input->post('lstStatusSurat', 'true');

		$this->db->select('d.dasar_npwrd, p.penduduk_nik, p.penduduk_nama, p.penduduk_tmpt_lhr, p.penduduk_tgl_lahir, p.penduduk_alamat,
			v.provinsi_nama, b.kabupaten_nama, k.kecamatan_nama, e.desa_nama, t.tempat_nama, s.pasar_nama, d.dasar_blok, d.dasar_nomor, 
			d.dasar_panjang, d.dasar_lebar, j.jenis_nama, d.dasar_dari, d.dasar_sampai, d.dasar_status, d.dasar_data, d.dasar_acc, 
			d.dasar_st_print');
		$this->db->from('sipp_dasar d');
		$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
		$this->db->join('sipp_provinsi v', 'p.provinsi_id = v.provinsi_id');
		$this->db->join('sipp_kabupaten b', 'p.kabupaten_id = b.kabupaten_id');
		$this->db->join('sipp_kecamatan k', 'p.kecamatan_id = k.kecamatan_id');
		$this->db->join('sipp_desa e', 'p.desa_id = e.desa_id');
		$this->db->join('sipp_pasar s', 'd.pasar_id = s.pasar_id');
		$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
		$this->db->join('sipp_jenis j', 'd.jenis_id = j.jenis_id');

		if ($this->input->post('lstPasar', 'true')) {
            $this->db->where('d.pasar_id', $this->input->post('lstPasar', 'true'));
        }
        if ($lstTempat <> 'all') {
            $this->db->where('d.tempat_id', $this->input->post('lstTempat', 'true'));
        }
        if ($this->input->post('blok', 'true')) {
            $this->db->where('d.dasar_blok', strtoupper($this->input->post('blok', 'true')));
        }
        if ($lstStatus <> 'all') {
            $this->db->where('d.dasar_status', $this->input->post('lstStatus', 'true'));
        }
        if ($lstStatusCetak <> 'all') {
            $this->db->where('d.dasar_st_print', $this->input->post('lstStatusCetak', 'true'));
        }
        if ($lstStatusACC <> 'all') {
            $this->db->where('d.dasar_acc', $this->input->post('lstStatusACC', 'true'));
        }
        if ($lstStatusSurat <> 'all') {
            $this->db->where('d.dasar_data', $this->input->post('lstStatusSurat', 'true'));
        }

        return $this->db->get();
	}
}
/* Location: ./application/model/admin/Pendasaran_model.php */