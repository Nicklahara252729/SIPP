<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Lap1_model extends CI_Model {
	function __construct() {
		parent::__construct();	
	}
		
	function select_pasar() {
		$this->db->select('*');
		$this->db->from('sipp_pasar');		
		$this->db->order_by('pasar_id', 'asc');
		
		return $this->db->get();
	}

	function select_tempat() {
		$this->db->select('*');
		$this->db->from('sipp_tempat');		
		$this->db->order_by('tempat_id', 'asc');
		
		return $this->db->get();
	}

	function select_by_criteria() {
		$pasar_id	= trim($this->input->post('lstPasar'));
		$tempat_id 	= trim($this->input->post('lstTempat'));
		
		if ($tempat_id == 'all') {
			$this->db->select('d.dasar_npwrd, d.dasar_blok, d.dasar_nomor, d.dasar_luas, d.dasar_status, 
				p.penduduk_nama, p.penduduk_alamat, v.provinsi_nama, b.kabupaten_nama, 
				k.kecamatan_nama, s.desa_nama, r.pasar_nama, t.tempat_nama');
			$this->db->from('sipp_dasar d');
			$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
			$this->db->join('sipp_pasar r', 'd.pasar_id = r.pasar_id');
			$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
			$this->db->join('sipp_provinsi v', 'p.provinsi_id = v.provinsi_id');
			$this->db->join('sipp_kabupaten b', 'p.kabupaten_id = b.kabupaten_id');
			$this->db->join('sipp_kecamatan k', 'p.kecamatan_id = k.kecamatan_id');
			$this->db->join('sipp_desa s', 'p.desa_id = s.desa_id');
			$this->db->where('d.pasar_id', $pasar_id);
			$this->db->where('d.dasar_data', 0);
			$this->db->order_by('d.pasar_id','asc');
			$this->db->order_by('d.tempat_id','asc');
			$this->db->order_by('d.penduduk_id','asc');
				
			return $this->db->get();
		} else {
			$this->db->select('d.dasar_npwrd, d.dasar_blok, d.dasar_nomor, d.dasar_luas, d.dasar_status, 
				p.penduduk_nama, p.penduduk_alamat, v.provinsi_nama, b.kabupaten_nama, 
				k.kecamatan_nama, s.desa_nama, r.pasar_nama, t.tempat_nama');
			$this->db->from('sipp_dasar d');
			$this->db->join('sipp_penduduk p', 'd.penduduk_id = p.penduduk_id');
			$this->db->join('sipp_pasar r', 'd.pasar_id = r.pasar_id');
			$this->db->join('sipp_tempat t', 'd.tempat_id = t.tempat_id');
			$this->db->join('sipp_provinsi v', 'p.provinsi_id = v.provinsi_id');
			$this->db->join('sipp_kabupaten b', 'p.kabupaten_id = b.kabupaten_id');
			$this->db->join('sipp_kecamatan k', 'p.kecamatan_id = k.kecamatan_id');
			$this->db->join('sipp_desa s', 'p.desa_id = s.desa_id');
			$this->db->where('d.pasar_id', $pasar_id);
			$this->db->where('d.tempat_id', $tempat_id);
			$this->db->where('d.dasar_data', 0);
			$this->db->order_by('d.pasar_id','asc');
			$this->db->order_by('d.tempat_id','asc');
			$this->db->order_by('d.penduduk_id','asc');
				
			return $this->db->get();
		}
	}		
}
/* Location: ./application/model/admin/Lap1_model.php */